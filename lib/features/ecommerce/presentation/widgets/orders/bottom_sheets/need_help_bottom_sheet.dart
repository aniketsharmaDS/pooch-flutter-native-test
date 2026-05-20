import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_support/order_support_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_support/order_support_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_support/order_support_state.dart';

final getIt = GetIt.instance;

/// Opens a bottom sheet with help options for the order
void openNeedHelpBottomSheet(
  BuildContext context, {
  required String orderId,
  required String itemId,
}) {
  NeedHelpBottomSheet.show(context: context, orderId: orderId, itemId: itemId);
}

/// Unified Need Help Bottom Sheet using CustomBottomSheet
class NeedHelpBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required String orderId,
    required String itemId,
  }) {
    return AppBottomSheet.show(
      context: context,
      title: 'Need Help?',
      content: BlocProvider(
        create: (_) => getIt<OrderSupportBloc>(),
        child: _NeedHelpContent(orderId: orderId, itemId: itemId),
      ),
      actions: const [],
      backgroundColor: AppColors.primarybackground,
      closeBtnBgColor: AppColors.transparent,
      borderRadius: AppRadiusSize.r12,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s16.w,
        vertical: AppSpacing.s16.h,
      ),
    );
  }
}

/// ======================================================
/// NEED HELP CONTENT
/// ======================================================

class _NeedHelpContent extends StatefulWidget {
  final String orderId;
  final String itemId;

  const _NeedHelpContent({required this.orderId, required this.itemId});

  @override
  State<_NeedHelpContent> createState() => _NeedHelpContentState();
}

class _NeedHelpContentState extends State<_NeedHelpContent> {
  final TextEditingController _controller = TextEditingController();
  static const int minCharacters = 10;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {}); // Rebuild when text changes
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isTextValid => _controller.text.trim().length >= minCharacters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          AppText.h4(
            'Submit your issue below and someone from our team will review your concern and get back to you immediately.',
            color: AppColors.p3_900,
            maxLines: 5,
          ),

          // SizedBox(height: 16.h),
          AppSpacing.s16.hBox,

          // Text input with white background
          AppTextField(
            controller: _controller,
            minLines: 4,
            maxLines: 6,
            isTextArea: true,
            height: AppSize.cs150,
            label: 'Other reason to return',
            labelFontSize: AppFontSize.fs16,
          ),
          SizedBox(height: 20.h),

          // BlocListener for success/error handling
          BlocListener<OrderSupportBloc, OrderSupportState>(
            listener: (context, state) {
              if (state.error != null && state.error!.isNotEmpty) {
                ToastService.showError(state.error!);
              }

              if (state.isSuccess) {
                ToastService.showSuccess(
                  'Your issue has been submitted successfully!',
                );

                Navigator.pop(context);
                context.read<OrderSupportBloc>().add(ResetOrderSupport());
              }
            },
            child: BlocBuilder<OrderSupportBloc, OrderSupportState>(
              builder: (context, state) {
                return AppButton(
                  isLoading: state.isSubmitting,
                  onPressed: (state.isSubmitting || !_isTextValid)
                      ? null
                      : () {
                          final text = _controller.text.trim();

                          if (text.isEmpty || text.length < minCharacters) {
                            ToastService.show(
                              'Issue description must be at least $minCharacters characters',
                            );
                            return;
                          }

                          context.read<OrderSupportBloc>().add(
                            SubmitOrderIssue(
                              issue: text,
                              orderId: widget.orderId,
                              itemId: widget.itemId,
                            ),
                          );
                        },
                  label: 'Submit an Issue',
                  height: AppSize.cs48,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
