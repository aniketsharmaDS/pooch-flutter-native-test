import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ProfileAvatar extends StatelessWidget {
  final File? localImageFile;
  final String? networkImage;
  final String? initials;
  final double size;
  final VoidCallback? onTap;
  final Object? heroTag;

  const ProfileAvatar({
    super.key,
    this.localImageFile,
    this.networkImage,
    this.initials,
    this.size = 96,
    this.onTap,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final double s =
        AppSpacing.s32.sp * (size / 32); // Base size is 32, scale accordingly
    Widget avatar;
    if (localImageFile != null) {
      avatar = Image.file(localImageFile!, fit: BoxFit.cover);
    } else if (networkImage != null && networkImage!.isNotEmpty) {
      // Log the URL we're trying to load — helps debug missing images
      avatar = AppImageCachedWidget(
        imageUrl: networkImage!,

        // placeholder: _placeholder(context),
      );
    } else if (initials != null && initials!.trim().isNotEmpty) {
      avatar = Center(child: AppText.bodyS(initials!.toUpperCase()));
    } else {
      avatar = Icon(
        Icons.person_outline,
        // size: 32.sp,
        size: AppSpacing.s32.sp,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
      );
    }

    final clipped = ClipOval(child: avatar);
    final heroWrapped = heroTag != null
        ? Hero(tag: heroTag!, child: clipped)
        : clipped;

    final tappable = onTap != null
        ? GestureDetector(onTap: onTap, child: heroWrapped)
        : heroWrapped;

    return Container(
      width: s,
      height: s,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: tappable,
    );
  }
}
