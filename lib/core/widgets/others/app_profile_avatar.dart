import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_file_picker/app_file_picker.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';

enum ActionPosition { rightBottom, rightCenter }

enum AppProfileAvatarVariant { avatar, actionButton }

class AppProfileAvatar extends StatelessWidget {
  final double size;
  final double? containerHeight;
  final Color? containerBgColor;
  final Color? containerBorderColor;
  final File? localImageFile;
  final String? imageUrl;
  final String? placeholder;
  final VoidCallback? onTapAvatar;
  final Future<void> Function(File file)? onFileSelected;
  final String actionIcon;
  final double actionSize;
  final ActionPosition actionPosition;
  final AppProfileAvatarVariant variant;

  const AppProfileAvatar({
    super.key,
    this.size = 120,
    this.containerHeight,
    this.containerBgColor,
    this.containerBorderColor,
    this.localImageFile,
    this.imageUrl,
    this.placeholder,
    this.onTapAvatar,
    this.onFileSelected,
    required this.actionIcon,
    this.actionSize = 50,
    this.actionPosition = ActionPosition.rightBottom,
    this.variant = AppProfileAvatarVariant.avatar,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == AppProfileAvatarVariant.actionButton) {
      final double height = containerHeight ?? size;
      final Color bgColor = containerBgColor ?? AppColors.white_50;
      final Color borderColor = containerBorderColor ?? AppColors.white;

      Widget actionButton() {
        return AppCircleButton(
          iconColor: AppColors.p4_300,
          onTap: onTapAvatar ?? () => _handleActionTap(context),
          icon: actionIcon,
          size: AppCircleButtonSize.xlarge,
          variant: AppCircleButtonVariant.secondary,
        );
      }

      if (localImageFile != null) {
        return Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadiusSize.r20.rr),
            color: bgColor,
            border: Border.all(color: borderColor),
            image: DecorationImage(
              image: FileImage(localImageFile!),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [Positioned.fill(child: Center(child: actionButton()))],
          ),
        );
      }

      if ((imageUrl ?? '').isNotEmpty && imageUrl != null) {
        return Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadiusSize.r20.rr),
            color: bgColor,
            border: Border.all(color: borderColor),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadiusSize.r20.rr),
                  child: AppImageCachedWidget(
                    imageUrl: imageUrl!,
                    height: height,
                    width: double.infinity,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              Positioned.fill(child: Center(child: actionButton())),
            ],
          ),
        );
      }

      return Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadiusSize.r20.rr),
          color: bgColor,
          border: Border.all(color: borderColor),
        ),
        child: Stack(
          children: [
            Positioned.fill(child: Center(child: _buildAvatarContent())),
            Positioned.fill(child: Center(child: actionButton())),
          ],
        ),
      );
    }

    return SizedBox(
      width: 140,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white_50,
            ),
            child: ClipOval(child: _buildAvatarContent()),
          ),
          Align(
            alignment: actionPosition == ActionPosition.rightBottom
                ? const Alignment(1.0, 0.7)
                : const Alignment(1.1, 0.4),
            child: Transform.translate(
              offset: const Offset(6, 6),
              child: AppCircleButton(
                iconSize: actionSize,
                bgColor: AppColors.white,
                onTap: onTapAvatar ?? () => _handleActionTap(context),
                icon: actionIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (localImageFile != null) {
      return Image.file(localImageFile!, fit: BoxFit.cover);
    }

    if ((imageUrl ?? '').isNotEmpty && imageUrl != null) {
      return AppImageCachedWidget(
        imageUrl: imageUrl!,
        borderRadius: BorderRadius.circular(size / 2),
      );
    }

    if (placeholder != null && placeholder!.trim().isNotEmpty) {
      return AppIcon(placeholder!.trim(), size: size * 0.45);
    }

    // return AppIcon(
    //   AppIcons.png.generic.placeholder,
    //   size: size * 0.45,
    // );
    return Container(
      width: size * 0.45,
      height: size * 0.45,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.p5_50,
        // color: Color(0xFFF3F3F3)
      ),
      child: const Icon(
        Icons.person,
        size: AppIconSize.is50,
        color: AppColors.white,
      ),
    );
  }

  Future<void> _handleActionTap(BuildContext context) async {
    if (onFileSelected == null) {
      return;
    }

    final selectedFiles = await AppFilePicker.openImagePickerSheet(
      context: context,
    );

    if (!context.mounted || (selectedFiles ?? []).isEmpty) {
      return;
    }

    await onFileSelected!(selectedFiles!.first);
  }
}
