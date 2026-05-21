import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/services/notification_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/share_utils.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/community_report_dialog.dart';
import 'package:poochcare/core/widgets/list_items/event_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/share_link_response_model.dart';
import 'package:poochcare/features/community/presentation/bloc/community/community_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/community/community_event.dart';
import 'package:poochcare/features/community/presentation/bloc/community/community_state.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';
import 'package:poochcare/features/community/presentation/view/my_event_form_screen.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class CommunityEventDetailsScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const CommunityEventDetailsScreen({
    super.key,
    required this.eventId,
    this.isOwnPost = false,
  });

  final String eventId;
  final bool? isOwnPost;
  @override
  Widget wrappedRoute(BuildContext context) {
    // return BlocProvider<EventsBloc>.value(
    //   value: getIt<EventsBloc>(),
    //   child: this,
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsBloc>.value(value: getIt<EventsBloc>()),
        BlocProvider<CommunityBloc>(create: (_) => getIt<CommunityBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<CommunityEventDetailsScreen> createState() =>
      _CommunityEventDetailsScreenState();
}

class _CommunityEventDetailsScreenState
    extends State<CommunityEventDetailsScreen> {
  bool get _isOwnPost => widget.isOwnPost == true;
  String eventStatus = '';
  bool isApiExecuting = false;
  EventsBloc get _eventsBloc => context.read<EventsBloc>();

  @override
  void initState() {
    super.initState();
    NotificationService.currentEventId = widget.eventId;
    _load();
  }

  void _load() {
    _isOwnPost
        ? _eventsBloc.fetchEventDetails(widget.eventId)
        : _eventsBloc.fetchEventDetails(widget.eventId);
  }

  Future<void> _onRefresh() async {
    _isOwnPost
        ? await _eventsBloc.fetchEventDetails(widget.eventId, isRefresh: true)
        : await _eventsBloc.fetchEventDetails(widget.eventId, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryBgContainer(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: PoochScreenAppBar(
          title: '',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSpacing.s8.w),
              child: Row(
                children: [
                  if (!_isOwnPost) ...[
                    AppCircleButton(
                      hitSlop: EdgeInsets.only(right: -AppSpacing.s3.w),
                      variant: AppCircleButtonVariant.secondary,
                      bgColor: AppColors.transparent,
                      iconSize: AppIconSize.is20,
                      showShadow: false,
                      icon: AppIcons.svg.generic.flag,
                      onTap: () async {
                        final result = await CommunityReportDialog.show(
                          context: context,
                        );
                        if (result != null && mounted) {
                          reportEvent(widget.eventId, result.reason);
                        }
                      },
                    ),
                  ],
                  BlocConsumer<CommunityBloc, CommunityDetailsState>(
                    listenWhen: (previous, current) =>
                        previous.recordsStatus != current.recordsStatus,

                    listener: (context, state) {
                      if (state.recordsStatus == CommunityState.success) {
                        final ShareLinkResponseData? data =
                            state.shareLinkResponseData;

                        if (data == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'community.eventDetails.failedToGetShareLinkData'
                                    .tr(),
                              ),
                            ),
                          );
                          return;
                        }

                        String title = '';
                        String shareText = '';
                        if (data.contentType == 'tip') {
                          shareText =
                              '🐾 ${data.title}\n\n'
                              '${data.description}\n\n'
                              '${'community.eventDetails.sharedFrom'.tr()}';
                        } else if (data.contentType == 'event') {
                          shareText =
                              '🎉 ${data.title}\n\n'
                              '${data.description}\n\n'
                              '📅 ${'community.eventDetails.dateLabel'.tr()} ${data.startDate ?? '-'}\n'
                              '⏰ ${'community.eventDetails.timeLabel'.tr()} ${data.eventTime ?? '-'}\n'
                              '📍 ${'community.eventDetails.locationLabel'.tr()} ${data.location ?? '-'}\n'
                              '📌 ${'community.eventDetails.addressLabel'.tr()} ${data.addressDetails ?? '-'}\n'
                              '👥 ${'community.eventDetails.attendingLabel'.tr()} ${data.attendanceCount ?? 0}\n'
                              '${data.isPaid == true ? '💳 ${'community.eventDetails.paidEvent'.tr()}' : '🆓 ${'community.eventDetails.freeEvent'.tr()}'}\n\n'
                              '${'community.eventDetails.sharedFrom'.tr()}';
                        }

                        ShareUtils.shareContent(
                          title: title,
                          description: shareText,
                        );
                      }

                      if (state.recordsStatus == CommunityState.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.errorMessage ??
                                  'community.eventDetails.somethingWentWrong'
                                      .tr(),
                            ),
                          ),
                        );
                      }
                    },

                    builder: (context, state) {
                      final isLoading =
                          state.recordsStatus == CommunityState.loading;

                      return AppCircleButton(
                        hitSlop: EdgeInsets.only(right: -AppSpacing.s3.w),
                        variant: AppCircleButtonVariant.secondary,
                        bgColor: AppColors.transparent,
                        iconSize: AppIconSize.is20,
                        showShadow: false,
                        isLoading: isLoading,
                        icon: AppIcons.svg.generic.share,

                        onTap: isLoading
                            ? null
                            : () {
                                context.read<CommunityBloc>().add(
                                  FetchShareLinkEvent(
                                    contentId: widget.eventId,
                                    contentType: 'event',
                                  ),
                                );
                              },
                      );
                    },
                  ),
                  // AppCircleButton(
                  //   hitSlop: EdgeInsets.only(right: -AppSpacing.s3.w),
                  //   variant: AppCircleButtonVariant.secondary,
                  //   bgColor: AppColors.transparent,
                  //   iconSize: AppIconSize.is20,
                  //   showShadow: false,
                  //   icon: AppIcons.svg.generic.share,
                  //   onTap: () => {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('Share Event')),
                  //     ),
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),

        body: SafeArea(
          child: _isOwnPost
              ? BlocBuilder<EventsBloc, PaginationState<EventInfoItemModel>>(
                  builder: _build,
                )
              : BlocBuilder<EventsBloc, PaginationState<EventInfoItemModel>>(
                  builder: _build,
                ),
        ),

        bottomNavigationBar:
            BlocBuilder<EventsBloc, PaginationState<EventInfoItemModel>>(
              builder: (context, state) {
                final item = state.selectedItem;

                if (item == null || state.isDetailLoading) {
                  return const SizedBox.shrink();
                }

                final isOwner = item.isAuthor; // 👈 single source of truth

                if (isOwner && item.status == 'APPROVED') {
                  return const SizedBox.shrink();
                }

                log('Bottom bar builder - item: $item');

                /// COMMON RULES (apply to both)
                if (!isOwner &&
                    !canJoinEvent(
                      eventEndDate: item.eventEndDate,
                      eventTime: item.eventTime,
                    )) {
                  return const SizedBox.shrink();
                }

                final isRsvpLoading = state.isProcessing(
                  item.id,
                  EventActions.rsvp,
                );

                return SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.s16.w,
                      vertical: AppSpacing.s16.h,
                    ),
                    child: isOwner
                        ? Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  isLoading: isApiExecuting,
                                  variant: AppButtonVariant.outlined,
                                  label: 'community.eventDetails.deletePost'
                                      .tr(),
                                  onPressed: () {
                                    AppDialog.show(
                                      icon: Lottie.asset(
                                        AppIcons.lottie.delete,
                                        repeat: false,
                                      ),
                                      context: context,
                                      title:
                                          'community.eventDetails.deletePostPrompt'
                                              .tr(),
                                      content:
                                          'community.eventDetails.deletePostContent'
                                              .tr(),
                                      primaryLabel: 'common.cancel'.tr(),
                                      secondaryLabel: 'common.delete'.tr(),
                                      onSecondary: () async {
                                        deleteEvent(widget.eventId);
                                        return true;
                                      },
                                      onPrimary: () async => true,
                                    );
                                  },
                                  size: AppButtonSize.medium,
                                ),
                              ),
                              SizedBox(width: AppSpacing.s10.w),
                              Expanded(
                                child: AppButton(
                                  isLoading: isApiExecuting,
                                  label: 'community.eventDetails.editPost'.tr(),
                                  onPressed: () {
                                    context.pushRoute(
                                      MyEventFormRoute(
                                        type: MyEventFormType.edit,
                                        eventId: widget.eventId,
                                      ),
                                    );
                                  },
                                  size: AppButtonSize.medium,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!isUserAttendingEvent(
                                item.userRsvpStatus,
                              )) ...[
                                AppButton(
                                  isLoading: isRsvpLoading,
                                  label:
                                      'community.eventDetails.confirmAttendance'
                                          .tr(),
                                  size: AppButtonSize.medium,
                                  onPressed: () {
                                    context.read<EventsBloc>().confirmAttendee(
                                      eventId: item.id,
                                    );
                                  },
                                ),
                                SizedBox(height: AppSpacing.s10.h),
                              ],
                              AppButton(
                                label:
                                    'community.eventDetails.chatWithOrganizer'
                                        .tr(),
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.textPrimary,
                                size: AppButtonSize.medium,
                                onPressed: () {
                                  context.router.push(
                                    PoochParentChatRoute(
                                      userName:
                                          item.organizer?.name ?? 'Organizer',
                                      source: 'community_event_details_screen',
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),

        // bottomNavigationBar: _isOwnPost
        //     ? BlocBuilder<EventsBloc, PaginationState<EventInfoItemModel>>(
        //         builder: (context, state) {
        //           final item = state.selectedItem;
        //           log('Bottom bar builder - item: $item');
        //           if (item == null || item.status == 'APPROVED') {
        //             return const SizedBox.shrink();
        //           }
        //           return SafeArea(
        //             child: Container(
        //               padding: EdgeInsets.symmetric(
        //                 horizontal: AppSpacing.s16.w,
        //                 vertical: AppSpacing.s16.h,
        //               ),
        //               child: Row(
        //                 children: [
        //                   /// Button 1
        //                   Expanded(
        //                     child: AppButton(
        //                       isLoading: isApiExecuting,
        //                       variant: AppButtonVariant.outlined,
        //                       label: 'Delete Post',
        //                       onPressed: () {
        //                         AppDialog.show(
        //                           icon: Lottie.asset(
        //                             AppIcons.lottie.delete,
        //                             repeat: false,
        //                           ),
        //                           context: context,
        //                           title: 'Delete Post?',
        //                           content:
        //                               'This action cannot be undone. Are you sure you want to delete this post?',
        //                           primaryLabel: 'Cancel',
        //                           secondaryLabel: 'Delete',
        //                           onPrimary: () async {
        //                             return true;
        //                           },
        //                           onSecondary: () async {
        //                             deleteEvent(widget.eventId);
        //                             return true;
        //                           },
        //                         );
        //                       },
        //                       size: AppButtonSize.medium,
        //                     ),
        //                   ),

        //                   SizedBox(width: AppSpacing.s10.w),

        //                   /// Button 2
        //                   Expanded(
        //                     child: AppButton(
        //                       isLoading: isApiExecuting,
        //                       label: 'Edit Post',
        //                       onPressed: () {
        //                         context.pushRoute(
        //                           MyEventFormRoute(
        //                             type: MyEventFormType.edit,
        //                             eventId: widget.eventId,
        //                           ),
        //                         );
        //                       },
        //                       size: AppButtonSize.medium,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           );
        //         },
        //       )
        //     : SafeArea(
        //         child:
        //             BlocBuilder<
        //               EventsBloc,
        //               PaginationState<EventInfoItemModel>
        //             >(
        //               builder: (context, state) {
        //                 final item = state.selectedItem;
        //                 log('Bottom bar builder - item: $item');
        //                 final isDetailLoading = state.isDetailLoading;
        //                 final isRsvpLoading = state.isProcessing(
        //                   item?.id,
        //                   EventActions.rsvp,
        //                 );
        //                 if (item == null || isDetailLoading) {
        //                   return const SizedBox.shrink();
        //                 }
        //                 if (!canJoinEvent(
        //                   eventEndDate: item.eventEndDate,
        //                   eventTime: item.eventTime,
        //                 )) {
        //                   return const SizedBox.shrink();
        //                 }
        //                 if (item.isAuthor) {
        //             return const SizedBox.shrink();
        //           }
        //                 return Container(
        //                   padding: EdgeInsets.symmetric(
        //                     horizontal: AppSpacing.s16.w,
        //                     vertical: AppSpacing.s16.h,
        //                   ),
        //                   child: Column(
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       /// Button 1
        //                       if (!isUserAttendingEvent(
        //                         item.userRsvpStatus,
        //                       )) ...[
        //                         AppButton(
        //                           isLoading: isRsvpLoading,
        //                           label: 'Confirm Attendance',
        //                           size: AppButtonSize.medium,
        //                           onPressed: () {
        //                             context.read<EventsBloc>().confirmAttendee(
        //                               eventId: item.id,
        //                             );
        //                           },
        //                         ),
        //                         SizedBox(height: AppSpacing.s10.h),
        //                       ],

        //                       /// Button 2
        //                       AppButton(
        //                         label: 'Chat with Organizer',
        //                         backgroundColor: AppColors.primary,
        //                         foregroundColor: AppColors.textPrimary,
        //                         size: AppButtonSize.medium,
        //                         onPressed: () {
        //                           context.router.push(
        //                             PoochParentChatRoute(
        //                               userName:
        //                                   item.organizer?.name ?? 'Organizer',
        //                               source: 'community_event_details_screen',
        //                             ),
        //                           );
        //                         },
        //                       ),
        //                     ],
        //                   ),
        //                 );
        //               },
        //             ),
        //       ),
      ),
    );
  }

  Widget _build(
    BuildContext context,
    PaginationState<EventInfoItemModel> state,
  ) {
    log('State: ${state.toString()}');
    final item = state.selectedItem;

    /// =============================
    /// LOADING
    /// =============================
    if (state.isDetailLoading && (item == null || item.id != widget.eventId)) {
      return const Center(child: CircularProgressIndicator());
    }

    /// =============================
    /// ERROR
    /// =============================
    if (state.detailError != null && item == null) {
      return Center(child: Text(state.detailError!));
    }

    /// =============================
    /// EMPTY
    /// =============================
    if (item == null) {
      return Center(child: Text('community.eventDetails.eventNotFound'.tr()));
    }

    /// =============================
    /// UI
    /// =============================
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s16.w,
          vertical: AppSpacing.s12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// =============================
            /// EVENT CARD (REUSED COMPONENT)
            /// =============================
            EventListItemCard(
              item: item,
              isDetailView: true,
              onLikeChanged: (bool isLiked) {
                context.read<EventsBloc>().toggleEventLike(
                  eventId: item.id,
                  targetIsLiked: isLiked,
                );
              },
              isAttending: isUserAttendingEvent(item.userRsvpStatus),
              onAttendanceChanged: (value) => {
                AppDialog.show(
                  icon: Lottie.asset(AppIcons.lottie.question, repeat: false),
                  context: context,
                  title: 'community.eventDetails.confirmCancellation'.tr(),
                  content: 'community.eventDetails.cancellationContent'.tr(),
                  primaryLabel: 'common.cancel'.tr(),
                  secondaryLabel: 'community.eventDetails.leave'.tr(),
                  onSecondary: () async {
                    context.read<EventsBloc>().dropFromTheEvent(
                      eventId: item.id,
                    );
                    return true;
                  },
                  onPrimary: () async {
                    return true;
                  },
                ),
              },
            ),

            SizedBox(height: AppSpacing.s16.h),

            /// =============================
            /// REFRESH LOADER
            /// =============================
            if (state.isDetailRefreshing)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  bool isUserAttendingEvent(String? attendingStatus) {
    if (attendingStatus?.toLowerCase() == 'attending') {
      return true;
    }
    return false; // Placeholder return value
  }

  bool canJoinEvent({
    required String? eventEndDate,
    required String eventTime,
  }) {
    // CASE 1: No end date → open event
    if (eventEndDate == null || eventEndDate.isEmpty) {
      return true;
    }
    // CASE 2: Has end date → check if event is still valid
    final now = DateTime.now();
    final end = getEventEndDateTime(eventEndDate, eventTime);

    return now.isBefore(end) || now.isAtSameMomentAs(end);
  }

  DateTime getEventEndDateTime(String eventEndDate, String eventTime) {
    final baseDate = DateTime.parse(eventEndDate).toLocal();

    final regex = RegExp(r'(\d+):(\d+)\s*(AM|PM)');
    final match = regex.firstMatch(eventTime);

    if (match == null) {
      throw Exception('Invalid eventTime format');
    }

    int hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final period = match.group(3)!;

    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;

    return DateTime(baseDate.year, baseDate.month, baseDate.day, hour, minute);
  }

  Future<void> deleteEvent(String eventId) async {
    setState(() {
      isApiExecuting = true;
    });

    try {
      await context.read<EventsBloc>().deleteEvent(eventId: eventId);
      // ignore: use_build_context_synchronously
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        isApiExecuting = false;
      });
    } finally {
      setState(() {
        isApiExecuting = false;
      });
    }
  }

  Future<void> reportEvent(String eventId, String reason) async {
    setState(() {
      isApiExecuting = true;
    });

    try {
      await context.read<EventsBloc>().reportEvent(
        eventId: widget.eventId,
        reason: reason,
      );
      // ignore: use_build_context_synchronously
      if (!mounted) return;
    } catch (e) {
      setState(() {
        isApiExecuting = false;
      });
    } finally {
      setState(() {
        isApiExecuting = false;
      });
    }
  }
}
