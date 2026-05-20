import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

enum AddressType { home, other, office }

class OtherAddressWidget extends StatelessWidget {
  final AddressType addressType;
  const OtherAddressWidget({required this.addressType, super.key});

  @override
  Widget build(BuildContext context) {
    final title = getAddressType(addressType: addressType);
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Row(
            children: [
              AppIcon(
                height: 16,
                width: 16,
                addressType == AddressType.home
                    ? AppIcons.svg.generic.building
                    : addressType == AddressType.office
                    ? AppIcons.svg.generic.luggage
                    : AppIcons.svg.generic.location,
              ),
              const SizedBox(width: AppSpacing.s4),
              AppText.h4(
                title,
                fontSize: AppFontSize.fs10,
                color: const Color(0xFF4F5466),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getAddressType({required AddressType addressType}) {
    switch (addressType) {
      case AddressType.home:
        return 'Home';
      case AddressType.office:
        return 'Office';
      case AddressType.other:
        return 'Other addresses';
    }
  }
}
