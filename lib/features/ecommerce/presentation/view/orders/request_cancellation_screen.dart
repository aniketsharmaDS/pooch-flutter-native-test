import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';

import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_support/order_support_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_support/order_support_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_support/order_support_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_event.dart';

import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/order_action_bottom_sheet.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_bottom_actions.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_id_row.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_item_pet_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/refund_info_row.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/sections/reason_for_cancellation_section.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/shimmers/reason_for_cancellation_section_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class RequestCancellationScreen extends StatefulWidget {
  const RequestCancellationScreen({
    super.key,
    required this.orderId,
    required this.itemId,
  });

  // final OrderItemModel order;
  final String orderId;
  final String itemId;

  @override
  State<RequestCancellationScreen> createState() =>
      _RequestCancellationScreenState();
}

class _RequestCancellationScreenState extends State<RequestCancellationScreen> {
  // List<CancellationReasonOption> _buildReasons() {
  //   return const [
  //     CancellationReasonOption(id: 'wrong_item', label: 'Received wrong pooch'),
  //     CancellationReasonOption(id: 'damaged', label: 'Item damaged'),
  //     CancellationReasonOption(id: 'not_as_expected', label: 'Not as expected'),
  //     CancellationReasonOption(id: 'others', label: 'Others'),
  //   ];
  // }

  String? selectedReasonCode;
  String? selectedReasonLabel;
  String? otherReasonText;

  List<File> selectedImages = [];

  String getFinalReason() {
    if (selectedReasonCode == 'others') {
      return (otherReasonText ?? '').trim();
    }
    return selectedReasonCode ?? '';
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderDetailBloc>().add(
        LoadOrderDetail(widget.orderId, widget.itemId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OrderSupportBloc>()
        ..add(ResetOrderSupport())
        ..add(LoadCancellationReasons()),
      child: BlocListener<OrderSupportBloc, OrderSupportState>(
        listener: (context, state) {
          if (state.isSuccess) {
            final itemId = widget.itemId;
            final reason = getFinalReason();

            // 1. Update Order List (Global)
            context.read<OrderBloc>().add(
              UpdateOrderItemStatus(
                itemId: itemId,
                newStatus: 'Cancelled',
                newRawStatus: 'cancelled',
                cancellationStatus: 'approved',
                cancellationReason: reason,
              ),
            );

            /// 2. UPDATE ORDER DETAIL (IF PRESENT)
            final detailBloc = context.read<OrderDetailBloc>();

            if (detailBloc.state.order != null) {
              detailBloc.add(
                UpdateOrderDetailItem(
                  itemId: itemId,
                  status: 'Cancelled',
                  rawStatus: 'cancelled',
                  cancellationStatus: 'approved',
                  cancellationReason: reason,
                ),
              );
            }

            // 3. Now navigate
            // context.router.replace(
            //   CancelOrderTransitionRoute(order: widget.order),
            // );
            context.router.replace(
              CancelOrderTransitionRoute(
                orderId: widget.orderId,
                itemId: widget.itemId,
              ),
            );
          }

          if (state.error != null) {
            ToastService.showError(state.error!);
          }
        },
        child: Scaffold(
          body: AppPrimaryBgContainer(
            child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
              builder: (context, detailState) {
                if (detailState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final order = detailState.order;

                if (order == null || order.items.isEmpty) {
                  return const Center(child: Text('No order found'));
                }

                final item = order.items.firstWhere(
                  (e) => e.itemId == widget.itemId,
                  orElse: () => order.items.first,
                );

                return Column(
                  children: [
                    const PoochScreenAppBar(title: 'Request Cancellation'),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 1. Pet Card
                            OrderItemPetCard(
                              model: OrderItemPetCardModel(
                                id: item.orderId,
                                image: item.image,
                                title: item.title,
                                gender: item.subtitle,
                                healthStatus: item.isVaccinated == true
                                    ? 'Vaccinated'
                                    : 'Not Vaccinated',
                                price: item.price,
                              ),
                              onTap: () {
                                ToastService.show('Pet card tapped!');
                              },
                            ),

                            AppSpacing.s10.hBox,

                            /// 2. Order Id
                            OrderIdRow(orderId: item.orderNumber),

                            AppSpacing.s10.hBox,

                            /// 3. Reason Section (UNIFIED)
                            BlocBuilder<OrderSupportBloc, OrderSupportState>(
                              builder: (context, state) {
                                if (state.isLoadingReasons) {
                                  return const ReasonForCancellationSectionShimmer();
                                }
                                return ReasonForCancellationSection(
                                  cancellationReasons: state.reasons,
                                  refundAmount: item.price,
                                  onReasonSelected: (reason) {
                                    setState(() {
                                      selectedReasonCode = reason;

                                      final selected = state.reasons.firstWhere(
                                        (e) => e.id == reason,
                                        orElse: () =>
                                            const CancellationReasonOption(
                                              id: '',
                                              label: '',
                                            ),
                                      );

                                      selectedReasonLabel = selected.label;
                                    });
                                  },

                                  onOtherReasonChanged: (text) {
                                    setState(() {
                                      otherReasonText = text;
                                    });
                                  },

                                  onImagesChanged: (files) {
                                    setState(() {
                                      selectedImages = files;
                                    });
                                  },
                                );
                              },
                            ),

                            AppSpacing.s10.hBox,

                            Container(
                              color: AppColors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s16.w,
                                  vertical: AppSpacing.s10.h,
                                ),
                                child:
                                    BlocBuilder<
                                      OrderSupportBloc,
                                      OrderSupportState
                                    >(
                                      builder: (context, state) {
                                        return RefundInfoRows(
                                          orderStatus: 'approved',
                                          refundPolicy: state.refundPolicy,
                                        );
                                      },
                                    ),
                              ),
                            ),

                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<OrderSupportBloc, OrderSupportState>(
                      builder: (context, state) {
                        return OrderBottomActions(
                          order: item,
                          primaryLabel: state.isSubmitting
                              ? 'Submitting...'
                              : 'Request Cancellation',
                          onPrimaryAction: state.isSubmitting
                              ? null
                              : () {
                                  if (selectedReasonCode == null ||
                                      selectedReasonCode!.isEmpty) {
                                    ToastService.show('Please select a reason');
                                    return;
                                  }

                                  if (selectedReasonCode == 'others' &&
                                      (otherReasonText == null ||
                                          otherReasonText!.trim().isEmpty)) {
                                    ToastService.show(
                                      'Please enter your reason',
                                    );
                                    return;
                                  }

                                  OrderActionBottomSheet.show(
                                    context: context,
                                    mode: OrderActionBottomSheetMode.confirm,
                                    order: item,
                                    refundAmount: '₹${item.price}',
                                    refundPolicy: state.refundPolicy,
                                    selectedReason: selectedReasonLabel ?? '',
                                    onConfirm: () {
                                      Navigator.pop(
                                        context,
                                      ); //  CLOSE bottom sheet first
                                      context.read<OrderSupportBloc>().add(
                                        SubmitOrderCancellation(
                                          orderId: widget.orderId,
                                          itemId: widget.itemId,
                                          reason: getFinalReason(),
                                          images: selectedImages,
                                        ),
                                      );
                                    },
                                  );
                                },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
