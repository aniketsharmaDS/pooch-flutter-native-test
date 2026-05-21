import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/widgets/other_address_widget.dart';

class AddressTile extends StatelessWidget {
  final Address address;
  final VoidCallback? onTap;
  final VoidCallback? onSetAsPrimary;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const AddressTile({
    required this.address,
    this.onTap,
    this.onEditPressed,
    this.onDeletePressed,
    this.onSetAsPrimary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s16,
        vertical: AppSpacing.s10,
      ),
      child: Column(
        children: [
          OtherAddressWidget(
            addressType: getAddressType(
              addressType: (address.addressType ?? '').toLowerCase(),
            ),
          ),
          const SizedBox(height: AppSpacing.s12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: AppText.h4(
                              '${address.city}, ${address.pincode}',
                              fontSize: AppFontSize.fs16,
                              color: const Color(0xFF141517),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s8),

                          Visibility(
                            visible: address.isPrimary,
                            maintainAnimation: true,
                            maintainSize: true,
                            maintainState: true,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s8,
                                vertical: AppSpacing.s4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppRadiusSize.r24,
                                ),
                                color: AppColors.messageSuccess,
                              ),
                              child: AppText.h4(
                                'DEFAULT',
                                fontSize: AppFontSize.fs10,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s4),
                      AppText.bodyS(
                        variant: AppTextVariant.noEllipsis,
                        address.addressLine,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.s8),

              AppPopupMenu(
                items: [
                  AppPopupMenuItem(
                    icon: AppIcon(
                      AppIcons.svg.generic.gear,
                      height: 16,
                      width: 16,
                      color: AppColors.black,
                    ),
                    title: 'Set as default',
                    onTap: onSetAsPrimary ?? () {},
                  ),
                  AppPopupMenuItem(
                    icon: AppIcon(
                      AppIcons.svg.generic.edit,
                      height: 16,
                      width: 16,
                      color: AppColors.black,
                    ),
                    title: 'Edit',
                    onTap: onEditPressed ?? () {},
                  ),
                  AppPopupMenuItem(
                    icon: AppIcon(
                      height: 16,
                      width: 16,
                      AppIcons.svg.generic.delete,
                      color: AppColors.black,
                    ),
                    title: 'Delete',
                    onTap: onDeletePressed ?? () {},
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.s7),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5),
                    shape: BoxShape.circle,
                  ),
                  child: AppIcon(AppIcons.svg.generic.moreVert),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AddressType getAddressType({required String addressType}) {
    switch (addressType) {
      case 'home':
        return AddressType.home;
      case 'office':
        return AddressType.office;
      case 'other':
        return AddressType.other;
      default:
        return AddressType.other;
    }
  }
}
