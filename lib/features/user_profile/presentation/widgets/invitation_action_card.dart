import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/invites/domain/models/invite_type.dart';
import 'package:poochcare/features/user_profile/presentation/widgets/app_tag.dart';

class InvitationActionCard extends StatelessWidget {
  final InviteType inviteType;
  final String status;
  final Color statusTextColor;
  final String name;
  final String email;
  final String actionTitle;
  final Color? statusBgColor;
  final VoidCallback onTapAction;
  final bool isActionLoading;
  const InvitationActionCard({
    super.key,
    this.inviteType = InviteType.coparent,
    required this.status,
    required this.statusTextColor,
    this.statusBgColor,
    required this.name,
    required this.email,
    required this.actionTitle,
    required this.onTapAction,
    this.isActionLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey<String>('invitation-action-${inviteType.name}'),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadiusSize.r10),
        color: AppColors.textFieldBackgroundDefault,
      ),
      height: 90.h,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppSpacing.s20,
          right: AppSpacing.s7,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppTag(
                        title: status,
                        color: statusTextColor,
                        backgroundColor: statusBgColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s10),

                  if (name.isNotEmpty) ...[
                    AppText.h4(
                      name,
                      fontSize: AppFontSize.fs16,
                      color: const Color(0xFF521703),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.s2),
                  AppText.h4(
                    email,
                    fontSize: AppFontSize.fs12,
                    color: const Color(0xFF7B4735),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: isActionLoading ? null : onTapAction,
              borderRadius: BorderRadius.circular(AppRadiusSize.r80),
              child: Container(
                alignment: Alignment.center,
                height: 36.h,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textPrimary),
                  borderRadius: BorderRadius.circular(AppRadiusSize.r80),
                ),
                child: isActionLoading
                    ? SizedBox(
                        width: 14.w,
                        height: 14.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.textPrimary,
                        ),
                      )
                    : AppText.h3(actionTitle, fontSize: AppFontSize.fs12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
