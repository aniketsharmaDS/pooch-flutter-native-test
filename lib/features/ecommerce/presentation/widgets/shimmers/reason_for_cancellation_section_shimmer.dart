import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReasonForCancellationSectionShimmer extends StatelessWidget {
  const ReasonForCancellationSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s16.w,
          vertical: AppSpacing.s16.h,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE SHIMMER
            _shimmerBar(height: 18, width: 150),
            SizedBox(height: 16.h),

            /// RADIO OPTIONS SHIMMER (3 options)
            ..._buildRadioOptionsShimmer(count: 3),

            SizedBox(height: 16.h),

            /// UPLOAD PICTURE BUTTON SHIMMER
            _shimmerBar(height: 32, width: double.infinity, radius: 6),
            SizedBox(height: 30.h),

            /// REFUND AMOUNT ROW SHIMMER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBar(height: 16, width: 120),
                _shimmerBar(height: 16, width: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds multiple radio option shimmers
  List<Widget> _buildRadioOptionsShimmer({required int count}) {
    return List.generate(
      count,
      (index) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: _buildRadioOptionShimmer(),
      ),
    );
  }

  /// Single radio option shimmer
  Widget _buildRadioOptionShimmer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE8DDD7), width: 1.5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          /// Circle Radio Button
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 1.5),
            ),
          ),
          SizedBox(width: 12.w),

          /// Label Text
          _shimmerBar(height: 14, width: 150),
        ],
      ),
    );
  }

  /// Generic shimmer bar
  Widget _shimmerBar({
    required double height,
    required double width,
    double? radius,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius ?? 6),
      ),
    );
  }
}
