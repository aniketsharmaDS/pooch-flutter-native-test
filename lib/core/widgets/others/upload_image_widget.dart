import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:poochcare/core/services/image_picker_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/document_file_icon_utils.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class UploadImageWidget extends StatefulWidget {
  final String? title;
  final String? description;
  final String buttonText;
  final Future<void> Function()? onUploadTap;
  final bool isUploading;
  final double? progress;
  final bool allowMultiple;
  final List<File> initialFiles;
  final ValueChanged<List<File>>? onFilesChanged;
  final ValueChanged<List<String>>? onRemoteChanged;
  final String uploadedSectionTitle;
  final String supportedFormatsLabel;
  final String maxSizeLabel;
  final String? customeSupport;
  final bool? showHeader;
  final String? headerText;
  final List<dynamic> initialUrls;

  const UploadImageWidget({
    super.key,
    this.title,
    this.description,
    required this.buttonText,
    this.initialUrls = const [],
    this.onUploadTap,
    this.isUploading = false,
    this.progress,
    this.allowMultiple = true,
    this.initialFiles = const [],
    this.onFilesChanged,
    this.onRemoteChanged,
    this.customeSupport,
    this.uploadedSectionTitle = 'Uploaded documents',
    this.supportedFormatsLabel = 'PDF, JPG, PNG',
    this.maxSizeLabel = 'Max 10MB',
    this.showHeader = false,
    this.headerText = 'Upload Documents',
  });

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  final ImagePickerService _imagePickerService = ImagePickerService();
  late List<File> _uploadedFiles;
  List<dynamic> _remoteFiles = [];

  @override
  void initState() {
    super.initState();
    _uploadedFiles = List<File>.from(widget.initialFiles);
    _remoteFiles = List<dynamic>.from(widget.initialUrls);
    log(
      'UploadImageWidget initialized with ${_uploadedFiles.length} local files and ${_remoteFiles.length} remote files.',
    );
  }

  @override
  void didUpdateWidget(covariant UploadImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isSameFileSet(oldWidget.initialFiles, widget.initialFiles)) {
      _uploadedFiles = List<File>.from(widget.initialFiles);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalCount = _uploadedFiles.length + _remoteFiles.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHeader == true) ...[
          Container(
            padding: EdgeInsets.only(bottom: AppSpacing.s10.w),
            child: AppText.h3(widget.headerText!, color: AppColors.p4_900),
          ),
        ],

        if (_uploadedFiles.isEmpty && _remoteFiles.isEmpty) ...[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 80.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                          fontSize: AppFontSize.fs12,
                          color: const Color(0xFFB3958B),
                          // style: const TextStyle(fontWeight: FontWeight.w400),
                          maxLines: 3,
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
        ],

        if (_uploadedFiles.isNotEmpty || _remoteFiles.isNotEmpty) ...[
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.allowMultiple ? totalCount + 1 : totalCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              // childAspectRatio: 1, // comented as its default
            ),
            itemBuilder: (context, index) {
              final fileCount = _uploadedFiles.length;
              final remoteCount = _remoteFiles.length;
              final totalItems = fileCount + remoteCount;

              // ➕ ADD TILE
              if (index == totalItems) {
                return _buildAddTile();
              }

              /// 🌐 REMOTE FILES FIRST
              if (index < remoteCount) {
                final item = _remoteFiles[index];
                String url = '';
                if (item is Map) {
                  url = (item['url'] ?? item['imageUrl'] ?? '').toString();
                } else if (item is String) {
                  url = item;
                } else if ((item as dynamic).url != null) {
                  url = (item as dynamic).url.toString();
                }
                return _buildRemoteCard(
                  url: url.toString(),
                  onRemove: () => _removeRemoteFile(index),
                );
              }

              /// 📁 LOCAL FILES SECOND
              final localIndex = index - remoteCount;

              // 📄 FILE TILE (same UI reused safely)
              return _buildGridFileCard(
                file: _uploadedFiles[localIndex],
                onRemove: () => _removeFile(localIndex),
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildRemoteCard({
    required String url,
    required VoidCallback onRemove,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white_50,
        borderRadius: BorderRadius.circular(AppRadiusSize.r15.rr),
        border: Border.all(color: AppColors.p4_50),
      ),
      child: Stack(
        children: [
          /// 🌐 IMAGE FROM NETWORK
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadiusSize.r15.rr),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.broken_image, color: AppColors.p4_200),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),

          /// ❌ DELETE BUTTON
          Positioned(
            top: -AppSpacing.s5.h,
            right: -AppSpacing.s4.h,
            // top: AppSpacing.s2.h,
            // right: AppSpacing.s2.w,
            child: AppCircleButton(
              bgColor: AppColors.p5_50,
              showShadow: false,
              iconSize: AppIconSize.is16,
              size: AppCircleButtonSize.small,
              icon: AppIcons.svg.generic.delete,
              iconColor: AppColors.white_50,
              // shadowColor: Colors.white,
              onTap: onRemove,
              borderRadius: AppRadiusSize.r16.rr,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridFileCard({
    required File file,
    required VoidCallback onRemove,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white_50,
        borderRadius: BorderRadius.circular(AppRadiusSize.r15.rr),
        border: Border.all(color: AppColors.p4_50),
      ),
      child: Stack(
        children: [
          Center(child: _buildFileIcon(file)),
          Positioned(
            top: -AppSpacing.s5.h,
            right: -AppSpacing.s4.h,
            // top: AppSpacing.s2.h,
            // right: AppSpacing.s2.w,
            child: AppCircleButton(
              bgColor: AppColors.p5_50,
              showShadow: false,
              iconSize: AppIconSize.is16,
              size: AppCircleButtonSize.small,
              icon: AppIcons.svg.generic.delete,
              iconColor: AppColors.white_50,
              // shadowColor: Colors.white,
              onTap: onRemove,
              borderRadius: AppRadiusSize.r16.rr,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTile() {
    return GestureDetector(
      onTap: _handleUploadTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadiusSize.r15.rr),
          color: AppColors.white_50,
          border: Border.all(color: AppColors.p4_50),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(AppIcons.svg.generic.upload, size: AppIconSize.is24),
              AppSpacing.s8.hBox,
              AppText.bodyM(widget.buttonText),
            ],
          ),
        ),
      ),
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

  // ignore: unused_element
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
            onTap: onRemove,
            borderRadius: 16.r,
            shadowColor: const Color(0xCB9B6266).withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }

  Widget _buildFileIcon(File file) {
    final path = file.path.toLowerCase();

    final isImage =
        path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.webp');

    if (isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.file(file, fit: BoxFit.cover),
        ),
      );
    }

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

  void _removeRemoteFile(int index) {
    setState(() {
      _remoteFiles.removeAt(index);
    });
    widget.onRemoteChanged?.call(List<String>.unmodifiable(_remoteFiles));
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
