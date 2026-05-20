import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/Tabs/app_bottom_tab_nav.dart';
import 'package:poochcare/core/widgets/app_loader.dart';
import 'package:poochcare/core/widgets/appbar/pooch_app_bar.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/drawer/app_drawer.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/cart_icon_with_badge.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/wishlist_icon_with_badge.dart';
import 'package:poochcare/features/home/presentation/bloc/home_bloc.dart';
import 'package:poochcare/features/home/presentation/bloc/home_event.dart';
import 'package:poochcare/features/home/presentation/bloc/home_state.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => getIt<HomeBloc>(),
      child: this,
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeDataRequested());
    context.read<UserProfileBloc>().add(const GetUserProfileEvent());
    context.read<UserProfileBloc>().add(const GetParentGroupsEvent());
  }

  Future<void> _onPullToRefresh() async {
    // context.read<HomeBloc>().add(const HomeDataRequested());
    context.read<UserProfileBloc>().add(const GetUserProfileEvent());
    context.read<UserProfileBloc>().add(const GetParentGroupsEvent());

    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  List<String> socialMediaIcons = [
    AppIcons.svg.social.facebook,
    AppIcons.svg.social.instagram,
    AppIcons.svg.social.linkedin,
    AppIcons.svg.social.youtube,
  ];

  final List<DrawerItem> _drawerItem = [
    DrawerItem(
      onPressed: (context) {},
      iconPath: AppIcons.svg.drawer.house,
      title: 'drawer.dashboard'.tr(),
      dropdownType: DrawerItemType.normal,
      drawerItemChildren: [],
    ),
    DrawerItem(
      onPressed: (context) {},
      iconPath: AppIcons.svg.drawer.settings,
      title: 'drawer.accountSettings'.tr(),
      dropdownType: DrawerItemType.dropdown,
      drawerItemChildren: [
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.accounts,
          title: 'drawer.manageMyAccounts'.tr(),
          onPressed: (context) {
            context.pushRoute(const UserProfileRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.accessories,
          title: 'drawer.myVirtualAccessories'.tr(),
          onPressed: (context) {
            log('drawer.myVirtualAccessories'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.orders,
          title: 'drawer.myOrders'.tr(),
          onPressed: (context) {
            context.pushRoute(const OrdersListingRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.orders,
          title: 'drawer.myWishList'.tr(),
          onPressed: (context) {
            context.pushRoute(const WishlistRoute());
            // log('drawer.myWishList'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.coupons,
          title: 'drawer.myCouponsAndDiscounts'.tr(),
          onPressed: (context) {
            context.pushRoute(const CouponsRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.invites,
          title: 'drawer.myInvites'.tr(),
          onPressed: (context) {
            context.pushRoute(const InvitesRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.subscription,
          title: 'drawer.mySubscriptions'.tr(),
          onPressed: (context) {
            log('drawer.mySubscriptions'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.accounts,
          title: 'drawer.myRecentReportsAndHistory'.tr(),
          onPressed: (context) {
            log('drawer.myRecentReportsAndHistory'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.subscription,
          title: 'drawer.mySubscribedClinics'.tr(),
          onPressed: (context) {
            log('drawer.mySubscribedClinics'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notification,
          title: 'drawer.myNotificationSettings'.tr(),
          onPressed: (context) {
            log('drawer.myNotificationSettings'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.paymentMethod,
          title: 'drawer.myPaymentMethods'.tr(),
          onPressed: (context) {
            log('drawer.myPaymentMethods'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.delete,
          title: 'drawer.deleteMyAccount'.tr(),
          onPressed: (context) {
            log('drawer.deleteMyAccount'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.changeLang,
          title: 'drawer.changeLanguage'.tr(),
          onPressed: (context) {
            context.pushRoute(const ChangeLanguageRoute());
          },
        ),
      ],
    ),
    DrawerItem(
      onPressed: (context) {},
      iconPath: AppIcons.svg.drawer.helpSupport,
      title: 'drawer.helpAndSupport'.tr(),
      dropdownType: DrawerItemType.dropdown,
      drawerItemChildren: [
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'drawer.faqs'.tr(),
          onPressed: (context) {
            log('drawer.faqs'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.userSound,
          title: 'drawer.contactAndAssistance'.tr(),
          onPressed: (context) {
            log('drawer.contactAndAssistance'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.minus,
          title: 'drawer.reports'.tr(),
          onPressed: (context) {
            log('drawer.reports'.tr());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'drawer.feedback'.tr(),
          onPressed: (context) {
            log('drawer.feedback'.tr());
          },
        ),
      ],
    ),
    DrawerItem(
      onPressed: (context) {},
      iconPath: AppIcons.svg.drawer.about,
      title: 'drawer.about'.tr(),
      dropdownType: DrawerItemType.normal,
      drawerItemChildren: [],
    ),
    DrawerItem(
      onPressed: (context) {},
      iconPath: AppIcons.svg.drawer.folder,
      title: 'drawer.privacyPolicy'.tr(),
      dropdownType: DrawerItemType.normal,
      drawerItemChildren: [],
    ),
    DrawerItem(
      onPressed: (context) {},
      iconPath: AppIcons.svg.drawer.folder,
      title: 'drawer.termsAndConditions'.tr(),
      dropdownType: DrawerItemType.normal,
      drawerItemChildren: [],
    ),
    DrawerItem(
      onPressed: (context) {},
      iconPath: AppIcons.svg.drawer.folder,
      title: 'Component\'s',
      dropdownType: DrawerItemType.normal,
      drawerItemChildren: [
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Test Design Screen',
          onPressed: (context) {
            log('Buttons Clicked');
            context.pushRoute(const TestDesignRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'App Default Components Design',
          onPressed: (context) {
            log('Buttons Clicked');
            context.pushRoute(const AppDesignRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Splash Screen',
          onPressed: (context) {
            log('Buttons Clicked');
            context.pushRoute(const SplashRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Select Pet Option Screen',
          onPressed: (context) {
            log('Buttons Clicked');
            context.pushRoute(SelectPetOptionRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'App Top Tab Bar',
          onPressed: (context) {
            log('Buttons Clicked');
            context.pushRoute(const AppTopTabBarRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'App Top chip Tab Bar',
          onPressed: (context) {
            log('Buttons Clicked');
            context.pushRoute(const AppTopChipTabBarRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Buttons & Dialogs',
          onPressed: (context) {
            log('Buttons Clicked');
            context.pushRoute(const AppButtonRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Text Inputs',
          onPressed: (context) {
            context.pushRoute(const AppTextInputRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Display & Feedback',
          onPressed: (context) {
            context.pushRoute(const AppDisplayRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Nudges',
          onPressed: (context) {
            context.pushRoute(const AppNudgesRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'List Screen',
          onPressed: (context) {
            context.pushRoute(const AppListRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Grid Screen',
          onPressed: (context) {
            context.pushRoute(const AppGridRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'List Item Screen',
          onPressed: (context) {
            context.pushRoute(const AppListItemRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Form Screen',
          onPressed: (context) {
            context.pushRoute(const AppFormRoute());
          },
        ),
        DrawerItemChildren(
          iconPath: AppIcons.svg.drawer.notePencil,
          title: 'Intro Transition Screen',
          onPressed: (context) {
            context.pushRoute(const IntroTransitionRoute());
          },
        ),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter(
      routes: const [
        ProductsTabRoute(),
        InsightTabRoute(),
        HomeTabRoute(),
        ServeTabRoute(),
        CommunityTabRoute(),
      ],
      homeIndex: 2, // 👈 usually Home should be center
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final userName = context.select<UserProfileBloc, String>(
          (bloc) => bloc.state.profile?.name ?? '',
        );
        return AppPrimaryBgContainer(
          child: PopScope(
            canPop: false, // 👈 we fully control back behavior
            onPopInvokedWithResult: (didPop, result) {
              // If system already handled pop → do nothing
              if (didPop) return;

              // 👇 1. Close drawer if open
              if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
                _scaffoldKey.currentState?.closeDrawer();
                return;
              }

              // 👇 2. Handle AutoRoute navigation stack
              if (context.router.canPop()) {
                context.router.pop();
                return;
              }

              AppDialog.show(
                context: context,
                title: 'Exit PoochCare',
                content: 'Are you sure you want to exit the app?',
                primaryLabel: 'Exit',
                secondaryLabel: 'Cancel',
                onPrimary: () async {
                  // Navigator.of(context).pop(true); // 👈 close dialog
                  SystemNavigator.pop(); // 👈 exit app (Android)
                  return true;
                },
              );

              // 👇 3. Allow app to exit (root level)
              // Navigator.of(context).maybePop();
            },
            child: Scaffold(
              key: _scaffoldKey, // 👈
              backgroundColor: AppColors.transparent, // ✅ IMPORTANT
              appBar: PoochAppBar(
                onMenuTap: () {
                  _scaffoldKey.currentState?.openDrawer(); //  👈
                },
                userName: userName,
                welcomeText: 'Welcome 👋🏻',

                /// 🔥 ADD THIS
                actions: tabsRouter.activeIndex == 3
                    ? [
                        PoochAppBarAction(
                          icon: WishlistIconWithBadge(
                            onTap: () {
                              context.router.push(const WishlistRoute());
                            },
                          ),
                        ),

                        /// 👇 future cart
                        PoochAppBarAction(
                          icon: CartIconWithBadge(
                            onTap: () {
                              context.router.push(CartRoute());
                            },
                          ),
                        ),
                      ]
                    : null,
                // backgroundColor: AppColors.transparent,
              ),

              // appBar: AppBar(
              //   title: const Text('Pooch Home'),
              //   actions: [
              //     IconButton(
              //       onPressed: () {
              //         context.read<HomeBloc>().add(const ThemeToggleRequested());
              //       },
              //       icon: const Icon(Icons.brightness_6_outlined),
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         context.read<HomeBloc>().add(const LogoutRequested());
              //       },
              //       icon: const Icon(Icons.logout),
              //     ),
              //   ],
              // ),
              drawer: AppDrawer(
                theme: theme,
                drawerItems: _drawerItem,
                socialMediaIcons: socialMediaIcons,
              ),

              /// 🔥 MAIN BODY
              body: Stack(
                children: [
                  /// ✅ BACKGROUND LAYER (fix black issue)
                  Container(color: AppColors.transparent),

                  /// 🔹 CONTENT (tabs)
                  Positioned.fill(
                    child: tabsRouter.activeIndex != 2
                        ? child
                        : RefreshIndicator(
                            onRefresh: _onPullToRefresh,
                            notificationPredicate: (_) => true,
                            child:
                                BlocSelector<HomeBloc, HomeState, HomeStatus>(
                                  selector: (state) => state.status,
                                  builder: (context, status) {
                                    if (status == HomeStatus.loading ||
                                        status == HomeStatus.initial) {
                                      return const AppLoader();
                                    }
                                    return child;
                                  },
                                ),
                          ),
                    // : RefreshIndicator(
                    //     onRefresh: _onPullToRefresh,
                    //     notificationPredicate: (_) => true,
                    //     child:
                    //         BlocSelector<HomeBloc, HomeState, HomeStatus>(
                    //           selector: (state) => state.status,
                    //           builder: (context, status) {
                    //             if (status == HomeStatus.loading ||
                    //                 status == HomeStatus.initial) {
                    //               return const AppLoader();
                    //             }
                    //             return child;
                    //           },
                    //         ),
                    //   ),
                  ),

                  // if (tabsRouter.activeIndex == 2)
                  //   Positioned(
                  //     right: 16.w,
                  //     bottom: 90.h,
                  //     child: FloatingActionButton.extended(
                  //       heroTag: 'add_pet_fab',
                  //       backgroundColor: AppColors.p5_900,
                  //       onPressed: () {
                  //         context.pushRoute(const AddPetProfileRoute());
                  //       },
                  //       icon: const Icon(Icons.add, color: AppColors.white),
                  //       label: const Text(
                  //         'Add Pet',
                  //         style: TextStyle(color: AppColors.white),
                  //       ),
                  //     ),
                  //   ),

                  /// 🔥 FLOATING BOTTOM TAB
                  Positioned(
                    left: 10.h,
                    right: 10.h,
                    bottom: 10.h,
                    child: AppBottomTabNav(
                      onChanged: (index) {
                        if (index == 3) {
                          // Serve tab - set active index first, then show full screen transition
                          tabsRouter.setActiveIndex(index);
                          context.router.push(const EcommerceTransitionRoute());
                        } else {
                          tabsRouter.setActiveIndex(index);
                        }
                      },
                      currentIndex: tabsRouter.activeIndex,
                      items: [
                        // Explore Tab
                        AppBottomTabNavItem(
                          iconPath: AppIcons.svg.tabs.verify,
                          title: 'Explore',
                        ),
                        //Insight Tab
                        AppBottomTabNavItem(
                          iconPath: AppIcons.svg.tabs.pentagon,
                          title: 'Insight',
                        ),
                        // Home Tab
                        AppBottomTabNavItem(
                          iconPath: AppIcons.svg.tabs.paw,
                          title: 'Home',
                        ),
                        //Serve Tab
                        AppBottomTabNavItem(
                          // iconPath: 'assets/icons/svg/tabs/clipboard.svg',
                          iconPath: AppIcons.svg.tabs.clipboard,
                          title: 'Serve',
                        ),

                        // Groups Tab
                        AppBottomTabNavItem(
                          iconPath: AppIcons.svg.tabs.group,
                          title: 'Groups',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
