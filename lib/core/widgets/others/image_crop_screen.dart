import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';

/// Screen for cropping images in a square aspect ratio
@RoutePage()
class ImageCropScreen extends StatelessWidget {
  final File imageFile;

  const ImageCropScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    final controller = CropController();
    final imageData = imageFile.readAsBytesSync();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Image'),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: controller.crop),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Crop(
            image: imageData,
            controller: controller,
            onCropped: (result) => _handleCropResult(context, result),
            aspectRatio: 1.0,
            initialRectBuilder: InitialRectBuilder.withBuilder((
              viewportRect,
              imageRect,
            ) {
              final size = imageRect.width < imageRect.height
                  ? imageRect.width
                  : imageRect.height;

              return Rect.fromCenter(
                center: imageRect.center,
                width: size,
                height: size,
              );
            }),
            baseColor: Colors.black,
            maskColor: Colors.white.withAlpha(100),
            progressIndicator: const CircularProgressIndicator(),
            cornerDotBuilder: (size, edgeAlignment) =>
                const DotControl(color: AppColors.textPrimary),
            clipBehavior: Clip.none,
            interactive: true,
            fixCropRect: true,
          ),
        ),
      ),
    );
  }

  /// Handle the result of the crop operation
  Future<void> _handleCropResult(
    BuildContext context,
    CropResult result,
  ) async {
    switch (result) {
      case CropSuccess(:final croppedImage):
        final croppedFile = await _saveCroppedImage(croppedImage);
        if (context.mounted) {
          Navigator.of(context).pop(croppedFile);
        }
      case CropFailure(:final cause):
        CustomSnackbar.show('Cropping failed: $cause', SnackbarType.error);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
    }
  }

  /// Save cropped image to temporary file
  Future<File> _saveCroppedImage(List<int> croppedImage) async {
    final tempDir = Directory.systemTemp;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filePath = p.join(tempDir.path, 'cropped_image_$timestamp.png');
    final croppedFile = File(filePath);
    await croppedFile.writeAsBytes(croppedImage, flush: true);
    return croppedFile;
  }
}
