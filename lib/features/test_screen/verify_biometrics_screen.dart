import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/services/image_picker_service.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class VerifyBiometricsScreen extends StatefulWidget {
  const VerifyBiometricsScreen({super.key});

  @override
  State<VerifyBiometricsScreen> createState() => _VerifyBiometricsScreenState();
}

class _VerifyBiometricsScreenState extends State<VerifyBiometricsScreen> {
  File? localFile;
  final ImagePickerService _imagePickerService = ImagePickerService();

  Future<void> _pickImage() async {
    final files = await _imagePickerService.pickImage(
      context: context,
      source: PickerSourceType.camera,
      cropSquare: true,
    );
    if (!mounted) return;
    if (files != null && files.isNotEmpty) {
      setState(() {
        localFile = files.first;
      });
    }
    // If cancelled, do nothing (screen remains)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Verify via Biometrics'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16.r),
                      child: localFile != null
                          ? Image.file(localFile!, fit: BoxFit.cover)
                          : AppIcon(
                              fit: BoxFit.cover,
                              AppIcons.png.verifyBiometrics.verifyBiometricsPet,
                            ),
                    ),
                    if (localFile == null)
                      const Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.75,
                          heightFactor: 0.5,
                          child: CaptureBox(),
                        ),
                      ),
                  ],
                ),
              ),
              if (localFile == null)
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppButton(label: 'Open Camera', onPressed: _pickImage),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: 'Retake',
                          onPressed: _pickImage,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: AppButton(
                          label: 'Continue',
                          onPressed: () {
                            // Handle continue action
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CaptureBox extends StatelessWidget {
  const CaptureBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 77.86.h,
              width: 82.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                ),
                border: Border(
                  top: BorderSide(color: Color(0xFFFEBE44), width: 8),
                  left: BorderSide(color: Color(0xFFFEBE44), width: 8),
                ),
              ),
            ),
            SizedBox(width: 90.w),
            Container(
              height: 77.86.h,
              width: 82.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(3),
                ),
                border: Border(
                  top: BorderSide(color: Color(0xFFFEBE44), width: 8),
                  right: BorderSide(color: Color(0xFFFEBE44), width: 8),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 101.w),

        Row(
          children: [
            Container(
              height: 77.86.h,
              width: 82.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: Radius.circular(3),
                  bottomLeft: Radius.circular(10),
                ),
                border: Border(
                  bottom: BorderSide(color: Color(0xFFFEBE44), width: 8),
                  left: BorderSide(color: Color(0xFFFEBE44), width: 8),
                ),
              ),
            ),

            SizedBox(width: 90.w),

            Container(
              height: 77.86.h,

              width: 82.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(10),
                ),
                border: Border(
                  bottom: BorderSide(color: Color(0xFFFEBE44), width: 8),
                  right: BorderSide(color: Color(0xFFFEBE44), width: 8),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 14.h),
        AppText.h1(
          'Capture front profile',
          fontSize: 16.sp,
          color: const Color(0xFFFFFEFD),
        ),
      ],
    );
  }
}
