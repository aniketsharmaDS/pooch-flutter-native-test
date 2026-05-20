import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/utils/url_utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppImageCachedWidget extends StatelessWidget {
  const AppImageCachedWidget({
    super.key,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    this.borderRadius,
  });

  final String imageUrl;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  String? get _resolvedImageUrl => resolveNetworkImageUrl(imageUrl);

  String? _buildStableCacheKey(String resolvedUrl) {
    final uri = Uri.tryParse(resolvedUrl);
    if (uri == null) {
      return resolvedUrl;
    }

    if (uri.path.isEmpty) {
      return resolvedUrl;
    }

    return uri.path;
  }

  int? _resolveMemCacheDimension(double? dimension, double devicePixelRatio) {
    if (dimension == null || !dimension.isFinite || dimension <= 0) {
      return null;
    }

    final scaledDimension = (dimension * devicePixelRatio).round();
    return min(max(scaledDimension, 64), 4096);
  }

  Widget _buildShimmerPlaceholder() {
    return Skeletonizer(
      // enabled: true,
      child: Skeleton.leaf(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: borderRadius,
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.broken_image_outlined,
        color: Colors.grey.shade500,
        size: 22,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resolvedBorderRadius = borderRadius ?? BorderRadius.zero;
    final devicePixelRatio = MediaQuery.maybeDevicePixelRatioOf(context) ?? 1;
    final resolvedImageUrl = _resolvedImageUrl;

    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: resolvedBorderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(borderRadius: resolvedBorderRadius),
          child: resolvedImageUrl == null || resolvedImageUrl.isEmpty
              ? _buildErrorWidget()
              : CachedNetworkImage(
                  imageUrl: resolvedImageUrl,
                  cacheKey: _buildStableCacheKey(resolvedImageUrl),
                  fit: boxFit,
                  useOldImageOnUrlChange: true,
                  memCacheWidth: _resolveMemCacheDimension(
                    width,
                    devicePixelRatio,
                  ),
                  memCacheHeight: _resolveMemCacheDimension(
                    height,
                    devicePixelRatio,
                  ),
                  placeholder: (BuildContext context, String url) =>
                      _buildShimmerPlaceholder(),
                  errorWidget:
                      (BuildContext context, String url, Object error) =>
                          _buildErrorWidget(),
                ),
        ),
      ),
    );
  }
}
