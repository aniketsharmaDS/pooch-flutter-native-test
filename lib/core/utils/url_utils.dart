import 'package:poochcare/core/utils/env.dart';

/// Normalizes backend-provided image references into an absolute network URL.
///
/// Supports:
/// - Full URLs: https://...
/// - Host-only URLs: pooch-developments.s3.amazonaws.com/...
/// - Relative paths: pets/... or pet/...
String? resolveNetworkImageUrl(String? rawUrl) {
  final value = rawUrl?.trim();
  if (value == null || value.isEmpty) return null;

  // Public base URL for serving assets (can be CloudFront or any public host).
  // If not provided, we fall back to direct S3 bucket access.
  final base = (Env.s3PublicBaseUrl).trim();
  final normalizedBase = base.endsWith('/')
      ? base.substring(0, base.length - 1)
      : base;

  if (value.startsWith('http://') || value.startsWith('https://')) {
    // If the URL points to a known transient placeholder service (mock/test data),
    // treat it as missing so the UI shows a local placeholder image instead of
    // attempting a network fetch that may fail and generate noise in crash logs.
    final uri = Uri.tryParse(value);
    if (uri != null && uri.host.isNotEmpty) {
      final host = uri.host.toLowerCase();
      // Common public placeholder hosts used in mocks
      const knownPlaceholderHosts = ['via.placeholder.com', 'placehold.it'];
      if (knownPlaceholderHosts.any((h) => host.contains(h))) {
        return '';
      }

      // Never rewrite signed/presigned URLs; the signature is bound to the full
      // URL (including host and query params) and rewriting would invalidate it.
      if (uri.hasQuery) {
        return value;
      }

      final isS3Host =
          host.contains('s3.amazonaws.com') || host.contains('.s3.');
      final shouldRewrite =
          isS3Host && !normalizedBase.contains('s3.amazonaws.com');
      if (shouldRewrite) {
        return '$normalizedBase${uri.path}';
      }
    }
    return value;
  }

  if (value.startsWith('//')) {
    return 'https:$value';
  }

  // host-only values like "pooch-developments.s3.amazonaws.com/..."
  if (value.contains('s3.amazonaws.com') && !value.contains('://')) {
    final asAbsolute = 'https://$value';
    final uri = Uri.tryParse(asAbsolute);
    if (uri != null && uri.host.isNotEmpty) {
      final host = uri.host.toLowerCase();
      final isS3Host =
          host.contains('s3.amazonaws.com') || host.contains('.s3.');
      final shouldRewrite =
          isS3Host && !normalizedBase.contains('s3.amazonaws.com');
      if (shouldRewrite) {
        return '$normalizedBase${uri.path}';
      }
    }
    return asAbsolute;
  }

  final normalizedPath = value.startsWith('/') ? value.substring(1) : value;
  return '$normalizedBase/$normalizedPath';
}
