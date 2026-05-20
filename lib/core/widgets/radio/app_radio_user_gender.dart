// File: app_radio_select_pet_gender.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/radio/app_radio.dart';

class AppRadioUserGender extends StatefulWidget {
  final String? initialGender;
  final ValueChanged<String> onGenderSelected;

  const AppRadioUserGender({
    super.key,
    this.initialGender,
    required this.onGenderSelected,
  });

  @override
  State<AppRadioUserGender> createState() => _AppRadioUserGenderState();
}

class _AppRadioUserGenderState extends State<AppRadioUserGender> {
  late String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
  }

  void _onSelect(String gender) {
    setState(() {
      _selectedGender = gender;
    });
    widget.onGenderSelected(gender);
  }

  Widget _buildGenderCard({
    required String label,
    required String asset,
    required String value,
  }) {
    return Expanded(
      child: AppRadio(
        borderColor: const Color(0xFFEFE8E6),
        selectedBorderColor: const Color(0xFFEFE8E6),

        label: label,
        icon: SvgPicture.asset(
          asset,
          colorFilter: const ColorFilter.mode(
            AppColors.secondaryIcon,
            BlendMode.srcIn,
          ),
          width: 24.r,
          height: 24.r,
        ),
        selectedIcon: SvgPicture.asset(
          asset,
          colorFilter: const ColorFilter.mode(
            AppColors.primaryIcon,
            BlendMode.srcIn,
          ),
          width: 24.r,
          height: 24.r,
        ),
        isSelected: _selectedGender == value,
        onTap: () => _onSelect(value),
        width: 100.w,
        height: 100.h,
        borderRadius: 15.r,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildGenderCard(
          label: 'Male',
          asset: AppIcons.svg.generic.male, // 'assets/svg/male.svg',
          value: 'male',
        ),
        SizedBox(width: 12.w),
        _buildGenderCard(
          label: 'Female',
          asset: AppIcons.svg.generic.female, // 'assets/svg/female.svg',
          value: 'female',
        ),
        SizedBox(width: 12.w),
        _buildGenderCard(
          label: 'Other',
          asset: AppIcons.svg.generic.other, // 'assets/svg/other.svg',
          value: 'other',
        ),
      ],
    );
  }
}
