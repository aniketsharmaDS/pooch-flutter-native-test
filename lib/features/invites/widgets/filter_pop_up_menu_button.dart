import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/features/invites/domain/models/invite_status_filter.dart';

class FilterPopUpMenuButton extends StatelessWidget {
  const FilterPopUpMenuButton({
    super.key,
    this.onStatusSelected,
    this.onReset,
    this.isActive = false,
  });

  final ValueChanged<InviteStatusFilter>? onStatusSelected;
  final VoidCallback? onReset;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      top: 8,
      child: AppPopupMenu(
        headerTitle: 'Filter by',
        showCloseIcon: true,
        items: [
          AppPopupMenuItem(title: 'Reset', onTap: () => onReset?.call()),
          AppPopupMenuItem(
            title: 'Accepted',
            onTap: () => onStatusSelected?.call(InviteStatusFilter.accepted),
          ),
          AppPopupMenuItem(
            title: 'Awaiting acceptance',
            onTap: () => onStatusSelected?.call(InviteStatusFilter.pending),
          ),
        ],

        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: AppSize.cs32.h,
              height: AppSize.cs32.h,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: AppIcon(
                AppIcons.svg.generic.funnleFilter,
                size: AppIconSize.is24,
              ),
            ),
            if (isActive)
              const Positioned(
                right: -1,
                top: -1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8A733),
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(width: 10, height: 10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
