import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/services/image_picker_service.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_file_picker/filter_picker_button_item.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppFilePicker extends StatelessWidget {
  const AppFilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.w,
              height: 4.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99.r),
              ),
            ),
            SizedBox(height: 18.h),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText.h3('Choose file source'),
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText.bodyS(
                'Select where you want to pick your image from',
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: FilterPickerButtonItem(
                    icon: Icons.photo_library_outlined,
                    title: 'Gallery',
                    onPressed: () => _onSelectSource(
                      context: context,
                      source: PickerSourceType.gallery,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: FilterPickerButtonItem(
                    icon: Icons.camera_alt_outlined,
                    title: 'Camera',
                    onPressed: () => _onSelectSource(
                      context: context,
                      source: PickerSourceType.camera,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSelectSource({
    required BuildContext context,
    required PickerSourceType source,
  }) async {
    final value = await ImagePickerService().pickImage(
      context: context,
      source: source,
      cropSquare: true,
    );

    if (!context.mounted) {
      return;
    }

    if ((value ?? []).isNotEmpty) {
      Navigator.pop(context, value);
    }
  }

  static Future<List<File>?> openImagePickerSheet({
    required BuildContext context,
  }) async {
    final mediaQuery = MediaQuery.of(context);

    return await showModalBottomSheet<List<File>?>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      useSafeArea: true,
      context: context,
      constraints: BoxConstraints(
        maxWidth: 600.w,
        minHeight: 220.h,
        maxHeight: mediaQuery.size.height * 0.42,
      ),
      builder: (context) {
        return const AppFilePicker();
      },
    );
  }
}
