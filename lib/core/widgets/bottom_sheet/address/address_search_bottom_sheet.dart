import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poochcare/core/config/app_config.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';

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
    final userProfile = getIt<UserProfileBloc>().state.profile;
    log(
      'User profile in AddressSearchBottomSheet: '
      '${userProfile?.country} | ${userProfile?.countryCode}',
    );
    if (userProfile != null) {
      final countryCode = (userProfile.countryCode).trim().toLowerCase();

      final country = (userProfile.country).trim().toLowerCase();

      final isIndia =
          countryCode == '91' || countryCode == '+91' || country == 'in';

      return isIndia ? 'IN' : 'AE';
    }

    return (PlatformDispatcher.instance.locale.countryCode ?? 'IN')
        .toUpperCase();
  }

  static String cleanAddress(String address) {
    final parts = address.split(', ');

    if (parts.isNotEmpty && parts.first.contains('+')) {
      parts.removeAt(0);
    }

    return parts.join(', ');
  }

  /// Fetch place details
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
        ),
        placeId: placeId,
        latitude: (location['lat'] as num).toDouble(),
        longitude: (location['lng'] as num).toDouble(),
      );
    } catch (e) {
      log('Place details error: $e');
      return null;
    }
  }

  static Future<AddressResult?> show({
    required BuildContext context,
    String title = 'Search Address',
    Future<void> Function(AddressResult result)? onSelectedApiCall,
  }) {
    final controller = TextEditingController();

    // final focusNode = FocusNode();

    final resultsNotifier = ValueNotifier<List<AddressResult>>([]);

    final loadingNotifier = ValueNotifier<bool>(false);

    Timer? debounce;

    Future<void> search(String query) async {
      if (query.trim().isEmpty) {
        resultsNotifier.value = [];
        return;
      }

      loadingNotifier.value = true;

      final countryCode = getCountryCode();

      final url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json'
          '?input=${Uri.encodeComponent(query)}'
          '&key=$_apiKey'
          '&components=country:$countryCode';

      log('Google Places API URL: $url');

      try {
        final res = await http.get(Uri.parse(url));

        final data = json.decode(res.body);

        if (data['status'] != 'OK' && data['status'] != 'ZERO_RESULTS') {
          resultsNotifier.value = [];
          loadingNotifier.value = false;
          return;
        }

        final predictions = data['predictions'] as List;

        resultsNotifier.value = predictions
            .map(
              (e) => AddressResult(
                description: e['description']?.toString() ?? '',
                placeId: e['place_id']?.toString() ?? '',
                latitude: 0.0,
                longitude: 0.0,
              ),
            )
            .toList();
      } catch (e) {
        log('Autocomplete error: $e');
        resultsNotifier.value = [];
      }

      loadingNotifier.value = false;
    }

    return AppBottomSheet.show<AddressResult>(
      context: context,
      title: title,
      initialHeightFactor: 0.8,
      actions: const [],
      content: Column(
        children: [
          /// SEARCH FIELD
          AppSearchField(
            hintText: 'Search location',
            controller: controller,
            // focusNode: focusNode,
            onChanged: (value) {
              debounce?.cancel();

              debounce = Timer(const Duration(milliseconds: 1000), () {
                search(value);
              });
            },
            onSubmitted: (value) {
              debounce?.cancel();
              search(value);
            },
          ),

          const SizedBox(height: 16),

          /// RESULTS
          ValueListenableBuilder<bool>(
            valueListenable: loadingNotifier,
            builder: (_, isLoading, _) {
              if (isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return ValueListenableBuilder<List<AddressResult>>(
                valueListenable: resultsNotifier,
                builder: (_, results, _) {
                  if (results.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('No results'),
                    );
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

                          final enriched = await _getPlaceDetails(
                            item.placeId,
                            item.description,
                          );

                          if (enriched == null) return;

                          /// optional API call
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
    ).whenComplete(() {
      debounce?.cancel();
      controller.dispose();
      // focusNode.dispose();
      resultsNotifier.dispose();
      loadingNotifier.dispose();
    });
  }
}
