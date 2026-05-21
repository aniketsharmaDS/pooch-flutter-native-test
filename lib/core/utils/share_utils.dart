import 'dart:ui';

import 'package:share_plus/share_plus.dart';

/// Utility class for sharing content using share_plus package
class ShareUtils {
  ShareUtils._();

  /// Shares content with title and description to available applications
  ///
  /// [title] - The title of the content to share
  /// [description] - The description/body text to share
  /// [sharePositionOrigin] - Optional position for iPad share popup (required for iPad)
  ///
  /// Returns [ShareResult] containing the sharing status
  static Future<ShareResult> shareContent({
    required String title,
    required String description,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final String content = '$title\n\n$description';

      final ShareResult result = await SharePlus.instance.share(
        ShareParams(
          text: content,
          subject: title,
          sharePositionOrigin: sharePositionOrigin,
        ),
      );

      return result;
    } catch (e) {
      // Handle any errors during sharing
      rethrow;
    }
  }

  /// Shares content with title, description and optional files
  ///
  /// [title] - The title of the content to share
  /// [description] - The description/body text to share
  /// [files] - Optional list of file paths to share
  /// [sharePositionOrigin] - Optional position for iPad share popup
  ///
  /// Returns [ShareResult] containing the sharing status
  static Future<ShareResult> shareContentWithFiles({
    required String title,
    required String description,
    List<String>? files,
    Rect? sharePositionOrigin,
  }) async {
    try {
      final String content = '$title\n\n$description';

      if (files != null && files.isNotEmpty) {
        final List<XFile> xFiles = files.map((path) => XFile(path)).toList();

        final ShareResult result = await SharePlus.instance.share(
          ShareParams(
            files: xFiles,
            text: content,
            subject: title,
            sharePositionOrigin: sharePositionOrigin,
          ),
        );

        return result;
      } else {
        return await shareContent(
          title: title,
          description: description,
          sharePositionOrigin: sharePositionOrigin,
        );
      }
    } catch (e) {
      // Handle any errors during sharing
      rethrow;
    }
  }
}
