import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/services/image_picker_service.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/my_missing_pets_bloc.dart';
import 'package:poochcare/features/community/repository/missing_pet_repository.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class MissingVerifyBiometricScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final String reportId;

  const MissingVerifyBiometricScreen({super.key, required this.reportId});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyMissingPetsBloc>.value(
          value: getIt<MyMissingPetsBloc>(),
        ),
      ],
      child: this,
    );
  }

  @override
  State<MissingVerifyBiometricScreen> createState() =>
      _MissingVerifyBiometricScreenState();
}

class _MissingVerifyBiometricScreenState
    extends State<MissingVerifyBiometricScreen> {
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
    return PopScope<bool>(
      // canPop: false,
      // onPopInvokedWithResult: (didPop, result) {
      //   if (didPop) return;
      //   // _handleBack();
      // },
      child: AppPrimaryScreenContainer(
        title: 'Verify via Biometrics',
        backgroundColor: AppColors.white,
        // onBack: _handleBack,
        child: SafeArea(
          child:
              BlocBuilder<MyMissingPetsBloc, PaginationState<MissingPetModel>>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  16.r,
                                ),
                                child: localFile != null
                                    ? Image.file(localFile!, fit: BoxFit.cover)
                                    : AppIcon(
                                        fit: BoxFit.cover,
                                        AppIcons
                                            .png
                                            .verifyBiometrics
                                            .verifyBiometricsPet,
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
                            child: AppButton(
                              label: 'Open Camera',
                              onPressed: _pickImage,
                            ),
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
                                    onPressed: verfiyBiometricAndContinue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }

  void verfiyBiometricAndContinue() async {
    if (localFile == null) return;
    final MissingPetRepository repository = getIt<MissingPetRepository>();
    try {
      // Optional: show loader
      // ignore: inference_failure_on_function_invocation
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final result = await repository.getMissingReportMatchSuggestions(
        reportId: widget.reportId,
      );

      if (!mounted) return;

      Navigator.pop(context); // remove loader

      if (result != null) {
        if (result.matched) {
          context.pushRoute(
            MissingBiometricPetFoundRoute(reportId: widget.reportId),
          );
        } else if (!result.matched) {
          context.pushRoute(
            MissingBiometricPetNotFoundRoute(reportId: widget.reportId),
          );
        } else {
          CustomSnackbar.show('Some error occurred', SnackbarType.error);
        }
      } else {
        CustomSnackbar.show('Some error occurred', SnackbarType.error);
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
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
