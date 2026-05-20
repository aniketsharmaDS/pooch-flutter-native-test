import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';

/// Maps API-provided splash content onto the local intro transition models.
/// - Does not mutate the original local list.
/// - Sorts API items by `order` ascending.
/// - Overrides only `title`, `subtitle`, `imagePath` per requirements.
List<IntroTransitionModel> mapSplashContent({
  required List<IntroTransitionModel> localScreens,
  required List<dynamic>? apiSplashList,
}) {
  if (apiSplashList == null || apiSplashList.isEmpty) {
    return List<IntroTransitionModel>.from(localScreens);
  }

  // Make a safe copy of API list and sort by 'order' (ascending)
  final List<Map<String, dynamic>> apiItems = apiSplashList
      .whereType<Map<String, dynamic>>()
      .toList(growable: false)
      .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
      .toList(growable: true);

  int parseOrder(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) {
      return int.tryParse(v) ?? 0;
    }
    return 0;
  }

  apiItems.sort(
    (a, b) => parseOrder(a['order']).compareTo(parseOrder(b['order'])),
  );

  final int maxOverride = apiItems.length < localScreens.length
      ? apiItems.length
      : localScreens.length;

  // Build a new list, copying local models and overriding selectively.
  final List<IntroTransitionModel> result = <IntroTransitionModel>[];

  for (int i = 0; i < localScreens.length; i++) {
    final local = localScreens[i];

    if (i < maxOverride) {
      final Map<String, dynamic> api = apiItems[i];

      String? apiTitle = api['title']?.toString().trim().replaceAll(
        r'\n',
        '\n',
      );
      String? apiDescription = api['description']?.toString().trim();
      String? apiImageUrl = api['imageUrl']?.toString().trim();

      final String titleToUse = (apiTitle != null && apiTitle.isNotEmpty)
          ? apiTitle
          : local.title;

      final String subtitleToUse =
          (apiDescription != null && apiDescription.isNotEmpty)
          ? apiDescription
          : local.subtitle;

      final String imagePathToUse =
          (apiImageUrl != null && apiImageUrl.isNotEmpty)
          ? apiImageUrl
          : local.imagePath;

      result.add(
        local.copyWith(
          title: titleToUse,
          subtitle: subtitleToUse,
          imagePath: imagePathToUse,
        ),
      );
    } else {
      // No override for this index, copy local model as-is.
      result.add(local.copyWith());
    }
  }

  return result;
}

/// Usage example:
///
/// final localScreens = getIntroTransitionScreen();
/// final updatedScreens = mapSplashContent(
///   localScreens: localScreens,
///   apiSplashList: response.data.splashList,
/// );
///
/// Runtime image fallback example (widget):
/// Image.network(
///   imageUrl,
///   errorBuilder: (_, __, ___) => Image.asset(localFallbackImage),
/// )
