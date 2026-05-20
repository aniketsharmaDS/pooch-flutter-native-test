import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_message_model.dart';
import 'package:poochcare/features/ecommerce/data/models/get_help/get_help_option_ui_model.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/get_help/get_help_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/get_help/get_help_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/get_help/get_help_state.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/get_help/chat_bubble.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/get_help/options_group.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/get_help/pet_see_result_view.dart';

class GetHelpChatMessageTile extends StatelessWidget {
  final GetHelpMessageModel message;
  final bool isAnswered;
  final void Function(GetHelpOptionUIModel option)? onOptionSelected;

  const GetHelpChatMessageTile({
    super.key,
    required this.message,
    this.isAnswered = false,
    this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final hasOptions =
        !message.isUser &&
        message.options != null &&
        message.options!.isNotEmpty;

    // if (message.isCTA) {
    //   final state = context.watch<GetHelpBloc>().state;

    //   if (state.hasRequestedRecommendations) {
    //     return const SizedBox.shrink();
    //   }

    //   return PetSeeResultView(
    //     onTap: () {
    //       context.read<GetHelpBloc>().add(FetchRecommendations());
    //     },
    //   );
    // }

    if (message.isCTA) {
      final state = context.watch<GetHelpBloc>().state;

      if (state.hasOpenedRecommendations) {
        return const SizedBox.shrink();
      }

      return PetSeeResultView(
        onTap: () {
          context.read<GetHelpBloc>().add(OpenRecommendations());
        },
      );
    }

    if (message.isEmpty) {
      return _buildEmptyCard(context);
    }

    if (message.isHooray) {
      return _buildHoorayCard();
    }

    if (message.isStageSeparator) {
      return _buildStageSeparator(message.stageTitle ?? '');
    }

    final isUser = message.isUser;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.s12.h),
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (!message.isTyping)
            GetHelpChatBubble(
              text: message.text,
              type: isUser ? GetHelpBubbleType.user : GetHelpBubbleType.system,
              child: hasOptions
                  ? GetHelpOptionsGroup(
                      options: message.options!,
                      onOptionSelected: (option) {
                        if (isAnswered) return;
                        onOptionSelected?.call(option);
                      },
                    )
                  : null,
            ),

          // Typing indicator outside bubble
          if (message.isTyping && !isUser)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s14.w),
              child: _buildTypingIndicator(),
            ),
          if (isUser && message.createdAt != null && !message.isTyping)
            Padding(
              padding: EdgeInsets.only(
                top: AppSpacing.s4.h,
                right: isUser ? AppSpacing.s8.w : 0,
                left: isUser ? 0 : AppSpacing.s8.w,
              ),
              child: AppText.support(
                formatTime(message.createdAt!),
                color: const Color(0xFF656565),
              ),
            ),
        ],
      ),
    );
  }

  String formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final ampm = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $ampm';
  }

  Widget _buildEmptyCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSpacing.s12.h),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s14.w,
        vertical: AppSpacing.s12.h,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppRadiusSize.r25),
          bottomLeft: Radius.circular(AppRadiusSize.r12),
          bottomRight: Radius.circular(AppRadiusSize.r12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h1('Ooops!', color: AppColors.p2),
          SizedBox(height: AppSpacing.s8.h),
          AppText.bodyL(
            maxLines: 5,
            'We couldn’t find any pets based on your preferences.\nTry adjusting your answers or explore manually.',
            fontSize: AppFontSize.fs14,
          ),
          SizedBox(height: AppSpacing.s16.h),

          BlocBuilder<GetHelpBloc, GetHelpState>(
            builder: (context, state) {
              final isLoading = state.isLoadingRecommendations;

              return AppButton(
                label: isLoading ? '' : 'Try Again',
                onPressed: () {
                  context.read<GetHelpBloc>().add(StartGetHelp());
                },
                isLoading: isLoading,
                isDisabled: state.isLoading,
                height: AppSize.cs40,
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textPrimary,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHoorayCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSpacing.s12.h),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s14.w,
        vertical: AppSpacing.s10.h,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          // topLeft: Radius.circular(AppRadiusSize.r12),
          topRight: Radius.circular(AppRadiusSize.r25),
          bottomLeft: Radius.circular(AppRadiusSize.r12),
          bottomRight: Radius.circular(AppRadiusSize.r12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h1('Hooray!', color: AppColors.p2),
          SizedBox(height: AppSpacing.s8.h),
          AppText.bodyL(
            maxLines: 5,
            fontSize: AppFontSize.fs14,
            'We have curated the Pooches you and your home will love. Now, select your pooch and bring them home!',
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return SizedBox(
      height: 30, // make it a bit taller
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _dot(), // first dot
          const SizedBox(width: 6),
          _dot(delay: 150), // second dot
          const SizedBox(width: 6),
          _dot(delay: 300), // third dot
        ],
      ),
    );
  }

  Widget _dot({
    Color color = AppColors.p1_400,
    double size = 12,
    int delay = 0,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        // value goes 0 → 1 repeatedly
        final yOffset = (1 - value) * 6; // dot “bounces” vertically
        final opacity = 0.3 + value * 0.7; // fade in/out smoothly
        return Transform.translate(
          offset: Offset(0, -yOffset),
          child: Opacity(opacity: opacity, child: child),
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      onEnd: () async {
        await Future<void>.delayed(Duration(milliseconds: delay));
      },
    );
  }

  Widget _buildStageSeparator(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.s16.h),
      child: Row(
        children: [
          const Expanded(child: Divider(color: AppColors.p1_400)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.p1_400),
              borderRadius: BorderRadius.circular(20),
              color: AppColors.p1_400,
            ),
            child: AppText.h4(title, fontSize: AppFontSize.fs12),
          ),
          const Expanded(child: Divider(color: AppColors.p1_400)),
        ],
      ),
    );
  }
}
