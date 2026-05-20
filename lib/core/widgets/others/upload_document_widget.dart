import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:poochcare/core/services/image_picker_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/document_file_icon_utils.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class UploadDocumentWidget extends StatefulWidget {
  final String? title;
  final String? description;
  final String buttonText;
  final Future<void> Function()? onUploadTap;
  final bool isUploading;
  final double? progress;
  final bool allowMultiple;
  final List<File> initialFiles;
  final ValueChanged<List<File>>? onFilesChanged;
  final String uploadedSectionTitle;
  final String supportedFormatsLabel;
  final String maxSizeLabel;
  final String? customeSupport;
  final bool? showHeader;
  final String? headerText;

  const UploadDocumentWidget({
    super.key,
    this.title,
    this.description,
    required this.buttonText,
    this.onUploadTap,
    this.isUploading = false,
    this.progress,
    this.allowMultiple = true,
    this.initialFiles = const [],
    this.onFilesChanged,
    this.customeSupport,
    this.uploadedSectionTitle = 'Uploaded documents',
    this.supportedFormatsLabel = 'PDF, JPG, PNG',
    this.maxSizeLabel = 'Max 10MB',
    this.showHeader = false,
    this.headerText = 'Upload Documents',
  });

  @override
  State<UploadDocumentWidget> createState() => _UploadDocumentWidgetState();
}

class _UploadDocumentWidgetState extends State<UploadDocumentWidget> {
  final ImagePickerService _imagePickerService = ImagePickerService();
  late List<File> _uploadedFiles;

  @override
  void initState() {
    super.initState();
    _uploadedFiles = List<File>.from(widget.initialFiles);
  }

  @override
  void didUpdateWidget(covariant UploadDocumentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isSameFileSet(oldWidget.initialFiles, widget.initialFiles)) {
      _uploadedFiles = List<File>.from(widget.initialFiles);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHeader == true) ...[
          Container(
            padding: EdgeInsets.only(bottom: AppSpacing.s10.w),
            child: AppText.h3(widget.headerText!, color: AppColors.p4_900),
          ),
        ],
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.title != null) ...[
                      AppText.displayL(
                        widget.title!,
                        style: TextStyle(fontSize: AppFontSize.fs11),
                        maxLines: 2,
                      ),
                      SizedBox(height: 2.h),
                    ],
                    if (widget.description != null) ...[
                      AppText.support(
                        widget.description!,
                        color: const Color(0xFF5A5350),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        maxLines: 2,
                      ),
                      SizedBox(height: 2.h),
                    ],
                    if (widget.customeSupport != null) ...[
                      AppText.support(
                        widget.customeSupport!,
                        color: const Color(0xFFB3958B),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        maxLines: 2,
                      ),
                    ] else ...[
                      AppText.support(
                        'Supported: ${widget.supportedFormatsLabel} | ${widget.maxSizeLabel}',
                        color: const Color(0xFFB3958B),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        maxLines: 2,
                      ),
                    ],
                  ],
                ),
              ),
              // SizedBox(width: 12.w),
              Flexible(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: widget.isUploading
                      ? _buildLoaderWidget()
                      : _buildUploadButton(),
                ),
              ),
            ],
          ),
        ),

        if (_uploadedFiles.isNotEmpty) ...[
          SizedBox(height: 22.h),

          AppText.h4(
            widget.uploadedSectionTitle,
            color: const Color(0xff260B01),
          ),
          SizedBox(height: 12.h),
          Column(
            children: List.generate(
              _uploadedFiles.length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildFileCard(
                  file: _uploadedFiles[index],
                  onRemove: () => _removeFile(index),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUploadButton() {
    return AppButton(
      width: 114.w,
      size: AppButtonSize.xSmall,
      key: const ValueKey('uploadButton'),
      label: widget.buttonText,
      variant: AppButtonVariant.outlined,
      trailingSvgAsset: AppIcons.svg.generic.upload,
      onPressed: widget.onUploadTap ?? _handleUploadTap,
    );
  }

  Widget _buildFileCard({required File file, required VoidCallback onRemove}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7F6),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          _buildFileIcon(file),
          SizedBox(width: 12.w),
          Expanded(
            child: AppText.h3(
              p.basename(file.path),
              maxLines: 1,
              color: const Color(0xff1B1B1B),
            ),
          ),
          SizedBox(width: 10.w),
          AppCircleButton(
            icon: AppIcons.svg.generic.delete,
            bgColor: AppColors.white,
            visualSize: AppIconSize.is32.ir,
            iconSize: AppIconSize.is14.ir,
            onTap: onRemove,
            borderRadius: 16.r,
            shadowColor: const Color(0xFFCB9B62).withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }

  Widget _buildFileIcon(File file) {
    return buildDocumentFileIconFromFile(
      file,
      width: AppSize.cs24.w,
      height: AppSize.cs32.h,
    );
  }

  Future<void> _handleUploadTap() async {
    if (widget.isUploading) {
      return;
    }

    final files = await _imagePickerService.pickImage(
      context: context,
      source: PickerSourceType.documents,
      cropSquare: true,
      allowMultiple: widget.allowMultiple,
    );

    if (!mounted || files == null || files.isEmpty) {
      return;
    }

    setState(() {
      if (!widget.allowMultiple) {
        _uploadedFiles = [files.first];
      } else {
        _uploadedFiles = _appendUniqueFiles(_uploadedFiles, files);
      }
    });

    widget.onFilesChanged?.call(List<File>.unmodifiable(_uploadedFiles));
  }

  void _removeFile(int index) {
    setState(() {
      _uploadedFiles.removeAt(index);
    });
    widget.onFilesChanged?.call(List<File>.unmodifiable(_uploadedFiles));
  }

  bool _isSameFileSet(List<File> previous, List<File> next) {
    if (previous.length != next.length) {
      return false;
    }

    for (int i = 0; i < previous.length; i++) {
      if (previous[i].path != next[i].path) {
        return false;
      }
    }

    return true;
  }

  List<File> _appendUniqueFiles(List<File> base, List<File> incoming) {
    final merged = <File>[...base];
    final existingPaths = merged.map((file) => file.path).toSet();

    for (final file in incoming) {
      if (!existingPaths.contains(file.path)) {
        merged.add(file);
        existingPaths.add(file.path);
      }
    }
    return merged;
  }

  Widget _buildLoaderWidget() {
    if (widget.progress != null) {
      return SizedBox(
        key: const ValueKey('progressLoader'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 116.w,
              height: 4.h,
              child: LinearProgressIndicator(
                value: widget.progress,
                backgroundColor: AppColors.textFieldBorderDefault,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF521703),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            AppText.support(
              '${(widget.progress! * 100).toInt()}%',
              color: const Color(0xFF521703),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      key: const ValueKey('circularLoader'),
      width: 32.w,
      height: 32.w,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF521703)),
      ),
    );
  }
}
