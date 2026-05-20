import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class MyChatItemModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String messagePreview;
  final String time;

  const MyChatItemModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.messagePreview,
    required this.time,
  });
}

class MyChatListItemCard extends StatelessWidget {
  final MyChatItemModel item;
  final VoidCallback? onTap;

  const MyChatListItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSpacing.s70.h,
        margin: EdgeInsets.symmetric(vertical: AppSpacing.s8.h),
        padding: EdgeInsets.all(AppSpacing.s12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: , width: 1.w),
          borderRadius: BorderRadius.circular(AppSpacing.s12.r),
        ),
        child: Row(
          children: [
            // Profile Image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.s60.r),
              child: SizedBox(
                width: AppSpacing.s50.w,
                height: AppSpacing.s50.h,
                child: AppImageCachedWidget(imageUrl: item.avatarUrl),
              ),
            ),
            AppSpacing.s10.wBox,

            // Chat Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name and Time Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppText.bodyM(
                          item.name,
                          color: const Color(0xFF521703),
                          maxLines: 1,
                        ),
                      ),
                      AppSpacing.s8.wBox,
                      AppText.bodyS(item.time, color: const Color(0xFFA7A7A8)),
                    ],
                  ),
                  AppSpacing.s4.hBox,

                  // Last Message
                  AppText.bodyS(
                    item.messagePreview,
                    color: const Color(0xFFB3958B),
                    style: const TextStyle(height: 1),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
