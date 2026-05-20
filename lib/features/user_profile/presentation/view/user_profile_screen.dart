import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/bottom_sheet/invite_bottom_sheet/invite_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/list_items/invitation_card/invitation_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/invites/data/models/invitations_overview_response.dart';
import 'package:poochcare/features/invites/domain/models/invite_type.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_action_cubit/invite_action_cubit.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_action_cubit/invite_action_state.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_bloc.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_event.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_state.dart';
import 'package:poochcare/features/invites/repository/invite_repository.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_state.dart';
import 'package:poochcare/features/user_profile/presentation/widgets/circular_coparent_avatar.dart';
import 'package:poochcare/features/user_profile/presentation/widgets/invitation_action_card.dart';
import 'package:poochcare/features/user_profile/presentation/widgets/master_parent_details_card.dart';
import 'package:poochcare/features/user_profile/presentation/widgets/my_pets_wave_card.dart';
import 'package:poochcare/features/user_profile/presentation/widgets/user_profile_header.dart';
import 'package:poochcare/features/user_profile/presentation/widgets/years_gender_name_row.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class UserProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const UserProfileScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<UserProfileBloc>.value(
      value: getIt<UserProfileBloc>()
        ..add(const GetUserProfileEvent())
        ..add(const GetParentGroupsEvent())
        ..add(const GetUserPetsEvent()),
      child: this,
    );
  }

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late final InviteActionCubit _inviteActionCubit;
  final Set<String> _removedMemberKeys = <String>{};
  int _selectedCoParentIndex = 0;
  String? _pendingRemovalKey;
  String? _pendingPetDeleteId;
  String? _pendingInvitationId;
  String? _pendingDialogRemovalInvitationId;
  _PendingInvitePreview? _pendingParentInvitePreview;
  _PendingInvitePreview? _pendingCoParentInvitePreview;
  final _inviteBloc = getIt<InviteBloc>();

  @override
  void initState() {
    super.initState();
    _inviteActionCubit = InviteActionCubit(
      repository: getIt<InviteRepository>(),
      invitation: _placeholderInvitation(),
    );
    _inviteBloc.add(const GetLatestSentInvitesEvent());
  }

  @override
  void dispose() {
    _inviteActionCubit.close();
    super.dispose();
  }

  Invitation _placeholderInvitation() {
    return Invitation(
      isRequestSent: false,
      isAccepted: false,
      useButterflyImage: false,
      petName: '',
      userName: '',
      ageGender: '',
      role: '',
      imageUrl: '',
      id: '',
      parentGroupId: '',
      inviteeUserId: '',
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, UserPet pet) {
    AppDialog.show<bool>(
      context: context,
      title: 'Delete Pet Profile?',
      content:
          'Once deleted, you won\'t be able to access any data associated with this pet, including medical history and records.',
      primaryLabel: 'Delete',
      secondaryLabel: 'Cancel',
      icon: Lottie.asset(AppIcons.lottie.delete, width: 120, height: 120),
      onPrimary: () async {
        setState(() {
          _pendingPetDeleteId = pet.id;
        });
        context.read<UserProfileBloc>().add(DeletePetRequested(pet: pet));
        return true;
      },
    );
  }

  Future<void> _onPullToRefresh() async {
    setState(() {
      _pendingParentInvitePreview = null;
      _pendingCoParentInvitePreview = null;
    });

    context.read<UserProfileBloc>().add(const GetUserProfileEvent());
    context.read<UserProfileBloc>().add(const GetParentGroupsEvent());
    context.read<UserProfileBloc>().add(const GetUserPetsEvent());
    _refreshPendingInvites();

    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: BlocProvider<InviteBloc>.value(
        value: _inviteBloc,
        child: BlocProvider<InviteActionCubit>.value(
          value: _inviteActionCubit,
          child: MultiBlocListener(
            listeners: [
              BlocListener<UserProfileBloc, UserProfileState>(
                listenWhen: (prev, curr) =>
                    prev.profileErrorMessage != curr.profileErrorMessage,
                listener: (context, state) {
                  final message = (state.profileErrorMessage ?? '').trim();
                  if (message.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
              ),
              BlocListener<UserProfileBloc, UserProfileState>(
                listenWhen: (prev, curr) =>
                    prev.deletePetStatus != curr.deletePetStatus,
                listener: (context, state) {
                  if (state.deletePetStatus == DeletePetStatus.success) {
                    setState(() {
                      _pendingPetDeleteId = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pet deleted successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }

                  if (state.deletePetStatus == DeletePetStatus.failure) {
                    setState(() {
                      _pendingPetDeleteId = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.deletePetErrorMessage ??
                              'Unable to delete pet. Please try again.',
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
              ),
              BlocListener<UserProfileBloc, UserProfileState>(
                listenWhen: (prev, curr) =>
                    prev.parentGroupsErrorMessage !=
                    curr.parentGroupsErrorMessage,
                listener: (context, state) {
                  final message = (state.parentGroupsErrorMessage ?? '').trim();
                  if (message.isNotEmpty) {
                    ToastService.showError(message);
                  }
                },
              ),
              BlocListener<InviteActionCubit, InviteActionState>(
                listener: (context, state) {
                  if (state.completedAction == InviteActionType.removeMember) {
                    if (_pendingRemovalKey != null) {
                      setState(() {
                        _removedMemberKeys.add(_pendingRemovalKey!);
                        _pendingRemovalKey = null;
                      });
                    }

                    final successMessage = (state.successMessage ?? '').trim();
                    if (successMessage.isNotEmpty) {
                      ToastService.showSuccess(successMessage);
                    } else {
                      ToastService.showSuccess('Member removed successfully');
                    }
                    context.read<UserProfileBloc>().add(
                      const GetParentGroupsEvent(),
                    );
                  }

                  if (state.completedAction ==
                          InviteActionType.removeInvitation &&
                      _pendingDialogRemovalInvitationId != null) {
                    final removedInvitationId =
                        _pendingDialogRemovalInvitationId!;
                    _inviteBloc.add(
                      ApplyInviteActionEvent(
                        action: InviteActionType.removeInvitation,
                        invitationId: removedInvitationId,
                      ),
                    );
                    setState(() {
                      _pendingDialogRemovalInvitationId = null;
                      _pendingParentInvitePreview = null;
                    });
                    _refreshPendingInvites();

                    final successMessage = (state.successMessage ?? '').trim();
                    if (successMessage.isNotEmpty) {
                      ToastService.showSuccess(successMessage);
                    } else {
                      ToastService.showSuccess(
                        'Invitation removed successfully',
                      );
                    }
                  }

                  final errorMessage = (state.errorMessage ?? '').trim();
                  if (errorMessage.isNotEmpty &&
                      state.processingAction != InviteActionType.removeMember &&
                      state.processingAction !=
                          InviteActionType.removeInvitation) {
                    return;
                  }
                  if (errorMessage.isNotEmpty) {
                    setState(() {
                      _pendingRemovalKey = null;
                      _pendingDialogRemovalInvitationId = null;
                    });
                    ToastService.showError(errorMessage);
                  }
                },
              ),
            ],
            child: SafeArea(
              top: false,
              child: RefreshIndicator(
                onRefresh: _onPullToRefresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    children: [
                      BlocBuilder<UserProfileBloc, UserProfileState>(
                        buildWhen: (prev, curr) =>
                            prev.profile != curr.profile ||
                            prev.isProfileLoading != curr.isProfileLoading,
                        builder: (context, state) {
                          return UserProfileHeader(
                            profile: state.profile,
                            onAvatarEditTap: state.profile != null
                                ? () {
                                    context.router.push(
                                      EditParentProfileRoute(
                                        profile: state.profile!,
                                      ),
                                    );
                                  }
                                : null,
                            onAddParentTap: () =>
                                _onAddParentFromHeaderTap(context),
                          );
                        },
                      ),
                      AppSpacing.s30.hBox,

                      /// 🐶 My Pets Card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: BlocBuilder<UserProfileBloc, UserProfileState>(
                          buildWhen: (prev, curr) =>
                              prev.pets != curr.pets ||
                              prev.isPetsLoading != curr.isPetsLoading ||
                              prev.petsErrorMessage != curr.petsErrorMessage ||
                              prev.deletingPetId != curr.deletingPetId ||
                              prev.deletePetStatus != curr.deletePetStatus,
                          builder: (context, state) {
                            return MyPetsWaveCard(
                              pets: state.pets,
                              isDeleteInProgress:
                                  state.deletePetStatus ==
                                  DeletePetStatus.inProgress,
                              deletingPetId: _pendingPetDeleteId,
                              onAddTap: state.pets.isEmpty
                                  ? () {
                                      context.router.push(
                                        const AddPetProfileRoute(),
                                      );
                                    }
                                  : null,
                              onEditTap: (pet) {
                                context.router.push(
                                  EditPetProfileRoute(pet: pet),
                                );
                              },
                              onDeleteTap: (pet) {
                                _showDeleteConfirmDialog(context, pet);
                              },
                            );
                          },
                        ),
                      ),

                      AppSpacing.s30.hBox,

                      Builder(
                        builder: (context) {
                          final inviteState = context
                              .select<InviteBloc, InviteState>(
                                (bloc) => bloc.state,
                              );
                          final latestInvites = inviteState.latestSentInvites;
                          final pendingParentInvite = _normalizeLatestInvite(
                            latestInvites?.latestParentInvite,
                          );
                          final pendingCoParentInvite = _normalizeLatestInvite(
                            latestInvites?.latestCoParentInvite,
                          );

                          final pendingParentInvitePreview =
                              pendingParentInvite == null
                              ? _pendingParentInvitePreview
                              : null;
                          final pendingCoParentInvitePreview =
                              pendingCoParentInvite == null
                              ? _pendingCoParentInvitePreview
                              : null;

                          return BlocBuilder<UserProfileBloc, UserProfileState>(
                            buildWhen: (prev, curr) =>
                                prev.parentGroups != curr.parentGroups ||
                                prev.isParentGroupsLoading !=
                                    curr.isParentGroupsLoading,
                            builder: (context, state) {
                              final masterParentMember = _findOwnerParentMember(
                                state.parentGroups,
                              );
                              final coParentMembers = _buildCoParentMembers(
                                state.parentGroups,
                              );

                              if (_selectedCoParentIndex >=
                                      coParentMembers.length &&
                                  coParentMembers.isNotEmpty) {
                                _selectedCoParentIndex =
                                    coParentMembers.length - 1;
                              }

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s6.w,
                                ),
                                child: Column(
                                  children: [
                                    if (masterParentMember != null ||
                                        pendingParentInvite != null ||
                                        pendingParentInvitePreview != null)
                                      masterParentWaveCard(
                                        context: context,
                                        member: masterParentMember,
                                        pendingInvite: pendingParentInvite,
                                        pendingInvitePreview:
                                            pendingParentInvitePreview,
                                        onViewAllInvites: () {
                                          context.router.push(
                                            const InvitesRoute(),
                                          );
                                        },
                                        hasOnlyInvites:
                                            masterParentMember == null &&
                                            (pendingParentInvite != null ||
                                                pendingParentInvitePreview !=
                                                    null),
                                      )
                                    else
                                      NoCoparentAvailableCard(
                                        content:
                                            'No Parents added at the moment',
                                        inviteType: InviteType.parent,
                                        title: 'Parent',
                                        onInviteSent: _onInviteSent,
                                      ),
                                    SizedBox(height: 30.h),
                                    if (coParentMembers.isEmpty &&
                                        pendingCoParentInvite == null &&
                                        pendingCoParentInvitePreview == null)
                                      NoCoparentAvailableCard(
                                        title: 'Co-parents',
                                        content:
                                            'No Co-parents added at the moment',
                                        onInviteSent: _onInviteSent,
                                      )
                                    else
                                      coParentWaveCard(
                                        context: context,
                                        members: coParentMembers,
                                        pendingInvite: pendingCoParentInvite,
                                        pendingInvitePreview:
                                            pendingCoParentInvitePreview,
                                        onViewAllInvites: () {
                                          context.router.push(
                                            const InvitesRoute(),
                                          );
                                        },
                                        selectedIndex: _selectedCoParentIndex,
                                        onMemberSelected: (index) {
                                          setState(() {
                                            _selectedCoParentIndex = index;
                                          });
                                        },
                                      ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),

                      AppSpacing.s30.hBox,

                      /// 🌍 Community Activity
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16.w,
                        ),
                        child: _communityActivityCard(),
                      ),
                      AppSpacing.s40.hBox,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _GroupMemberData? _findOwnerParentMember(
    List<UserProfileParentGroup> groups,
  ) {
    for (final group in groups) {
      if (!group.isOwner) continue;

      for (final member in group.members) {
        if (member.role.trim().toLowerCase() != 'parent') continue;

        final mapped = _toGroupMemberData(
          groupId: group.id,
          member: member,
          fallbackName: 'Master Parent',
        );
        if (mapped != null) {
          return mapped;
        }
      }
    }
    return null;
  }

  List<_GroupMemberData> _buildCoParentMembers(
    List<UserProfileParentGroup> groups,
  ) {
    final List<_GroupMemberData> data = <_GroupMemberData>[];

    for (final group in groups) {
      if (!group.isOwner) continue;

      for (final member in group.members) {
        if (member.role.trim().toLowerCase() != 'co_parent') continue;

        final mapped = _toGroupMemberData(
          groupId: group.id,
          member: member,
          fallbackName: 'Co-parent',
        );
        if (mapped != null) {
          data.add(mapped);
        }
      }
    }

    return data;
  }

  _GroupMemberData? _toGroupMemberData({
    required String groupId,
    required UserProfileParentGroupMember member,
    required String fallbackName,
  }) {
    final trimmedGroupId = groupId.trim();
    final userId = member.id.trim();
    if (trimmedGroupId.isEmpty || userId.isEmpty) return null;

    final key = _memberKey(groupId: trimmedGroupId, userId: userId);
    if (_removedMemberKeys.contains(key)) return null;

    final name = member.name.trim();
    return _GroupMemberData(
      profileImageUrl: member.profilePicture,
      groupId: trimmedGroupId,
      userId: userId,
      name: name.isEmpty ? fallbackName : name,
      email: member.email.trim(),
      gender: _capitalize(member.gender),
      ageLabel: _calculateAgeLabel(member.dateOfBirth),
    );
  }

  String _calculateAgeLabel(String dateOfBirth) {
    final raw = dateOfBirth.trim();
    if (raw.isEmpty) return '';

    final dob = DateTime.tryParse(raw);
    if (dob == null) return '';

    final now = DateTime.now();
    var age = now.year - dob.year;
    final hasHadBirthdayThisYear =
        now.month > dob.month || (now.month == dob.month && now.day >= dob.day);

    if (!hasHadBirthdayThisYear) {
      age -= 1;
    }

    if (age < 0) return '';
    return '${age}yrs';
  }

  String _capitalize(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return '';
    final lower = trimmed.toLowerCase();
    return '${lower[0].toUpperCase()}${lower.substring(1)}';
  }

  void _removeMemberAccess({required String groupId, required String userId}) {
    final trimmedGroupId = groupId.trim();
    final trimmedUserId = userId.trim();

    if (trimmedGroupId.isEmpty || trimmedUserId.isEmpty) {
      ToastService.showError('Unable to remove member. Missing details.');
      return;
    }

    final pendingKey = _memberKey(
      groupId: trimmedGroupId,
      userId: trimmedUserId,
    );
    setState(() {
      _pendingRemovalKey = pendingKey;
    });

    _inviteActionCubit.removeMember(trimmedGroupId, trimmedUserId);
  }

  String _memberKey({required String groupId, required String userId}) {
    return '$groupId::$userId';
  }

  InviteItemResponse? _normalizeLatestInvite(InviteItemResponse? invite) {
    if (invite == null) {
      return null;
    }

    if (invite.id.trim().isEmpty) {
      return null;
    }

    return invite;
  }

  Widget _pendingInvitationActionCard({
    required BuildContext context,
    required InviteType inviteType,
    required InviteItemResponse invite,
  }) {
    final isInviteRemovalInProgress =
        context.select<InviteActionCubit, InviteActionType?>((cubit) {
          return cubit.state.processingAction;
        }) ==
        InviteActionType.removeInvitation;
    final isCurrentInviteRemoving =
        isInviteRemovalInProgress && _pendingInvitationId == invite.id;

    return BlocProvider.value(
      value: _inviteActionCubit,
      child: BlocListener<InviteActionCubit, InviteActionState>(
        listener: (context, state) {
          final isMatchingPendingAction =
              _pendingInvitationId != null && _pendingInvitationId == invite.id;

          if (state.completedAction == InviteActionType.removeInvitation &&
              isMatchingPendingAction) {
            _inviteBloc.add(
              ApplyInviteActionEvent(
                action: InviteActionType.removeInvitation,
                invitationId: invite.id,
              ),
            );
            setState(() {
              _pendingInvitationId = null;
              if (inviteType == InviteType.parent) {
                _pendingParentInvitePreview = null;
              } else {
                _pendingCoParentInvitePreview = null;
              }
            });
            _refreshPendingInvites();
            final message = (state.successMessage ?? '').trim();
            CustomSnackbar.show(
              message.isNotEmpty ? message : 'Invitation removed successfully',
              SnackbarType.success,
            );
          }

          final error = (state.errorMessage ?? '').trim();
          if (error.isNotEmpty && isMatchingPendingAction) {
            setState(() {
              _pendingInvitationId = null;
            });
            ToastService.showError(error);
          }
        },
        child: InvitationActionCard(
          inviteType: inviteType,
          actionTitle: 'Unsend Invite',
          email: _buildInviteContact(invite),
          name: invite.invitee.name.isNotEmpty
              ? invite.invitee.name
              : invite.invitee.phone,
          onTapAction: () {
            AppDialog.show<void>(
              icon: Lottie.asset(AppIcons.lottie.delete),
              context: context,
              title: 'Unsend Invitation ?',
              content: 'Are you sure you want to unsend this invitation?',
              primaryLabel: 'Yes',
              secondaryLabel: 'No',
              onPrimary: () {
                setState(() {
                  _pendingInvitationId = invite.id;
                });
                _inviteActionCubit.removeInvite(
                  invite.parentGroupId,
                  invite.id,
                );
                return Future.value();
              },
            );
          },
          isActionLoading: isCurrentInviteRemoving,
          status: 'Awaiting acceptance',
          statusTextColor: const Color(0xFF8C6B15),
          statusBgColor: const Color(0xFFFFF9E9),
        ),
      ),
    );
  }

  Widget _pendingInvitationPreviewCard({
    required InviteType inviteType,
    required _PendingInvitePreview preview,
  }) {
    return InvitationActionCard(
      inviteType: inviteType,
      actionTitle: 'Unsend invite',
      email: preview.contact,
      name: preview.name,
      onTapAction: _refreshPendingInvites,
      status: 'Awaiting acceptance',
      statusTextColor: const Color(0xFF8C6B15),
      statusBgColor: const Color(0xFFFFF9E9),
    );
  }

  void _onInviteSent(InviteSheetSubmission submission) {
    final preview = _PendingInvitePreview(
      name: submission.displayName,
      contact: submission.contact,
    );

    setState(() {
      if (submission.inviteType == InviteType.parent) {
        _pendingParentInvitePreview = preview;
      } else {
        _pendingCoParentInvitePreview = preview;
      }
    });

    _refreshPendingInvites();
  }

  void _refreshPendingInvites() {
    _inviteBloc.add(const GetLatestSentInvitesEvent(forceRefresh: true));
  }

  String _buildInviteContact(InviteItemResponse invite) {
    final inviteeEmail = invite.invitee.email.trim();
    if (inviteeEmail.isNotEmpty) {
      return inviteeEmail;
    }

    final inviteePhone = invite.invitee.phone.trim();
    if (inviteePhone.isNotEmpty) {
      return inviteePhone;
    }

    final inviterEmail = invite.inviter.email.trim();
    if (inviterEmail.isNotEmpty) {
      return inviterEmail;
    }

    final inviterPhone = invite.inviter.phone.trim();
    if (inviterPhone.isNotEmpty) {
      return inviterPhone;
    }

    return '';
  }

  /// ================= COMMUNITY ACTIVITY =================
  Widget _communityActivityCard() {
    return AppWaveCard(
      backgroundColor: const Color(0xffFEF2EF),
      borderRadius: AppRadiusSize.r16,
      notchHeight: 25,
      notchWidth: 20,
      variant: AppCardNotchVariant.bottomRight,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s16.w,
        vertical: AppSpacing.s16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon
          AppIcon(AppIcons.svg.community.viewMyCommunityVector),
          AppSpacing.s12.wBox,

          // Text
          Expanded(
            child: AppText.h1(
              'View My Community Activity',
              fontSize: AppFontSize.fs16,
              color: AppColors.p4_900,
            ),
          ),

          // Right Arrow
          AppIcon(
            AppIcons.svg.generic.chevronRight,
            size: AppIconSize.is14,
            color: AppColors.p4_900,
          ),
        ],
      ),
    );
  }

  Widget masterParentWaveCard({
    required BuildContext context,
    _GroupMemberData? member,
    InviteItemResponse? pendingInvite,
    _PendingInvitePreview? pendingInvitePreview,
    required VoidCallback onViewAllInvites,
    bool hasOnlyInvites = false,
  }) {
    final isMemberRemovalInProgress =
        context.select<InviteActionCubit, InviteActionType?>((cubit) {
          return cubit.state.processingAction;
        }) ==
        InviteActionType.removeMember;
    final memberDeleteKey = member == null
        ? null
        : _memberKey(groupId: member.groupId, userId: member.userId);
    final isDeleteLoading =
        isMemberRemovalInProgress && _pendingRemovalKey == memberDeleteKey;

    return AppWaveCard(
      backgroundColor: AppColors.primarybackground,
      borderRadius: AppRadiusSize.r16,
      notchHeight: 20,
      notchWidth: 150,
      actionWidget: AppButton(
        padding: const EdgeInsets.only(
          top: AppSpacing.s10,
          right: AppSpacing.s10,
        ),
        width: null,
        variant: AppButtonVariant.text,
        size: AppButtonSize.extraSmall,
        label: 'View All Invites',
        disableRippleEffect: true,
        onPressed: onViewAllInvites,
        textStyle: AppTypography.h3.copyWith(fontSize: AppFontSize.fs12),
        trailingIcon: AppIcon(AppIcons.svg.generic.rightSkip),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s12.w,
      ).copyWith(top: AppSpacing.s20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          AppText.h1(
            'Other Master Parent',
            fontSize: AppFontSize.fs16,
            color: AppColors.p4_900,
          ),
          AppSpacing.s28.hBox,

          if (!hasOnlyInvites && member != null) ...[
            MasterParentDetailsCard(
              age: member.ageLabel,
              email: member.email,
              profileImageUrl: member.profileImageUrl,
              gender: member.gender,
              name: member.name,
              isDeleteLoading: isDeleteLoading,
              onDeleteTap: () {
                AppDialog.show<void>(
                  icon: Lottie.asset(AppIcons.lottie.delete),
                  context: context,
                  title: 'Remove Parent?',
                  content:
                      'Are you sure you want to remove this parent from your group? They will lose access to all shared pet profiles, activity logs, and medical records immediately. This action cannot be undone',
                  primaryLabel: 'Yes',
                  secondaryLabel: 'No',
                  onPrimary: () {
                    _removeMemberAccess(
                      groupId: member.groupId,
                      userId: member.userId,
                    );
                    return Future.value();
                  },
                );
              },
            ),
            AppSpacing.s16.hBox,
          ],

          if (pendingInvite != null || pendingInvitePreview != null) ...[
            AppText.h1(
              'Pending Parent invites',
              fontSize: AppFontSize.fs16,
              color: AppColors.p4_900,
            ),
            AppSpacing.s12.hBox,
            if (pendingInvite != null)
              _pendingInvitationActionCard(
                context: context,
                inviteType: InviteType.parent,
                invite: pendingInvite,
              )
            else if (pendingInvitePreview != null)
              _pendingInvitationPreviewCard(
                inviteType: InviteType.parent,
                preview: pendingInvitePreview,
              ),
          ],
          const SizedBox(height: AppSpacing.s10),
          const Divider(color: AppColors.p4_100, height: 1),

          // Message
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                disableRippleEffect: true,
                width: null,
                label: 'Add Another Parent',
                textStyle: AppTypography.displayL.copyWith(
                  fontSize: AppFontSize.fs14,
                ),
                onPressed: () {
                  onAddParentTap(member, pendingInvite, context);
                },
                variant: AppButtonVariant.text,
                trailingIcon: AppIcon(
                  AppIcons.svg.generic.plusSign,
                  size: 18.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onAddParentTap(
    _GroupMemberData? member,
    InviteItemResponse? pendingInvite,
    BuildContext context,
  ) {
    bool isMemberAvailable = member != null;
    AppDialog.show<void>(
      primaryLabel: 'Cancel',
      secondaryLabel: 'Remove',
      onSecondary: () async {
        if (isMemberAvailable) {
          _inviteActionCubit.removeMember(member.groupId, member.userId);
        } else {
          final inviteId = pendingInvite?.id ?? '';
          setState(() {
            _pendingDialogRemovalInvitationId = inviteId.isNotEmpty
                ? inviteId
                : null;
          });
          _inviteActionCubit.removeInvite(
            pendingInvite?.parentGroupId ?? '',
            inviteId,
          );
        }
      },
      context: context,
      icon: Lottie.asset(AppIcons.lottie.delete),
      title: isMemberAvailable
          ? 'Master Parent Limit Reached!'
          : pendingInvite != null
          ? 'Invitation Limit Reached'
          : '',
      content: isMemberAvailable
          ? 'This account already has two Master Parents.\nRemove one to invite another.'
          : pendingInvite != null
          ? 'Already an invite is pending for master parent, want to remove that to send another one?'
          : '',
    );
  }

  void _onAddParentFromHeaderTap(BuildContext context) {
    final userProfileState = context.read<UserProfileBloc>().state;
    final inviteState = context.read<InviteBloc>().state;

    final member = _findOwnerParentMember(userProfileState.parentGroups);
    final pendingInvite = _normalizeLatestInvite(
      inviteState.latestSentInvites?.latestParentInvite,
    );

    if (member != null || pendingInvite != null) {
      onAddParentTap(member, pendingInvite, context);
      return;
    }

    InviteBottomSheet.show(
      title: 'Invite Parent',
      context: context,
      inviteType: InviteType.parent,
      onInviteSent: _onInviteSent,
    );
  }

  Widget coParentWaveCard({
    required BuildContext context,
    required List<_GroupMemberData> members,
    required InviteItemResponse? pendingInvite,
    required _PendingInvitePreview? pendingInvitePreview,
    required VoidCallback onViewAllInvites,
    required int selectedIndex,
    required ValueChanged<int> onMemberSelected,
  }) {
    final isMemberRemovalInProgress =
        context.select<InviteActionCubit, InviteActionType?>((cubit) {
          return cubit.state.processingAction;
        }) ==
        InviteActionType.removeMember;
    final hasMembers = members.isNotEmpty;
    final selectedMember = hasMembers
        ? members[selectedIndex.clamp(0, members.length - 1)]
        : null;
    final selectedMemberDeleteKey = selectedMember == null
        ? null
        : _memberKey(
            groupId: selectedMember.groupId,
            userId: selectedMember.userId,
          );
    final isSelectedMemberDeleting =
        isMemberRemovalInProgress &&
        _pendingRemovalKey == selectedMemberDeleteKey;

    return AppWaveCard(
      backgroundColor: AppColors.primarybackground,
      borderRadius: AppRadiusSize.r16,
      notchHeight: 20,
      notchWidth: 150,
      actionWidget: AppButton(
        disableRippleEffect: true,
        padding: const EdgeInsets.only(
          top: AppSpacing.s10,
          right: AppSpacing.s10,
        ),
        width: null,
        variant: AppButtonVariant.text,
        size: AppButtonSize.extraSmall,
        label: 'View All Invites',
        onPressed: onViewAllInvites,
        textStyle: AppTypography.h3.copyWith(fontSize: AppFontSize.fs12),
        trailingIcon: AppIcon(AppIcons.svg.generic.rightSkip),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s12.w,
      ).copyWith(top: AppSpacing.s20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          AppText.h1(
            'Co-parent',
            fontSize: AppFontSize.fs16,
            color: AppColors.p4_900,
          ),
          if (hasMembers) ...[
            AppSpacing.s20.hBox,
            SizedBox(
              height: 60.h,
              width: MediaQuery.sizeOf(context).width,
              child: ListView.builder(
                padding: const EdgeInsets.only(right: AppSpacing.s20),
                shrinkWrap: true,
                itemCount: members.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = members[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.s10),
                    child: CircularCoparentAvatar(
                      isSelected: index == selectedIndex,
                      label: item.initial,
                      onTap: () => onMemberSelected(index),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.s13),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.h4(
                        selectedMember?.name ?? '',
                        fontSize: AppFontSize.fs24,
                        color: AppColors.p4_600,
                      ),
                      const SizedBox(height: AppSpacing.s3),
                      AppText.h4(
                        selectedMember?.email ?? '',
                        fontSize: AppFontSize.fs14,
                        color: AppColors.p4_400,
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      YearsGenderNameRow(
                        ageGenderText: selectedMember?.ageGenderText ?? '',
                      ),
                    ],
                  ),
                ),
                AppCircleButton(
                  shadowColor: AppColors.shadowSecodary,
                  onTap: selectedMember == null || isSelectedMemberDeleting
                      ? null
                      : () {
                          AppDialog.show<void>(
                            icon: Lottie.asset(AppIcons.lottie.delete),
                            context: context,
                            title: 'Remove Co-Parent?',
                            content:
                                'Are you sure you want to remove this co-parent from your group? They will lose access to shared pet profiles and activity logs immediately. This action cannot be undone.',
                            primaryLabel: 'Yes',
                            secondaryLabel: 'No',
                            onPrimary: () {
                              _removeMemberAccess(
                                groupId: selectedMember.groupId,
                                userId: selectedMember.userId,
                              );
                              return Future.value();
                            },
                          );
                        },
                  size: AppCircleButtonSize.large,
                  icon: AppIcons.svg.generic.delete,
                  iconSize: 16,
                  bgColor: AppColors.background,
                  isLoading: isSelectedMemberDeleting,
                ),
              ],
            ),
            AppSpacing.s30.hBox,
            const Divider(color: AppColors.p4_100),
          ],

          if (pendingInvite != null || pendingInvitePreview != null) ...[
            AppSpacing.s12.hBox,
            AppText.h1(
              'Pending co-parent invites',
              fontSize: AppFontSize.fs16,
              color: AppColors.p4_900,
            ),
            AppSpacing.s12.hBox,
            if (pendingInvite != null)
              _pendingInvitationActionCard(
                context: context,
                inviteType: InviteType.coparent,
                invite: pendingInvite,
              )
            else if (pendingInvitePreview != null)
              _pendingInvitationPreviewCard(
                inviteType: InviteType.coparent,
                preview: pendingInvitePreview,
              ),
          ],

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                disableRippleEffect: true,
                width: null,
                label: 'Add Co-Parent',
                textStyle: AppTypography.displayL.copyWith(
                  fontSize: AppFontSize.fs14,
                ),
                onPressed: () {
                  InviteBottomSheet.show(
                    title: 'Invite Co-Parent',
                    context: context,
                    inviteType: InviteType.coparent,
                    onInviteSent: _onInviteSent,
                  );
                },
                variant: AppButtonVariant.text,
                trailingIcon: AppIcon(
                  AppIcons.svg.generic.plusSign,
                  size: 18.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NoCoparentAvailableCard extends StatelessWidget {
  final InviteType inviteType;
  final String content;
  final String title;
  final ValueChanged<InviteSheetSubmission>? onInviteSent;
  const NoCoparentAvailableCard({
    super.key,
    this.inviteType = InviteType.coparent,
    required this.content,
    required this.title,
    this.onInviteSent,
  });

  @override
  Widget build(BuildContext context) {
    return AppWaveCard(
      backgroundColor: AppColors.primarybackground,
      borderRadius: AppRadiusSize.r16,
      notchHeight: 25,
      notchWidth: 200,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s12.w,
      ).copyWith(top: AppSpacing.s20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h1(
            title,
            fontSize: AppFontSize.fs16,
            color: AppColors.p4_900,
          ),
          AppSpacing.s24.hBox,
          AppText.bodyM(
            content,
            color: AppColors.p4_400,
            fontSize: AppFontSize.fs14,
          ),
          AppSpacing.s12.hBox,
          Divider(
            color: AppColors.textSecondary.withValues(alpha: 0.3),
            thickness: 1,
            height: 1,
          ),
          // SizedBox(height: AppSpacing.s12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                disableRippleEffect: true,
                width: null,
                label: inviteType == InviteType.coparent
                    ? 'Add Co-Parent'
                    : 'Add Parent',
                textStyle: AppTypography.displayL.copyWith(
                  fontSize: AppFontSize.fs14,
                ),
                onPressed: () {
                  InviteBottomSheet.show(
                    title: inviteType == InviteType.coparent
                        ? 'Invite Co - Parent'
                        : 'Invite Parent',
                    context: context,
                    inviteType: inviteType,
                    onInviteSent: onInviteSent,
                  );
                },
                variant: AppButtonVariant.text,
                trailingIcon: AppIcon(
                  AppIcons.svg.generic.plusSign,
                  size: 18.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GroupMemberData {
  const _GroupMemberData({
    required this.groupId,
    required this.userId,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    this.gender = '',
    this.ageLabel = '',
  });

  final String groupId;
  final String userId;
  final String name;
  final String email;
  final String gender;
  final String ageLabel;
  final String profileImageUrl;

  String get ageGenderText {
    if (ageLabel.isEmpty && gender.isEmpty) return '';
    if (ageLabel.isEmpty) return gender;
    if (gender.isEmpty) return ageLabel;
    return '$ageLabel, $gender';
  }

  String get initial {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'C';
    return trimmed.substring(0, 1).toUpperCase();
  }
}

class _PendingInvitePreview {
  const _PendingInvitePreview({required this.name, required this.contact});

  final String name;
  final String contact;
}
