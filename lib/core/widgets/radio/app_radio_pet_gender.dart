// File: app_radio_pet_gender.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/radio/app_radio.dart';

class AppRadioPetGender extends StatefulWidget {
  final String? initialGender;
  final ValueChanged<String> onGenderSelected;
  final bool isEditableGender;

  const AppRadioPetGender({
    super.key,
    this.initialGender,
    required this.onGenderSelected,
    this.isEditableGender = true,
  });

  @override
  State<AppRadioPetGender> createState() => _AppRadioPetGenderState();
}

class _AppRadioPetGenderState extends State<AppRadioPetGender> {
  late String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
  }

  void _onSelect(String gender) {
    if (!widget.isEditableGender) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pet gender cannot be changed once set.'),
            duration: Duration(seconds: 2),
          ),
        );
      });
      return;
    }
    setState(() {
      _selectedGender = gender;
    });
    widget.onGenderSelected(gender); // send back to parent
  }

  Widget _buildGenderCard({
    required String label,
    required String iconPath,
    required String selectedIconPath,
    required String value,
    bool isFemale = false,
  }) {
    final isDisabled = !widget.isEditableGender;
    final opacity = isDisabled ? 0.7 : 1.0;
    final borderColor = isDisabled
        ? const Color(0xFFD3D3D3)
        : const Color(0xFFEFE8E6);

    return Expanded(
      child: Opacity(
        opacity: opacity,
        child: AppRadio(
          label: label,
          icon: Image.asset(
            iconPath,
            width: isFemale ? 70.r : 100.r,
            height: isFemale ? 70.r : 100.r,
          ),
          selectedIcon: Image.asset(
            selectedIconPath,
            width: isFemale ? 70.r : 100.r,
            height: isFemale ? 70.r : 100.r,
          ),
          use3DIcon: true,
          layout: Axis.horizontal,
          isSelected: _selectedGender == value,
          onTap: () => _onSelect(value),
          width: 160.w,
          height: 70.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          selectedBackgroundColor: Colors.white,
          borderColor: borderColor,
          selectedBorderColor: borderColor,
          icon3DPositionRight: isFemale ? -24 : -30,
          icon3DPositionTop: isFemale ? -18 : -35,
          borderRadius: 16.r,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildGenderCard(
          label: 'Male',
          iconPath: AppIcons.png.generic.male3D,
          selectedIconPath: AppIcons.png.generic.male3D,
          value: 'male',
        ),
        SizedBox(width: 24.w),
        _buildGenderCard(
          label: 'Female',
          iconPath: AppIcons.png.generic.female3D,
          selectedIconPath: AppIcons.png.generic.female3D,
          value: 'female',
          isFemale: true,
        ),
      ],
    );
  }
}
