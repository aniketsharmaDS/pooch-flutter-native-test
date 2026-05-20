import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductGridItemCardShimmer extends StatelessWidget {
  const ProductGridItemCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Material(
        borderRadius: BorderRadius.circular(AppRadiusSize.r16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s10),
              child: ClipPath(
                clipper: EightShapeClipper(),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s10,
                  AppSpacing.s3,
                  AppSpacing.s10,
                  AppSpacing.s6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _bar(height: 14, width: double.infinity),
                        ),
                        const SizedBox(width: 6),
                        _bar(height: 18, width: 18, radius: 9),
                      ],
                    ),
                    const SizedBox(height: 2),
                    _bar(height: 12, width: 72),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        _bar(height: 14, width: 50),
                        const SizedBox(width: 10),
                        _bar(height: 12, width: 40),
                      ],
                    ),
                    const SizedBox(height: 2),
                    _bar(height: 12, width: 90),
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _bar(height: 20, width: 96, radius: 6),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar({required double height, required double width, double? radius}) {
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
