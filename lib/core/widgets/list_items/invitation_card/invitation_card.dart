import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/invites/domain/models/invite_list_scope.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_action_cubit/invite_action_cubit.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_action_cubit/invite_action_state.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_bloc.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';

enum InvitationMenuAction { removeAccess, unsendInvite, remind, leave }

class Invitation {
  final bool isRequestSent;
  final bool isAccepted;
  final bool useButterflyImage;

  final String petName;
  final String userName;
  final String ageGender;
  final String role;
  final String imageUrl;

  final bool isAcceptLoading;
  final bool isRejectLoading;
  final String id;
  final String parentGroupId;
  final String inviteeUserId;

  Invitation({
    required this.isRequestSent,
    required this.isAccepted,
    required this.useButterflyImage,
    required this.petName,
    required this.userName,
    required this.ageGender,
    required this.role,
    required this.imageUrl,
    required this.id,
    this.isAcceptLoading = false,
    this.isRejectLoading = false,
    required this.parentGroupId,
    required this.inviteeUserId,
  });
}

class InvitationCard extends StatelessWidget {
  final Invitation invitation;
  final InviteListScope listScope;

  const InvitationCard({
    super.key,
    required this.invitation,
    this.listScope = InviteListScope.myInvites,
  });

  bool get _showDecisionButtons =>
      !invitation.isRequestSent && !invitation.isAccepted;

  String get _sectionLabel =>
      invitation.isRequestSent ? 'Request sent' : 'Request Received';

  String get _statusLabel =>
      invitation.isAccepted ? 'Accepted' : 'Awaiting acceptance';

  Color get _statusBg =>
      invitation.isAccepted ? const Color(0xFFE9F9EF) : const Color(0xFFFFF9E9);

  Color get _statusTextColor =>
      invitation.isAccepted ? const Color(0xFF188C43) : const Color(0xFF8C6B15);

  bool get _isNetworkImage {
    final uri = Uri.tryParse(invitation.imageUrl);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  List<InvitationMenuAction> get _menuActions {
    if (invitation.isRequestSent && invitation.isAccepted) {
      return const [InvitationMenuAction.removeAccess];
    }
    if (invitation.isRequestSent && !invitation.isAccepted) {
      return const [
        InvitationMenuAction.unsendInvite,
        InvitationMenuAction.remind,
      ];
    }
    if (!invitation.isRequestSent && invitation.isAccepted) {
      return const [InvitationMenuAction.leave];
    }
    return const [];
  }

  @override
  Widget build(BuildContext context) {
    const headerHeight = 46.0;
    const overlapOffset = 18.0;

    return BlocConsumer<InviteActionCubit, InviteActionState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ToastService.show(state.errorMessage ?? '');
          return;
        }

        final completedAction = state.completedAction;
        if (completedAction == null) {
          return;
        }

        context.read<InviteBloc>().add(
          ApplyInviteActionEvent(
            action: completedAction,
            invitationId: invitation.id,
            scope: listScope,
          ),
        );

        if (completedAction == InviteActionType.accept ||
            completedAction == InviteActionType.leaveGroup) {
          context.read<UserProfileBloc>().add(const GetUserProfileEvent());
          context.read<UserProfileBloc>().add(const GetUserPetsEvent());
        }

        if (state.successMessage != null &&
            state.successMessage!.trim().isNotEmpty) {
          ToastService.show(state.successMessage ?? '');
        }
      },
      builder: (context, state) => Material(
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: invitation.isRequestSent
                      ? AppColors.p1_100
                      : AppColors.p2_100,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                ),
                child: AppText.support(
                  _sectionLabel,
                  color: const Color(0xFF2D2D2E),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: headerHeight - overlapOffset),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 6.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftSection(),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _buildRightSection(context: context, state: state),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSection() {
    return SizedBox(
      height: 100.h,
      // width: 106.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92.w,
            height: 73.h,
            child: invitation.useButterflyImage
                ? AppImageFrame(
                    width: 64.w,
                    height: 64.h,
                    imageUrl: invitation.imageUrl.isEmpty
                        ? AppIcons.png.explore.dogCat
                        : invitation.imageUrl,
                    // fit: BoxFit.contain,
                  )
                : _buildStandardImage(),
          ),
          SizedBox(height: 2.h),
          Container(
            width: 90.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFB3958B)),
              borderRadius: BorderRadius.circular(80.r),
            ),
            child: AppText.bodyS(
              invitation.petName,
              maxLines: 1,
              textAlign: TextAlign.center,
              color: const Color(0xFF7B4735),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStandardImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: SizedBox(
        width: 64.w,
        height: 64.h,
        child: _isNetworkImage
            ? AppImageCachedWidget(imageUrl: invitation.imageUrl)
            : AppIcon(invitation.imageUrl, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildRightSection({
    required BuildContext context,
    required InviteActionState state,
  }) {
    return SizedBox(
      height: 100.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildUserInfo()),
              SizedBox(width: 10.w),
              _buildStatusBadge(),
            ],
          ),
          // SizedBox(height: 12.h),
          if (_showDecisionButtons)
            _buildDecisionButtons(context: context, state: state)
          else if (_menuActions.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: _buildMenuTrigger(context: context),
            ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.bodyM(
          invitation.userName,
          maxLines: 1,
          color: const Color(0xFF521703),
        ),
        if (invitation.ageGender.trim().isNotEmpty)
          AppText.bodyS(
            invitation.ageGender,
            maxLines: 1,
            color: const Color(0xFFB3958B),
          ),
        AppText.bodyS(
          invitation.role,
          maxLines: 2,
          color: const Color(0xFFB3958B),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      // constraints: BoxConstraints(minHeight: 17.h, maxWidth: 150.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _statusBg,
        borderRadius: BorderRadius.circular(80.r),
      ),
      alignment: Alignment.center,
      child: AppText.support(
        _statusLabel,
        maxLines: 1,
        color: _statusTextColor,
      ),
    );
  }

  Widget _buildDecisionButtons({
    required BuildContext context,
    required InviteActionState state,
  }) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            label: 'Accept',
            onPressed: () {
              context.read<InviteActionCubit>().accept(invitation.id);
            },
            isLoading: state.processingAction == InviteActionType.accept,
            height: 30.h,
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: AppButton(
            label: 'Reject',
            onPressed: () =>
                context.read<InviteActionCubit>().reject(invitation.id),
            isLoading: state.processingAction == InviteActionType.reject,
            variant: AppButtonVariant.outlined,
            height: 30.h,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuTrigger({required BuildContext context}) {
    return AppPopupMenu(
      items: _menuActions
          .map(
            (action) => AppPopupMenuItem(
              title: _actionTitle(action),
              icon: AppIcon(_actionIcon(action)),
              onTap: () {
                if (action == InvitationMenuAction.unsendInvite) {
                  context.read<InviteActionCubit>().removeInvite(
                    invitation.parentGroupId,
                    invitation.id,
                  );
                } else if (action == InvitationMenuAction.leave) {
                  context.read<InviteActionCubit>().leaveGroup(
                    invitation.parentGroupId,
                    invitation.id,
                  );
                } else if (action == InvitationMenuAction.removeAccess) {
                  context.read<InviteActionCubit>().removeMember(
                    invitation.parentGroupId,
                    invitation.inviteeUserId,
                  );
                } else if (action == InvitationMenuAction.remind) {
                  context.read<InviteActionCubit>().remind(invitation.id);
                }
              },
            ),
          )
          .toList(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF2D2D2E)),
        ),
        child: AppIcon(
          AppIcons.svg.generic.moreVert,
          size: 16.r,
          color: const Color(0xFF2D2D2E),
        ),
      ),
    );
  }

  String _actionTitle(InvitationMenuAction action) {
    switch (action) {
      case InvitationMenuAction.removeAccess:
        return 'Remove access';
      case InvitationMenuAction.unsendInvite:
        return 'Unsend invite';
      case InvitationMenuAction.remind:
        return 'Remind';
      case InvitationMenuAction.leave:
        return 'Leave';
    }
  }

  String _actionIcon(InvitationMenuAction action) {
    switch (action) {
      case InvitationMenuAction.removeAccess:
        return AppIcons.svg.generic.delete;
      case InvitationMenuAction.unsendInvite:
        return AppIcons.svg.generic.arrowClockwise;
      case InvitationMenuAction.remind:
        return AppIcons.svg.generic.bell;
      case InvitationMenuAction.leave:
        return AppIcons.svg.generic.close;
    }
  }
}
