import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoListItemCardShimmer extends StatelessWidget {
  final double? width;
  final double imageHeight;

  const VideoListItemCardShimmer({
    super.key,
    this.width,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(AppSpacing.s15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadiusSize.r15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail shimmer
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadiusSize.r15),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: imageHeight,
                    color: Colors.grey.shade300,
                  ),

                  /// Play button circle shimmer
                  Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),

            AppSpacing.s10.hBox,

            /// Title (2 lines)
            _bar(height: 12, width: double.infinity),
            const SizedBox(height: 4),
            _bar(height: 12, width: 150),

            AppSpacing.s6.hBox,

            /// Description (2 lines)
            _bar(height: 10, width: double.infinity),
            const SizedBox(height: 4),
            _bar(height: 10, width: 180),

            AppSpacing.s10.hBox,

            /// Duration row
            Row(
              children: [
                _bar(height: 14, width: 14, radius: 7),
                const SizedBox(width: 6),
                _bar(height: 10, width: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar({
    required double height,
    required double width,
    double radius = 6,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
