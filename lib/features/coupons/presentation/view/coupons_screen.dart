import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/data/models/coupon/coupon_model.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_state.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch first page
    context.read<CouponsBloc>().add(const FetchCouponsEvent());
  }

  Future<void> _onRedeem(Coupon coupon) async {
    final types = coupon.rules?.isNotEmpty == true
        ? coupon.rules!.first.targetProductTypes
        : <String>[];

    if (types.isEmpty) {
      // No target types available
      await showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('No eligible targets'),
          content: const Text('This coupon has no target product types.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final choice = await showDialog<String?>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Use coupon for'),
        children: types.map((t) {
          final label = _labelForType(t);
          return SimpleDialogOption(
            onPressed: () => Navigator.of(ctx).pop(t),
            child: Text(label),
          );
        }).toList(),
      ),
    );

    if (choice == null) return;
    if (!mounted) return;

    // Navigate based on choice
    switch (choice.toLowerCase()) {
      case 'accessories':
        context.router.push(AccessoriesRoute(couponCode: coupon.couponCode));
        break;
      case 'products':
        context.router.push(const BuyPetListingRoute());
        break;
      case 'subscriptions':
      case 'subscription':
      case 'consultations':
      case 'consultation':
        context.router.push(const InsightVetsRoute());
        break;
      default:
        // default to generic vets screen
        context.router.push(const InsightVetsRoute());
        break;
    }
  }

  String _labelForType(String raw) {
    final s = raw.toLowerCase();
    if (s.contains('access')) return 'Accessories';
    if (s.contains('product')) return 'Products';
    if (s.contains('sub')) return 'Subscriptions';
    if (s.contains('consult')) return 'Consultations';
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: Column(
            children: [
              const PoochScreenAppBar(title: 'Offers available for you'),
              const SizedBox(height: AppSpacing.s10),
              Expanded(
                child: BlocBuilder<CouponsBloc, CouponsState>(
                  builder: (context, state) {
                    if (state.status == CouponsStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == CouponsStatus.failure) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText.h3('Failed to load coupons'),
                            const SizedBox(height: 8),
                            AppButton(
                              label: 'Retry',
                              onPressed: () {
                                context.read<CouponsBloc>().add(
                                  const FetchCouponsEvent(),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }

                    final coupons = state.coupons;
                    if (coupons.isEmpty) {
                      return Center(child: AppText.h3('No offers found'));
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<CouponsBloc>().add(
                          const FetchCouponsEvent(),
                        );
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: coupons.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final coupon = coupons[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s8,
                              vertical: AppSpacing.s10,
                            ),
                            // margin: const EdgeInsets.symmetric(
                            //   horizontal: AppSpacing.s16,
                            // ).copyWith(bottom: AppSpacing.s15),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(
                                AppRadiusSize.r12,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.s8,
                                    vertical: AppSpacing.s10,
                                  ),
                                  height: 70.h,
                                  width: 70.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppRadiusSize.r10,
                                    ),
                                    color: AppColors.p1_50,
                                  ),
                                  child: AppIcon(
                                    AppIcons.svg.generic.poochTail,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.s15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.h1(
                                        coupon.title ??
                                            coupon.description ??
                                            '',
                                        fontSize: AppFontSize.fs14,
                                      ),
                                      const SizedBox(height: AppSpacing.s30),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AppIcon(
                                                AppIcons
                                                    .svg
                                                    .generic
                                                    .sealPercent,
                                                size: 13,
                                              ),
                                              const SizedBox(
                                                width: AppSpacing.s2,
                                              ),
                                              AppText.bodyM(
                                                'Offer',
                                                fontSize: AppFontSize.fs10,
                                              ),
                                            ],
                                          ),
                                          AppButton(
                                            onPressed: () => _onRedeem(coupon),
                                            height: 20.h,
                                            label: 'Redeem Now',
                                            width: null,
                                            size: AppButtonSize.small,
                                            textStyle: AppTypography.h3
                                                .copyWith(
                                                  fontSize: AppFontSize.fs12,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
