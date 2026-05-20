import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

enum GetHelpBubbleType { system, user }

class GetHelpChatBubble extends StatelessWidget {
  final String text;
  final GetHelpBubbleType type;
  final Widget? child;

  const GetHelpChatBubble({
    super.key,
    required this.text,
    required this.type,
    this.child,
  });

  bool get isUser => type == GetHelpBubbleType.user;

  @override
  Widget build(BuildContext context) {
    final hasChild = child != null;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Container(
          // margin: EdgeInsets.symmetric(vertical: AppSpacing.s6.h),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.s14.w,
            vertical: AppSpacing.s10.h,
          ),
          decoration: BoxDecoration(
            color: isUser
                ? AppColors.p1_400
                : hasChild
                ? Colors
                      .white // 👈 ONLY when options exist
                : AppColors.white,
            borderRadius: _borderRadius(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.h4(
                text,
                fontSize: AppFontSize.fs14,
                color: AppColors.textPrimary,
                maxLines: 20,
              ),

              if (child != null) ...[
                SizedBox(height: AppSpacing.s12.h),
                child!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius _borderRadius() {
    if (isUser) {
      return const BorderRadius.only(
        topLeft: Radius.circular(AppRadiusSize.r12),
        // topRight: Radius.circular(AppRadiusSize.r12),
        bottomLeft: Radius.circular(AppRadiusSize.r12),
        bottomRight: Radius.circular(AppRadiusSize.r12),
      );
    } else {
      return const BorderRadius.only(
        // topLeft: Radius.circular(AppRadiusSize.r12),
        topRight: Radius.circular(AppRadiusSize.r25),
        bottomLeft: Radius.circular(AppRadiusSize.r12),
        bottomRight: Radius.circular(AppRadiusSize.r12),
      );
    }
  }
}
