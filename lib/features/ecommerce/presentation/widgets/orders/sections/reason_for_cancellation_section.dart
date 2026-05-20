import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/radio/app_circle_radio.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

class CancellationReasonOption {
  final String id;
  final String label;

  const CancellationReasonOption({required this.id, required this.label});
}

class ReasonForCancellationSection extends StatefulWidget {
  final List<CancellationReasonOption> cancellationReasons;
  final int refundAmount;
  final ValueChanged<String>? onReasonSelected;
  final ValueChanged<String>? onOtherReasonChanged;

  /// 🔥 FIXED: multi-image callback
  final ValueChanged<List<File>>? onImagesChanged;

  const ReasonForCancellationSection({
    super.key,
    required this.cancellationReasons,
    required this.refundAmount,
    this.onReasonSelected,
    this.onOtherReasonChanged,
    this.onImagesChanged,
  });

  @override
  State<ReasonForCancellationSection> createState() =>
      _ReasonForCancellationSectionState();
}

class _ReasonForCancellationSectionState
    extends State<ReasonForCancellationSection> {
  late String _selectedReasonId;
  late TextEditingController _otherReasonController;

  final List<File> _selectedImages = [];
  bool _isUploading = false;

  final ImagePicker _imagePicker = ImagePicker();

  static const int _maxImages = 5;

  @override
  void initState() {
    super.initState();

    _selectedReasonId = widget.cancellationReasons.isNotEmpty
        ? widget.cancellationReasons.first.id
        : '';

    _otherReasonController = TextEditingController();

    /// Notify initial selection
    if (_selectedReasonId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onReasonSelected?.call(_selectedReasonId);
      });
    }
  }

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  /// 🔥 FIXED IMAGE PICKER
  Future<void> _pickImages() async {
    if (_selectedImages.length >= _maxImages) {
      ToastService.show('You can upload up to $_maxImages images');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final pickedFiles = await _imagePicker.pickMultiImage();

      if (pickedFiles.isEmpty) return;

      final newFiles = pickedFiles
          .map((e) => File(e.path))
          .where(
            (file) =>
                !_selectedImages.any((existing) => existing.path == file.path),
          )
          .toList();

      final remainingSlots = _maxImages - _selectedImages.length;

      final filesToAdd = newFiles.take(remainingSlots).toList();

      setState(() {
        _selectedImages.addAll(filesToAdd);
      });

      /// 🔥 Send full list to parent
      widget.onImagesChanged?.call(_selectedImages);
    } catch (e) {
      if (!mounted) return;
      ToastService.showError('Failed to pick images');
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  /// 🔥 REMOVE IMAGE
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });

    widget.onImagesChanged?.call(_selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AppText.h1(
              'Reason for Return',
              color: const Color(0xFF260B01),
              fontSize: 16.sp,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          SizedBox(height: 10.h),

          /// RADIO OPTIONS
          ...widget.cancellationReasons.map(
            (reason) => _buildRadioOption(reason.id, reason.label),
          ),

          SizedBox(height: 10.h),

          /// OTHER TEXT FIELD
          if (_selectedReasonId == 'others') ...[
            AppTextField(
              label: 'Other reason for cancellation',
              controller: _otherReasonController,
              height: 70.h,
              isTextArea: true,
              minLines: 3,
              onChanged: (value) {
                widget.onOtherReasonChanged?.call(value);
              },
            ),
            SizedBox(height: 10.h),
          ],

          /// UPLOAD BUTTON
          AppButton(
            label: 'Upload Pictures',
            width: null,
            height: 32.h,
            size: AppButtonSize.small,
            variant: AppButtonVariant.outlined,
            isLoading: _isUploading,
            trailingIcon: !_isUploading
                ? AppIcon(
                    AppIcons.svg.generic.upload,
                    size: 16.sp,
                    color: const Color(0xFF1B1B1B),
                  )
                : null,
            onPressed: _isUploading ? null : _pickImages,
          ),

          SizedBox(height: 12.h),

          /// IMAGE PREVIEW
          if (_selectedImages.isNotEmpty) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_selectedImages.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            _selectedImages[index],
                            width: 80.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: AppCircleButton(
                            icon: AppIcons.svg.generic.close,
                            onTap: () => _removeImage(index),
                            size: AppCircleButtonSize.small,
                            bgColor: AppColors.buttonPrimaryBg.withValues(
                              alpha: 0.6,
                            ),
                            iconColor: AppColors.white,
                            visualSize: 18.r,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 16.h),
          ],

          /// REFUND ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h1(
                'Refund amount',
                color: const Color(0xFF49454F),
                fontSize: 14.sp,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              AppText.h1(
                'INR ${widget.refundAmount}',
                color: const Color(0xFF49454F),
                fontSize: 16.sp,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String id, String label) {
    return AppCircleRadio(
      label: label,
      isSelected: _selectedReasonId == id,
      onTap: () {
        setState(() {
          _selectedReasonId = id;
        });
        widget.onReasonSelected?.call(id);
      },
      borderRadius: 8.r,
      borderColor: const Color(0xFFE8DDD7),
      backgroundColor: Colors.white,
      selectedBackgroundColor: Colors.white,
    );
  }
}
