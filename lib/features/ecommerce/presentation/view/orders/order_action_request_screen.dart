import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/order_action_bottom_sheet.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_bottom_actions.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_id_row.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_item_pet_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/refund_info_row.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/sections/reason_for_cancellation_section.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class OrderActionRequestScreen extends StatelessWidget {
  const OrderActionRequestScreen({
    super.key,
    required this.order,
    required this.type,
  });

  final OrderItemModel order;
  final OrderRequestType type;

  bool get _isReturn => type == OrderRequestType.returnOrder;

  List<CancellationReasonOption> _buildReasons() {
    return const [
      CancellationReasonOption(id: 'wrong_item', label: 'Received wrong pooch'),
      CancellationReasonOption(id: 'damaged', label: 'Item damaged'),
      CancellationReasonOption(id: 'not_as_expected', label: 'Not as expected'),
      CancellationReasonOption(id: 'others', label: 'Others'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: Column(
          children: [
            PoochScreenAppBar(
              title: _isReturn ? 'Request Return' : 'Request cancellation',
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 1. Pet Card
                    OrderItemPetCard(
                      model: const OrderItemPetCardModel(
                        id: 'pet_1',
                        image:
                            'https://images.unsplash.com/photo-1558788353-f76d92427f16',
                        title: 'Great Anglo-French White & Orange hound, 2 yrs',
                        gender: 'Female',
                        healthStatus: 'Vaccinated & Dewormed',
                        price: 6010,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pet card tapped!')),
                        );
                      },
                    ),

                    AppSpacing.s10.hBox,

                    /// 2. Order Id
                    OrderIdRow(orderId: order.orderId),

                    AppSpacing.s10.hBox,

                    /// 3. Reason Section (UNIFIED)
                    ReasonForCancellationSection(
                      cancellationReasons: _buildReasons(),
                      refundAmount: order.price,
                    ),

                    AppSpacing.s10.hBox,

                    const RefundInfoRows(
                      orderStatus: 'approved',
                      refundPolicy:
                          'Refund will be processed within 5-7 business days after we receive the returned item. Please ensure the item is in its original condition.',
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            OrderBottomActions(
              order: order,
              primaryLabel: _isReturn
                  ? 'Continue To Return'
                  : 'Request Cancellation',
              onPrimaryAction: () {
                OrderActionBottomSheet.show(
                  context: context,
                  mode: OrderActionBottomSheetMode.confirm,
                  order: order,
                  refundAmount: '₹${order.price}',
                  refundPolicy: 'Refund will be processed in 5-7 days',
                  selectedReason: 'Wrong item',
                  cancellationFee: _isReturn ? null : '₹50',
                  tracking: const [],
                  onConfirm: () {
                    // 👉 CALL API HERE
                    // then optionally open status bottom sheet
                    context.router.replace(
                      CancelOrderTransitionRoute(
                        orderId: order.orderId,
                        itemId: order.itemId,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
