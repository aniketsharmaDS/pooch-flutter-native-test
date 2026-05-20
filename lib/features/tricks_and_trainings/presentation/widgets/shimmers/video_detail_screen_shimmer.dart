import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';

class VideoDetailsScreenShimmer extends StatelessWidget {
  const VideoDetailsScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Video player shimmer
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(color: Colors.grey.shade300),
          ),

          AppSpacing.s16.hBox,

          /// Title shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bar(width: double.infinity, height: 18),
                const SizedBox(height: 8),
                _bar(width: 200, height: 14),
              ],
            ),
          ),

          // AppSpacing.s24.hBox,
        ],
      ),
    );
  }

  Widget _bar({required double width, required double height}) {
    return Container(width: width, height: height, color: Colors.grey.shade300);
  }
}
