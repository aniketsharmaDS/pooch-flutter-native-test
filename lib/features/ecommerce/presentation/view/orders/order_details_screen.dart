import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/data/mappers/orders/order_stepper_mapper.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_state.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/order_action_bottom_sheet.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/order_track_bottom_sheet.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/otp_display_bottom_sheet.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_bottom_actions.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_id_row.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_item_pet_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/sections/order_delivery_section.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/sections/order_summary_section.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.itemId,
  });

  final String orderId;
  final String itemId;

  @override
  Widget build(BuildContext context) {
    // final (steps, currentStep) = OrderStepperMapper.map(order);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<OrderDetailBloc>();

      /// avoid reloading same order again
      final currentItemId = bloc.state.order?.items
          .firstWhere(
            (item) => item.itemId == itemId,
            orElse: () => bloc.state.order!.items.first,
          )
          .itemId;

      if (bloc.state.order == null ||
          bloc.state.order!.orderId != orderId ||
          currentItemId != itemId) {
        bloc.add(LoadOrderDetail(orderId, itemId, forceRefresh: true));
      }
    });

    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
            builder: (context, state) {
              /// 🔄 Loading
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              /// ❌ Error
              if (state.error != null) {
                return Center(child: Text(state.error!));
              }

              final order = state.order;

              if (order == null || order.items.isEmpty) {
                return const Center(child: Text('No order items found'));
              }

              /// 🔥 GET REQUESTED ITEM (not just first)
              final requestedItem = order.items.firstWhere(
                (item) => item.itemId == itemId,
                orElse: () => order.items.first,
              );

              final (steps, currentStep) = OrderStepperMapper.map(
                requestedItem,
              );

              final itemCancelStatus = requestedItem.cancellationStatus
                  ?.toLowerCase();
              final isCancellationActive =
                  itemCancelStatus == 'pending' ||
                  itemCancelStatus == 'request_raised' ||
                  itemCancelStatus == 'been_reviewed' ||
                  itemCancelStatus == 'approved';

              /// CHECK ITEM STATUS, NOT ORDER STATUS
              // final isDelivered =
              //     requestedItem.status.toLowerCase() == 'delivered';

              final isDelivered =
                  requestedItem.rawStatus.toLowerCase() == 'delivered';
              return Column(
                children: [
                  const PoochScreenAppBar(title: 'Order Details'),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<OrderDetailBloc>().add(
                          RefreshOrderDetail(orderId, itemId),
                        );
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrderItemPetCard(
                              model: OrderItemPetCardModel(
                                id: requestedItem.orderId,
                                image: requestedItem.image,
                                title: requestedItem.title,
                                gender: requestedItem.subtitle,
                                healthStatus: requestedItem.isVaccinated == true
                                    ? 'Vaccinated'
                                    : 'Not Vaccinated',
                                price: requestedItem.price,
                              ),
                              onTap: () {},
                            ),
                            AppSpacing.s10.hBox,

                            OrderIdRow(orderId: order.orderNumber),
                            AppSpacing.s10.hBox,

                            if (requestedItem.status.toLowerCase() ==
                                'delivered') ...[
                              _deliveredRow(),
                              AppSpacing.s10.hBox,
                            ],

                            // AppSpacing.s10.hBox,
                            DeliverySection(
                              address: order.address,
                              status: requestedItem.status,
                              onValidationTap: () {
                                OTPDisplayBottomSheet.show(
                                  context: context,
                                  otp: requestedItem.deliveryOtp ?? 'N/A',
                                );
                              },
                            ),
                            AppSpacing.s10.hBox,

                            OrderSummarySection(
                              itemCount: 1,
                              mrp: requestedItem.basePrice,
                              deliveryFee: requestedItem.deliveryFee,
                              discountAmount: requestedItem.discountAmount ?? 0,
                              tax: requestedItem.taxAmount,
                              total: requestedItem.finalPrice,
                            ),
                            const SizedBox(height: 100), // space for bottom bar
                          ],
                        ),
                      ),
                    ),
                  ),

                  // DELIVERED → ONLY NEED HELP
                  // 🔥 DELIVERED → ONLY NEED HELP
                  if (isDelivered)
                    OrderBottomActions(
                      order: requestedItem,
                      needHelpPosition: NeedHelpPosition.top,
                    )
                  // 🔥 CANCELLATION FLOW (request_raised / reviewed / approved)
                  else if (isCancellationActive)
                    OrderBottomActions(
                      order: requestedItem,
                      centerLabel: 'Cancellation Status',
                      onCenterAction: () {
                        OrderActionBottomSheet.show(
                          context: context,
                          mode: OrderActionBottomSheetMode.status,
                          order: requestedItem,
                          refundPolicy: order.refundPolicy ?? '',
                          refundAmount: order.totalAmount.toString(),
                          tracking: order.cancellationTracking,
                          selectedReason:
                              requestedItem.cancellationReason ?? '',
                        );
                      },
                    )
                  //  NORMAL FLOW (includes rejected OR no cancellation)
                  else
                    OrderBottomActions(
                      order: requestedItem,
                      primaryLabel: 'Track Order',
                      secondaryLabel: 'Cancel Order',

                      onSecondaryAction: () {
                        context.router.push(
                          RequestCancellationRoute(
                            orderId: requestedItem.orderId,
                            itemId: requestedItem.itemId,
                          ),
                        );
                      },

                      onPrimaryAction: () {
                        OrderTrackBottomSheet.show(
                          context: context,
                          order: requestedItem,
                          steps: steps,
                          currentStep: currentStep,
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _deliveredRow() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s16.w,
        vertical: AppSpacing.s16.h,
      ),
      height: AppSize.cs80.h,
      color: const Color(0xFF22C55E).withValues(alpha: 0.7),
      child: Row(
        children: [
          AppIcon(
            AppIcons.svg.orders.package,
            // color: AppColors.white_50,
            size: 25,
          ),

          AppSpacing.s15.wBox,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.h1(
                'Delivered',
                color: AppColors.white_50,
                fontSize: AppFontSize.fs16,
              ),
              AppSpacing.s4.hBox,
              // SizedBox(height: 2.h),
              AppText.bodyM('On Nov, 14th Nov 2026', color: AppColors.white_50),
            ],
          ),
        ],
      ),
    );
  }
}
