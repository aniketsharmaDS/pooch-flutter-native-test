import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poochcare/core/config/app_config.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';

class AddressResult {
  final String description;
  final String placeId;
  final double latitude;
  final double longitude;

  AddressResult({
    required this.description,
    required this.placeId,
    required this.latitude,
    required this.longitude,
  });
}

class AddressSearchBottomSheet {
  static final String _apiKey = AppConfig.googlePlacesApiKey ?? '';

  static String getCountryCode() {
    return (PlatformDispatcher.instance.locale.countryCode ?? 'IN')
        .toLowerCase();
  }

  static String cleanAddress(String address) {
    final parts = address.split(', ');

    if (parts.isNotEmpty && parts.first.contains('+')) {
      parts.removeAt(0);
    }

    return parts.join(', ');
  }

  /// 🔥 NEW: Fetch lat/lng + formatted address
  static Future<AddressResult?> _getPlaceDetails(
    String placeId,
    String fallbackDescription,
  ) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json'
        '?place_id=$placeId'
        '&fields=geometry,formatted_address'
        '&key=$_apiKey';

    try {
      final res = await http.get(Uri.parse(url));
      final data = json.decode(res.body);

      if (data['status'] != 'OK') return null;

      final result = data['result'];
      final location = result['geometry']['location'];

      return AddressResult(
        description: cleanAddress(
          result['formatted_address']?.toString() ?? fallbackDescription,
        ), // ✅ formatted
        placeId: placeId,
        latitude: (location['lat'] as num).toDouble(),
        longitude: (location['lng'] as num).toDouble(),
      );
    } catch (_) {
      return null;
    }
  }

  static Future<AddressResult?> show({
    required BuildContext context,
    String title = 'Search Address',
    Future<void> Function(AddressResult result)? onSelectedApiCall,
  }) {
    final controller = TextEditingController();
    final resultsNotifier = ValueNotifier<List<AddressResult>>([]);
    final loadingNotifier = ValueNotifier<bool>(false);

    Future<void> search(String query) async {
      if (query.isEmpty) {
        resultsNotifier.value = [];
        return;
      }

      loadingNotifier.value = true;

      final countryCode = getCountryCode();

      final url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json'
          '?input=$query'
          '&key=$_apiKey'
          '&components=country:$countryCode';

      log('Google Places API URL: $url');

      try {
        final res = await http.get(Uri.parse(url));
        final data = json.decode(res.body);

        final predictions = data['predictions'] as List;

        resultsNotifier.value = predictions
            .map(
              (e) => AddressResult(
                description: e['description']?.toString() ?? '',
                placeId: e['place_id']?.toString() ?? '',
                latitude: 0.0, // placeholder
                longitude: 0.0, // placeholder
              ),
            )
            .toList();
      } catch (_) {
        resultsNotifier.value = [];
      }

      loadingNotifier.value = false;
    }

    return AppBottomSheet.show<AddressResult>(
      context: context,
      title: title,
      content: Column(
        children: [
          /// 🔍 SEARCH FIELD
          ValueListenableBuilder<bool>(
            valueListenable: loadingNotifier,
            builder: (_, isLoading, _) {
              return AppSearchField(
                hintText: 'Search location',
                controller: controller,
                isLoading: isLoading,
                onChanged: (value) {
                  search(value);
                },
                onSubmitted: (value) {
                  search(value);
                },
              );
            },
          ),
          const SizedBox(height: 16),

          /// 📍 RESULTS
          ValueListenableBuilder<bool>(
            valueListenable: loadingNotifier,
            builder: (_, isLoading, _) {
              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return ValueListenableBuilder<List<AddressResult>>(
                valueListenable: resultsNotifier,
                builder: (_, results, _) {
                  if (results.isEmpty) {
                    return const Text('No results');
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: results.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (_, index) {
                      final item = results[index];

                      return ListTile(
                        title: Text(item.description),
                        onTap: () async {
                          FocusScope.of(context).unfocus();

                          /// 🔥 Fetch full details (lat/lng + formatted address)
                          final enriched = await _getPlaceDetails(
                            item.placeId,
                            item.description,
                          );

                          if (enriched == null) return;

                          /// optional API call after selection
                          if (onSelectedApiCall != null) {
                            await onSelectedApiCall(enriched);
                          }

                          if (context.mounted) {
                            Navigator.pop(context, enriched);
                          }
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      actions: const [],
      initialHeightFactor: 0.8,
    ).whenComplete(() {
      // Optional: safe cleanup if you want later
      // FocusManager.instance.primaryFocus?.unfocus();
      // Future.microtask(() {
      //   controller.dispose();
      //   resultsNotifier.dispose();
      //   loadingNotifier.dispose();
      //   debounce?.cancel();
      // });
    });
  }
}
