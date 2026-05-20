// ignore_for_file: avoid_redundant_argument_values

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class FileViewerScreen extends StatefulWidget {
  final String reportType;
  final String fileUrl;

  const FileViewerScreen({
    super.key,
    required this.fileUrl,
    required this.reportType,
  });

  @override
  State<FileViewerScreen> createState() => _FileViewerScreenState();
}

class _FileViewerScreenState extends State<FileViewerScreen> {
  bool isLoading = true;
  String? localPdfPath;

  late bool isImage;
  late bool isPdf;

  @override
  void initState() {
    super.initState();

    final cleanUrl = widget.fileUrl.toLowerCase().split('?').first;

    isImage =
        cleanUrl.endsWith('.jpg') ||
        cleanUrl.endsWith('.jpeg') ||
        cleanUrl.endsWith('.png') ||
        cleanUrl.endsWith('.webp');

    isPdf = cleanUrl.endsWith('.pdf');

    if (isPdf) {
      _downloadPdf();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _downloadPdf() async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/temp_file.pdf');

      await Dio().download(widget.fileUrl, file.path);

      setState(() {
        localPdfPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: widget.reportType.isEmpty ? 'File Viewer' : widget.reportType,
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    /// 🖼 IMAGE HANDLING
    if (isImage) {
      return Center(
        child: InteractiveViewer(
          child: Image.network(
            widget.fileUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
              );
            },
          ),
        ),
      );
    }

    /// 📄 PDF HANDLING
    if (isPdf && localPdfPath != null) {
      return PDFView(
        filePath: localPdfPath!,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
      );
    }

    /// 🔁 FALLBACK
    return _fallback();
  }

  Widget _fallback() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.s16.w),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.h2('Preview not available'),
            const SizedBox(height: 12),
            AppButton(
              label: 'Open Externally',
              size: AppButtonSize.medium,
              onPressed: () async {
                final uri = Uri.parse(widget.fileUrl);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
            ),
          ],
        ),
      ),
    );
  }
}
