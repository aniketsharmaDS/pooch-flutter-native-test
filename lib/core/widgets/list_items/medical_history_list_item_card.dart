import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/enums/medical_history_record_type_filter.dart';
import 'package:poochcare/core/helpers/file_download_helper.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/utils/document_file_icon_utils.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/router/app_router.dart';
import 'package:poochcare/router/router_service.dart';

enum DocumentDownloadState { idle, downloading, success, error }

enum ViewType { horizontal, vertical }

enum ItemType { consultation, labReport, vaccination, prescription }

class MedicalHistoryItem {
  final String title;
  final MedicalData? data;
  final ItemType type;

  MedicalHistoryItem({required this.title, this.data, required this.type});
}

class MedicalData {
  final String title;
  final String subtitle;
  final String dateTime;
  final String? recordId;
  final String? appointmentId;
  // final String recordDate;

  final List<MedicalDocument> documents;

  MedicalData({
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.documents,
    required this.recordId,
    required this.appointmentId,
    // required this.recordDate,
  });
}

class MedicalDocument {
  final String fileName;
  final String fileSize;
  final String fileType;
  final String? url;

  final Future<void> Function()? onDownload;

  /// Optional external control
  final DocumentDownloadState? state;
  final ValueChanged<DocumentDownloadState>? onStateChanged;

  MedicalDocument({
    required this.fileName,
    required this.fileSize,
    this.fileType = 'pdf',
    this.url,
    this.onDownload,
    this.state,
    this.onStateChanged,
  });

  bool get isExternallyControlled => state != null;
}

class MedicalHistoryListItemCard extends StatefulWidget {
  final MedicalHistoryItem item;
  final VoidCallback? onItemClick;
  final Duration successDuration;
  final ViewType? viewType;

  const MedicalHistoryListItemCard({
    super.key,
    required this.item,
    this.onItemClick,
    this.successDuration = const Duration(seconds: 2),
    this.viewType = ViewType.vertical,
  });

  @override
  State<MedicalHistoryListItemCard> createState() =>
      _MedicalHistoryListItemCardState();
}

class _MedicalHistoryListItemCardState
    extends State<MedicalHistoryListItemCard> {
  late List<DocumentDownloadState> _internalStates;
  final FileDownloadHelper _downloadHelper = FileDownloadHelper();

  List<MedicalDocument> get _docs => widget.item.data?.documents ?? [];

  @override
  void initState() {
    super.initState();

    _internalStates = _docs.map((doc) {
      return doc.state ?? DocumentDownloadState.idle;
    }).toList();
  }

  DocumentDownloadState _getState(int index) {
    final doc = _docs[index];
    return doc.isExternallyControlled ? doc.state! : _internalStates[index];
  }

  void _setStateForItem(int index, DocumentDownloadState state) {
    final doc = _docs[index];

    if (doc.isExternallyControlled) {
      doc.onStateChanged?.call(state);
    } else {
      setState(() {
        _internalStates[index] = state;
      });
    }
  }

  Future<void> _handleDownload(int index) async {
    final doc = _docs[index];

    final currentState = _getState(index);
    if (currentState == DocumentDownloadState.downloading) {
      return;
    }

    _setStateForItem(index, DocumentDownloadState.downloading);

    try {
      final isSuccess = await _downloadHelper.handleDownload(
        url: doc.url,
        fileName: doc.fileName,
        fileType: doc.fileType,
        onDownload: doc.onDownload,
      );
      if (!isSuccess) {
        _setStateForItem(index, DocumentDownloadState.error);
        return;
      }
      _setStateForItem(index, DocumentDownloadState.success);
    } catch (_) {
      _setStateForItem(index, DocumentDownloadState.error);
    }
  }

  Future<void> _openDownloadedDocument(int index) async {
    await _downloadHelper.openDownloadedFile(url: _docs[index].url);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final data = item.data;

    return GestureDetector(
      onTap: widget.onItemClick,
      child: Container(
        padding: (_docs.isEmpty || widget.viewType == ViewType.horizontal)
            ? EdgeInsets.only(top: 6.h)
            : EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
        decoration: BoxDecoration(
          color: item.type == ItemType.consultation
              ? const Color(0xFFFFECBC)
              : item.type == ItemType.vaccination
              ? const Color(0xFFFBDBB2)
              : const Color(0xFFE3C3B1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            /// MAIN CONTENT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(item.title),
                if (data != null) ...[
                  const SizedBox(height: 6),
                  if (widget.viewType == ViewType.vertical)
                    _headerVertical(data, type: item.type)
                  else
                    _headerHorizontal(data, type: item.type),

                  if (widget.viewType == ViewType.vertical)
                    if (_docs.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      ...List.generate(
                        _docs.length,
                        (i) => Padding(
                          padding: EdgeInsets.only(
                            bottom: i == _docs.length - 1 ? 0 : 6,
                          ),
                          child: _docItem(i),
                        ),
                      ),
                    ],
                ] else ...[
                  const SizedBox(height: 12),
                  const Center(child: Text('No medical data available')),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Text(title, style: const TextStyle(fontSize: 10)),
    );
  }

  Widget _headerVertical(MedicalData data, {required ItemType type}) {
    return InkWell(
      onTap: () {
        // if (widget.onItemClick != null) {
        //   widget.onItemClick!();
        // }
        appRouter.push(
          PetMedicalDetailsRoute(
            recordId: data.recordId ?? '',
            appointmentId: data.appointmentId ?? '',
            recordType: type == ItemType.consultation
                ? MedicalHistoryRecordTypeFilter.consultation
                : type == ItemType.vaccination
                ? MedicalHistoryRecordTypeFilter.vaccination
                : MedicalHistoryRecordTypeFilter.labReport,
          ),
        );
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 11.h,
        ).copyWith(bottom: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E9),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: AppIcon(AppIcons.svg.generic.poochTail),
            ),
            SizedBox(width: 20.w),
            if (type == ItemType.consultation)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.h4(data.title, color: const Color(0xFF521703)),
                    SizedBox(height: 5.h),
                    AppText.h4(
                      data.subtitle,
                      color: const Color(0xFF521703),
                      fontSize: 12,
                    ),
                    SizedBox(height: 12.h),
                    AppText.h1(
                      data.dateTime,
                      fontSize: 16.sp,
                      color: const Color(0xFF521703),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.h4(data.title, color: const Color(0xFF521703)),
                    SizedBox(height: 12.h),
                    AppText.h4(
                      data.subtitle,
                      color: const Color(0xFF521703),
                      fontSize: 12,
                    ),
                    SizedBox(height: 5.h),
                    AppText.h4(
                      data.dateTime,
                      color: const Color(0xFF521703),
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _headerHorizontal(MedicalData data, {required ItemType type}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // ✅ important
          children: [
            /// LEFT ICON
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9E9),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: AppIcon(AppIcons.svg.generic.poochTail),
            ),

            SizedBox(width: 12.w),

            /// RIGHT CONTENT
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 70, // ✅ match left height
                ),
                child: Stack(
                  children: [
                    /// ORIGINAL CONTENT (unchanged)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.h4(
                          data.title,
                          maxLines: 2,
                          color: const Color(0xFF404041),
                        ),
                        SizedBox(height: 2.h),
                        AppText.h4(
                          data.subtitle,
                          color: const Color(0xFFB3958B),
                          fontSize: 12,
                        ),
                        SizedBox(height: 1.h),
                        AppText.h4(
                          data.dateTime,
                          color: const Color(0xFFB3958B),
                          fontSize: 12,
                        ),
                      ],
                    ),

                    /// BUTTON (absolute positioned)
                    Positioned(
                      right: 0,
                      bottom: 0, // 👈 aligns with date line
                      child: AppButton(
                        variant: AppButtonVariant.text,
                        label: 'View Report',
                        trailingSvgAsset: AppIcons.svg.generic.chevronRight,
                        onPressed: widget.onItemClick,
                        size: AppButtonSize.xSmall,
                        textStyle: TextStyle(
                          fontSize: 12.sp,
                        ), // 👈 tighter text
                        width: null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _docItem(int index) {
    final doc = _docs[index];
    final state = _getState(index);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _badge(doc.fileType),
          const SizedBox(width: 12),
          Expanded(child: _info(context, doc)),
          const SizedBox(width: 12),
          _download(state, index),
        ],
      ),
    );
  }

  Widget _badge(String type) {
    return buildDocumentFileIconFromType(type, width: 36, height: 42);
  }

  Widget _info(BuildContext context, MedicalDocument doc) {
    return InkWell(
      onTap: () {
        if (doc.url != null && doc.url!.trim().isNotEmpty) {
          appRouter.push(
            FileViewerRoute(
              fileUrl: doc.url ?? '',
              reportType: 'Medical Report',
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doc.fileName, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(doc.fileSize),
          ],
        ),
      ),
    );
  }

  Widget _download(DocumentDownloadState state, int index) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: KeyedSubtree(
        key: ValueKey<DocumentDownloadState>(state),
        child: _downloadStateWidget(state, index),
      ),
    );
  }

  Widget _downloadStateWidget(DocumentDownloadState state, int index) {
    switch (state) {
      case DocumentDownloadState.downloading:
        return SizedBox(
          width: 32.r,
          height: 32.r,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      case DocumentDownloadState.success:
        return AppButton(
          label: 'View',
          width: null,
          size: AppButtonSize.xSmall,
          variant: AppButtonVariant.text,
          trailingSvgAsset: AppIcons.svg.generic.chevronRight,
          onPressed: () => _openDownloadedDocument(index),
        );
      case DocumentDownloadState.error:
        return AppCircleButton(
          icon: AppIcons.svg.generic.sun,
          size: AppCircleButtonSize.small,
          variant: AppCircleButtonVariant.secondary,
          onTap: () => _handleDownload(index),
        );
      // case DocumentDownloadState.idle:
      // // ignore: unreachable_switch_default
      default:
        return AppCircleButton(
          icon: AppIcons.svg.generic.download,
          size: AppCircleButtonSize.small,
          variant: AppCircleButtonVariant.secondary,
          onTap: () => _handleDownload(index),
        );
    }
  }
}
