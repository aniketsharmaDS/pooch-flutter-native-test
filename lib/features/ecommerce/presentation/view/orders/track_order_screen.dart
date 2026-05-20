import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/stepper/app_vertical_stepper.dart';
import 'package:poochcare/features/ecommerce/data/mappers/orders/order_tracking_mapper.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_state.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/order_action_bottom_sheet.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/otp_display_bottom_sheet.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_bottom_actions.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_item_basic_card.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({
    super.key,
    required this.orderId,
    required this.itemId,
  });

  // final OrderItemModel order;
  // final OrderDetailModel? orderDetail;

  final String orderId;
  final String itemId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<OrderDetailBloc>()..add(LoadOrderDetail(orderId, itemId)),
      child: _TrackOrderView(itemId: itemId),
    );
  }
}

class _TrackOrderView extends StatelessWidget {
  final String itemId;

  const _TrackOrderView({required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
          builder: (context, state) {
            /// 🔄 Loading (inside layout)
            if (state.isLoading) {
              return const Column(
                children: [
                  PoochScreenAppBar(title: 'Track your Order'),
                  Expanded(child: Center(child: CircularProgressIndicator())),
                ],
              );
            }

            /// ❌ Error
            if (state.error != null && state.error!.isNotEmpty) {
              return Column(
                children: [
                  const PoochScreenAppBar(title: 'Track your Order'),
                  Expanded(child: Center(child: Text(state.error!))),
                ],
              );
            }

            final orderDetail = state.order;

            /// ⚠️ Empty
            if (orderDetail == null || orderDetail.items.isEmpty) {
              return const Column(
                children: [
                  PoochScreenAppBar(title: 'Track your Order'),
                  Expanded(child: Center(child: Text('No tracking data'))),
                ],
              );
            }

            /// 🔥 GET REQUESTED ITEM (not just first)
            final requestedItem = orderDetail.items.firstWhere(
              (item) => item.itemId == itemId,
              orElse: () => orderDetail.items.first,
            );

            final (steps, currentStep) = OrderTrackingMapper.map(
              order: orderDetail,
              item: requestedItem,
            );

            /// 🔥 CHECK ITEM STATUS FOR BOTTOM ACTIONS
            final itemCancelStatus = requestedItem.cancellationStatus
                ?.toLowerCase();
            final isCancellationActive =
                itemCancelStatus == 'pending' ||
                itemCancelStatus == 'request_raised' ||
                itemCancelStatus == 'been_reviewed' ||
                itemCancelStatus == 'approved';

            final isDelivered =
                requestedItem.status.toLowerCase() == 'delivered';

            /// 🔥 CHECK IF OUT FOR DELIVERY
            final isOutForDelivery =
                requestedItem.status.toLowerCase() == 'out_for_delivery';

            /// ✅ MAIN UI
            return Column(
              children: [
                const PoochScreenAppBar(title: 'Track your Order'),

                AppSpacing.s16.hBox,

                Expanded(
                  child: Container(
                    color: AppColors.white_50,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<OrderDetailBloc>().add(
                          LoadOrderDetail(
                            forceRefresh: true,
                            requestedItem.orderId,
                            requestedItem.itemId,
                          ),
                        );
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrderItemBasicCard(order: requestedItem),
                            AppSpacing.s16.hBox,

                            AppVerticalStepper(
                              items: steps,
                              currentStep: currentStep,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// 🔥 CONDITIONAL BOTTOM ACTIONS BASED ON ITEM STATUS
                if (isDelivered)
                  OrderBottomActions(
                    order: requestedItem,
                    needHelpPosition: NeedHelpPosition.top,
                  )
                // 🔥 OUT FOR DELIVERY → VALIDATION CODE + CANCEL ORDER
                else if (isOutForDelivery)
                  OrderBottomActions(
                    order: requestedItem,
                    primaryLabel: 'Validation Code',
                    secondaryLabel: 'Cancel Order',
                    onPrimaryAction: () {
                      OTPDisplayBottomSheet.show(
                        context: context,
                        otp: requestedItem.deliveryOtp ?? 'N/A',
                      );
                    },
                    onSecondaryAction: () {
                      context.router.push(
                        // RequestCancellationRoute(order: requestedItem),
                        RequestCancellationRoute(
                          orderId: requestedItem.orderId,
                          itemId: requestedItem.itemId,
                        ),
                      );
                    },
                  )
                else if (isCancellationActive)
                  OrderBottomActions(
                    order: requestedItem,
                    centerLabel: 'Cancellation Status',
                    onCenterAction: () {
                      OrderActionBottomSheet.show(
                        context: context,
                        mode: OrderActionBottomSheetMode.status,
                        order: requestedItem,
                        refundPolicy: orderDetail.refundPolicy ?? '',
                        refundAmount: orderDetail.totalAmount.toString(),
                        tracking: orderDetail.cancellationTracking,
                        selectedReason: requestedItem.cancellationReason ?? '',
                      );
                    },
                  )
                // 🔥 NORMAL FLOW → ONLY CANCEL ORDER (CENTER)
                else
                  OrderBottomActions(
                    order: requestedItem,
                    centerLabel: 'Cancel Order',
                    onCenterAction: () {
                      context.router.push(
                        RequestCancellationRoute(
                          orderId: requestedItem.orderId,
                          itemId: requestedItem.itemId,
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
