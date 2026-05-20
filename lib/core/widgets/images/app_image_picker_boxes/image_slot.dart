import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_picker_boxes/empty_slot_content.dart';

class ImageSlot extends StatelessWidget {
  const ImageSlot({
    super.key,
    required this.imageFile,
    required this.title,
    required this.onTap,
    required this.onDelete,
  });

  final File? imageFile;
  final String title;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imageFile != null;
    final borderRadius = 18.r;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            border: Border.all(color: const Color(0xFFE6E6E6)),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (hasImage)
                  Image.file(imageFile!, fit: BoxFit.cover)
                else
                  EmptySlotContent(title: title),
                if (hasImage)
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: onDelete,
                      child: AppIcon(
                        AppIcons.svg.generic.delete,
                        width: 20.w,
                        color: AppColors.white,
                        height: 20.w,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
