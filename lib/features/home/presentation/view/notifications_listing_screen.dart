import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/home/presentation/bloc/notifications_bloc.dart';
import 'package:poochcare/features/home/presentation/bloc/notifications_event.dart';
import 'package:poochcare/features/home/presentation/bloc/notifications_state.dart';
import 'package:poochcare/features/insight/presentation/widgets/state_wrapper.dart';

@RoutePage()
class NotificationListingScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const NotificationListingScreen({super.key});

  @override
  State<NotificationListingScreen> createState() =>
      _NotificationListingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<NotificationBloc>()
        ..add(const FetchNotificationsEvent(isForceRefresh: true)),
      child: this,
    );
  }
}

class _NotificationListingScreenState extends State<NotificationListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              final notificationBloc = context.read<NotificationBloc>();
              notificationBloc.add(
                const FetchNotificationsEvent(isForceRefresh: true),
              );
              await notificationBloc.stream.firstWhere(
                (element) => element.status == NotificationStatus.success,
              );
            },
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                  child: PoochScreenAppBar(title: 'Notifications'),
                ),
                Expanded(
                  child: BlocBuilder<NotificationBloc, NotificationState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      final notifications = state.notifications;

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          // Trigger next page when user scrolls to 80% of max extent
                          if (scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent * 0.8) {
                            context.read<NotificationBloc>().add(
                              const FetchNotificationsEvent(),
                            );
                          }
                          return false;
                        },
                        child: StateWrapper(
                          isEmpty: notifications.isEmpty,
                          isError: state.status == NotificationStatus.failure,
                          isLoading:
                              state.status == NotificationStatus.loading &&
                              notifications.isEmpty,
                          title: 'Notification',
                          onRetry: () {
                            context.read<NotificationBloc>().add(
                              const FetchNotificationsEvent(
                                isForceRefresh: true,
                              ),
                            );
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s12,
                              vertical: AppSpacing.s12,
                            ),
                            itemCount:
                                notifications.length +
                                (state.hasReachedMax ? 0 : 1),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: AppSpacing.s8),
                            itemBuilder: (context, index) {
                              // Show loading indicator at the end if more items to load
                              if (index == notifications.length) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppSpacing.s16,
                                  ),
                                  child: Center(
                                    child:
                                        state.status ==
                                            NotificationStatus.loading
                                        ? const CircularProgressIndicator()
                                        : const SizedBox.shrink(),
                                  ),
                                );
                              }

                              final notification = notifications[index];

                              return Container(
                                decoration: BoxDecoration(
                                  color: notification.isRead
                                      ? AppColors.white
                                      : AppColors.p1_100,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.s12,
                                    vertical: AppSpacing.s8,
                                  ),
                                  title: AppText.h3(
                                    notification.titleKey,
                                    fontSize: AppFontSize.fs14,
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                      top: AppSpacing.s4,
                                    ),
                                    child: AppText.bodyS(
                                      notification.messageKey,
                                      fontSize: AppFontSize.fs12,
                                      variant: AppTextVariant.noEllipsis,
                                    ),
                                  ),
                                  trailing: Column(
                                    children: [
                                      if (!notification.isRead)
                                        Container(
                                          width: 8.w,
                                          height: 8.h,
                                          decoration: const BoxDecoration(
                                            color: AppColors.p1,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Handle notification tap - can navigate or mark as read
                                    _handleNotificationTap(
                                      context,
                                      notification,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNotificationTap(BuildContext context, notification) {}
}
