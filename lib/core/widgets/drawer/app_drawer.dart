import 'dart:ui' as ui;
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/session_reset_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// MODELS
/// =============================

enum DrawerItemType { dropdown, normal }

class DrawerItem {
  final String iconPath;
  final String title;
  final DrawerItemType dropdownType;
  final List<DrawerItemChildren> drawerItemChildren;
  final void Function(BuildContext context) onPressed;

  DrawerItem({
    required this.iconPath,
    required this.title,
    required this.dropdownType,
    required this.drawerItemChildren,
    required this.onPressed,
  });
}

class DrawerItemChildren {
  final String iconPath;
  final String title;
  final void Function(BuildContext context) onPressed;

  DrawerItemChildren({
    required this.iconPath,
    required this.title,
    required this.onPressed,
  });
}

/// =============================
/// MAIN DRAWER
/// =============================

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.theme,
    required this.drawerItems,
    required this.socialMediaIcons,
  });

  final ThemeData theme;
  final List<DrawerItem> drawerItems;
  final List<String> socialMediaIcons;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.maxFinite,
      backgroundColor: const ui.Color.fromARGB(
        255,
        245,
        205,
        104,
      ).withValues(alpha: 0.3),
      child: SafeArea(
        // ✅ Handles status bar & bottom area
        child: Stack(
          children: [
            /// Blur Background
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const SizedBox.expand(),
            ),

            /// Content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s12.w,
                vertical: AppSpacing.s16.h,
              ),
              child: Column(
                children: [
                  /// Optional Header
                  // HeaderWidget(theme: theme),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      // horizontal: AppSpacing.s12.w,
                      vertical: AppSpacing.s14.h,
                    ).copyWith(left: AppSpacing.s8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.h1('drawer.menu'.tr()),
                        AppCircleButton(
                          variant: AppCircleButtonVariant.secondary,
                          showShadow: false,
                          icon: AppIcons.svg.generic.close,
                          bgColor: AppColors.p2_50.withValues(alpha: 0.6),
                          onTap: () => {Navigator.pop(context)},
                        ),
                        // Close Button
                      ],
                    ),
                  ),

                  /// Drawer Items
                  Expanded(
                    child: DrawerItemsWidget(
                      drawerItems: drawerItems,
                      socialMediaIcons: socialMediaIcons,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  /// Logout Button
                  AppButton(
                    leadingSvgAsset: AppIcons.svg.drawer.logout,
                    label: 'drawer.logOut'.tr(),
                    onPressed: () async {
                      // Navigator.pop(context);
                      logout(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) {
    AppDialog.show<void>(
      context: context,
      title: 'drawer.logOut'.tr(),
      content: 'drawer.areYouSureWantToLogout'.tr(),
      icon: Lottie.asset(AppIcons.lottie.question, repeat: false),
      onPrimary: () async {
        await getIt<SessionResetService>().clearSessionData();
        if (!context.mounted) {
          return;
        }

        await context.setLocale(const Locale('en'));
        if (!context.mounted) {
          return;
        }
        context.router.replaceAll([const LoginRoute()]);
      },
      primaryLabel: 'common.yes'.tr(),
      secondaryLabel: 'common.no'.tr(),
    );
  }
}

/// =============================
/// DRAWER ITEMS LIST
/// =============================

class DrawerItemsWidget extends StatelessWidget {
  final List<DrawerItem> drawerItems;
  final List<String> socialMediaIcons;

  const DrawerItemsWidget({
    super.key,
    required this.drawerItems,
    required this.socialMediaIcons,
  });

  @override
  Widget build(BuildContext context) {
    const fontFamily = 'Gilroy600';

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xffFEF2EF).withValues(alpha: 0.7),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(top: 14.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Drawer Items
              ...List.generate(drawerItems.length, (index) {
                final item = drawerItems[index];

                if (item.drawerItemChildren.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: DrawerExpandableItem(item: item),
                  );
                }

                return ListTile(
                  onTap: () {
                    item.onPressed(context);
                    Navigator.of(context).pop();
                  },
                  // contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  leading: SvgPicture.asset(
                    item.iconPath,
                    height: 24.h,
                    width: 24.w,
                  ),

                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: AppFontSize.fs16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }),

              SizedBox(height: 20.h),

              /// Social Media Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(children: [AppText.h3('drawer.socialMedia'.tr())]),
              ),

              SizedBox(height: 10.h),

              /// Social Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  socialMediaIcons.length,
                  (index) => GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      socialMediaIcons[index],
                      height: 32.h,
                      width: 32.w,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// =============================
/// EXPANDABLE ITEM
/// =============================

class DrawerExpandableItem extends StatelessWidget {
  const DrawerExpandableItem({super.key, required this.item});

  final DrawerItem item;

  @override
  Widget build(BuildContext context) {
    const fontFamily = 'Gilroy600';

    return ExpansionTile(
      // minTileHeight: 70.h,
      iconColor: AppColors.p5_900, // Expanded state
      collapsedIconColor: AppColors.p5_900, // C

      expansionAnimationStyle: const AnimationStyle(
        curve: Curves.easeInOutQuart,
        duration: Duration(milliseconds: 600),
        reverseCurve: Curves.ease,
      ),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
        // side: BorderSide.none,
      ),
      collapsedShape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      backgroundColor: const Color(0xffFFF7F8).withValues(alpha: 0.8),

      leading: SvgPicture.asset(item.iconPath, height: 24.h, width: 24.w),

      title: Text(
        item.title,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: AppFontSize.fs16,
          fontWeight: FontWeight.w400,
        ),
      ),

      children: item.drawerItemChildren.isNotEmpty
          ? item.drawerItemChildren
                .map(
                  (child) =>
                      DrawerItemChildrenWidget(item: item, currentChild: child),
                )
                .toList()
          : [],
    );
  }
}

/// =============================
/// CHILD ITEM
/// =============================

class DrawerItemChildrenWidget extends StatelessWidget {
  const DrawerItemChildrenWidget({
    super.key,
    required this.item,
    required this.currentChild,
  });

  final DrawerItem item;
  final DrawerItemChildren currentChild;

  @override
  Widget build(BuildContext context) {
    const fontFamily = 'Gilroy600';

    return Padding(
      padding: EdgeInsets.only(left: 50.w),
      child: InkWell(
        // ✅ better than GestureDetector
        onTap: () {
          currentChild.onPressed(context);
          Navigator.of(context).pop();
        },
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          height: 40.h,
          child: Row(
            children: [
              SvgPicture.asset(
                currentChild.iconPath,
                height: 16.h,
                width: 16.w,
              ),
              SizedBox(width: 10.w),
              Text(
                currentChild.title,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: AppFontSize.fs14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
