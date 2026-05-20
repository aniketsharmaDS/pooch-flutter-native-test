// ignore_for_file: avoid_redundant_argument_values, constant_identifier_names, unused_catch_stack, inference_failure_on_function_invocation, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/enums/medical_history_record_type_filter.dart';
import 'package:poochcare/core/services/crashlytics_service.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/image_calling_dialog.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_bloc.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_event.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/events/my_live_posts_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/events/my_review_posts_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_event.dart';
import 'package:poochcare/router/app_router.dart';
import 'package:poochcare/router/router_service.dart';

// Must be outside any class and annotated with @pragma('vm:entry-point')
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Note: Background handler runs in separate isolate, cannot access stream
  // Stream updates only work when app is in foreground
}

enum NotificationNavigation {
  appointmentScheduled,
  appointmentRescheduled,
  appointmentStarted,
  appointmentEnded,
  vetAssigned,
  prescriptionAdded,
  trackOrder,
  orderPlaced,
  orderDelivered,
  invitationReceived,
  tip_comment,
  comment_reply,
  event_like,
  tip_like,
  tip_approved,
  tip_rejected,
  event_approved,
  event_rejected,
  event_rsvp_confirmed,
  event_rsvp_cancelled,
  unknown;

  // Helper to convert backend String to Enum safely
  static NotificationNavigation fromString(String? value) {
    return NotificationNavigation.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationNavigation.unknown,
    );
  }
}

class NotificationService {
  // Singleton Pattern
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static String? currentEventId;
  static String? currentTipId;

  static void getCurrentTipId(String tipId) => currentTipId = tipId;
  static void clearCurrentTipId() => currentTipId = null;

  static void getCurrentEventId(String eventId) => currentEventId = eventId;
  static void clearCurrentEventId() => currentEventId = null;

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // StreamController for home screen refresh trigger
  static final _refreshHomeController = StreamController<String>.broadcast();
  static Stream<String> get refreshHomeStream => _refreshHomeController.stream;

  static final _appointmentEndedController =
      StreamController<String>.broadcast();
  static Stream<String> get appointmentEndedStream =>
      _appointmentEndedController.stream;

  Future<void> init() async {
    // 1. Request Permissions
    await requestPermission();

    // 2. Init Local Notifications (for Android Foreground)
    await initLocalNotifications();

    // 3. Setup Background Handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 4. Handle Interaction (The "Click" Logic)
    setupInteractions();

    // 5. Handle Foreground Messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Check if this is a track order update notification
      bool updateTrackOrder = updateTrackOrderOnNotification(message);
      final type = NotificationNavigation.fromString(
        message.data['nav']?.toString(),
      );

      // Handle tip_approved notification to refresh community blocs
      if (type == NotificationNavigation.tip_approved) {
        final notificationData = message.data;
        final tipId = notificationData['tipId'] as String?;
        refreshTipsBlocs(tipId);
      }

      // Handle event_approved notification to refresh event blocs
      if (type == NotificationNavigation.event_approved) {
        final notificationData = message.data;
        final eventId = notificationData['eventId'] as String?;
        refreshEventBlocs(eventId);
      }

      // Check if this is an order status change notification this will update the pets in the home scree.
      if (message.data['type'] == 'order_status_change' && updateTrackOrder) {
        _refreshHomeController.add('order_status_change');
      }

      NotificationService.showForegroundNotification(message);
    });
  }

  bool updateTrackOrderOnNotification(RemoteMessage message) {
    bool updateTrackOrder =
        message.data['nav'] == 'trackOrder' ||
        message.data['nav'] == NotificationNavigation.orderDelivered.name;
    if (updateTrackOrder) {
      // Emit track order update for active TrackOrderScreen
      final orderId = message.data['orderId'] as String?;
      final itemId = message.data['itemId'] as String?;
      final orderDetailsBloc = getIt<OrderDetailBloc>();
      if (orderId != null && itemId != null && !orderDetailsBloc.isClosed) {
        orderDetailsBloc.add(
          LoadOrderDetail(orderId, itemId, forceRefresh: true),
        );
      }
    }
    return updateTrackOrder;
  }

  Future<void> refreshNotificationToken() async {
    final dio = getIt<Dio>();
    String deviceId = '';

    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      messaging.onTokenRefresh.listen((newToken) async {
        // Whenever a new token is generated, update it on the server
        try {
          deviceId = await getDeviceId();
          await dio.put(
            '/user/notification-token',
            data: {
              'notificationToken': newToken,
              'deviceId': deviceId,
              'deviceType': Platform.isAndroid ? 'Android' : 'iOS',
            },
          );
        } catch (e) {
          // final friendlyMessage = getFriendlyErrorMessage(e);
          // print(
          //   'Error updating refreshed notification token: $friendlyMessage',
          // );
        }
      });
    } catch (e, s) {
      CrashlyticsService.recordError(e, s);
    }
  }

  static Future<void> requestPermission() async {
    try {
      NotificationSettings settings = await _firebaseMessaging
          .requestPermission(alert: true, badge: true, sound: true);
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {}
    } catch (e, s) {
      CrashlyticsService.recordError(e, s);
    }
  }

  Future<void> initLocalNotifications() async {
    // Use a white monochrome icon from drawable folder for notifications
    // NOT the colorful launcher icon from mipmap
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@drawable/ic_notification');

    // 🔥🔥🔥 CREATE ANDROID NOTIFICATION CHANNEL (THIS WAS MISSING)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // MUST MATCH show()
      'High Importance Notifications',
      description: 'Used for foreground notifications',
      showBadge: true,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    final androidPlugin = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.createNotificationChannel(channel);

    // iOS Setup: set defaults to false, we requested permission already
    final DarwinInitializationSettings iosInit =
        const DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    // Create the channel on the device
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // This handles when user taps a LOCAL notification (Foreground case)
        if (response.payload != null) {
          final payload = jsonDecode(response.payload!);
          final filePath = (payload['payload'] ?? '') as String;

          // If payload is a file path, try to open it
          if (filePath.contains('/') || filePath.contains('\\')) {
            try {
              await OpenFilex.open(filePath);
              // ignore: empty_catches
            } catch (e) {}
          } else {
            // final messageData = jsonDecode(response.payload!);
            // dev.log('Notification tapped with data: $messageData');
            // handleNavigation(messageData);
            final messageData =
                jsonDecode(response.payload!) as Map<String, dynamic>;
            handleNavigation(messageData);
          }
        }
        // appRouter.replaceAll([
        //   MainWrapperPage(
        //     children: [
        //       InsightsPage(
        //         children: [
        //           VetsWrapperPage(
        //             children: [
        //               VetsPage(
        //                 appointmentId: "79d7ad9e-6e9f-4ba6-b2f0-a0d17b59d248",
        //                 notificationNavigation:
        //                     NotificationNavigation.appointmentStarted,
        //                 key: ValueKey(DateTime.now().millisecondsSinceEpoch),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ]);
      },
    );
  }

  void handleNavigation(Map<String, dynamic> data) {
    // 1. Convert the string "nav" from backend to our Enum
    final type = NotificationNavigation.fromString(data['nav'].toString());

    // 2. Decide where to go based on the Enum
    switch (type) {
      case NotificationNavigation.invitationReceived:
        appRouter.replaceAll([const HomeRoute(), const InvitesRoute()]);
        break;
      case NotificationNavigation.trackOrder ||
          NotificationNavigation.orderDelivered:
        final orderId = data['orderId'] as String?;
        final itemId = data['itemId'] as String?;
        appRouter.replaceAll([
          const HomeRoute(),
          const OrdersListingRoute(),
          TrackOrderRoute(orderId: orderId ?? '', itemId: itemId ?? ''),
        ]);
        break;
      case NotificationNavigation.orderPlaced:
        appRouter.replaceAll([const HomeRoute(), const OrdersListingRoute()]);
        break;
      case NotificationNavigation.appointmentScheduled:
      case NotificationNavigation.appointmentRescheduled:
        appRouter.replaceAll([
          const HomeRoute(
            children: [
              InsightTabRoute(children: [InsightVetsRoute()]),
            ],
          ),
        ]);
        break;

      case NotificationNavigation.appointmentStarted:
        final appointmentId = data['appointmentId'];
        final clinicName = data['clinicName'];
        final address = data['address'];
        final clinicImage = data['clinicImage'];
        appRouter.replaceAll([
          const HomeRoute(
            children: [
              InsightTabRoute(children: [InsightVetsRoute()]),
            ],
          ),
        ]);
        break;

      case NotificationNavigation.prescriptionAdded:
        final recordId = data['medicalHistoryId'] ?? '';
        appRouter.replaceAll([
          const HomeRoute(),
          const PetMedicalHistoryRoute(),
        ]);
        break;

      case NotificationNavigation.vetAssigned:
        appRouter.replaceAll([
          const HomeRoute(
            children: [
              InsightTabRoute(children: [InsightVetsRoute()]),
            ],
          ),
        ]);
        break;

      /// Below Are Navigation for Community Feature

      case NotificationNavigation.tip_comment:
      case NotificationNavigation.comment_reply:
      case NotificationNavigation.tip_like:
        final tipId = (data['tip_id'] ?? data['tipId']) as String?;
        appRouter.replaceAll([
          const HomeRoute(children: [CommunityTabRoute()]),
          CommunityTipsGuideDetailsRoute(tipId: tipId ?? ''),
        ]);
        break;

      case NotificationNavigation.event_like:
        final eventId = (data['eventId'] ?? data['event_id']) as String?;
        appRouter.replaceAll([
          const HomeRoute(children: [CommunityTabRoute()]),
          CommunityEventDetailsRoute(eventId: eventId ?? ''),
        ]);
        break;

      case NotificationNavigation.tip_approved:
      case NotificationNavigation.tip_rejected:
        final tipId = (data['tip_id'] ?? data['tipId']) as String?;
        appRouter.replaceAll([
          const HomeRoute(children: [CommunityTabRoute()]),
          CommunityTipsGuideDetailsRoute(tipId: tipId ?? ''),
        ]);
        break;

      case NotificationNavigation.event_approved:
      case NotificationNavigation.event_rejected:
      case NotificationNavigation.event_rsvp_confirmed:
      case NotificationNavigation.event_rsvp_cancelled:
        final eventId = data['eventId'] as String?;
        appRouter.replaceAll([
          const HomeRoute(),
          CommunityEventDetailsRoute(eventId: eventId ?? ''),
        ]);
        break;

      default:
        appRouter.replaceAll([const HomeRoute()]);
        break;
    }
  }

  // SETUP LISTENERS FOR BACKGROUND/TERMINATED TAPS
  Future<void> setupInteractions() async {
    // A. Terminated State (App opens from closed state)
    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();
    if (initialMessage != null) {
      //
      Future.delayed(const Duration(milliseconds: 2000), () {
        handleNavigation(initialMessage.data);
      });
    }

    // B. Background State (App opens from background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //

      handleNavigation(message.data);
    });
  }

  // DISPLAY FOREGROUND NOTIFICATION
  static Future<void> showForegroundNotification(RemoteMessage message) async {
    const String joinActionId = 'id_join_button';
    bool hasJoinAction =
        message.data['nav'] ==
        'appointmentStarted'; // Example condition for adding action
    bool appointmentEnded =
        message.data['nav'] ==
        'appointmentEnded'; // Example condition for adding action

    if (hasJoinAction) {
      updateMyAppointmentList();
      showInAppDialogApointmentStarted(message);
      return;
    }

    if (appointmentEnded) {
      final appointmentId = message.data['appointmentId'];
      if (appointmentId != null) {
        _appointmentEndedController.add(appointmentId.toString());
        showInAppDialogApointmentEnded(message);
      }
      updateMyAppointmentList();
    }

    final type = NotificationNavigation.fromString(
      message.data['nav']?.toString(),
    );

    // Handle tip_approved notification to refresh community blocs
    if (type == NotificationNavigation.appointmentScheduled ||
        type == NotificationNavigation.appointmentRescheduled) {
      // No Dialog for Schedue and Re-Schedule
      // showInAppDialogApointmentStarted(message);
      updateMyAppointmentList();
    }

    // Important: Android needs a high_importance_channel
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/ic_notification', // Explicitly set the notification icon
      playSound: true,
      enableVibration: true,
      actions: hasJoinAction
          ? <AndroidNotificationAction>[
              const AndroidNotificationAction(
                joinActionId, // The ID you defined
                'Join Now', // The Label user sees
                showsUserInterface: true, // Opens the app when clicked
              ),
            ]
          : null,
    );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(),
    );

    final title = message.data['title'] ?? message.notification?.title ?? '';
    final body = message.data['body'] ?? message.notification?.body ?? '';

    // Show the notification locally
    // We encode the data payload to pass it through to the local notification tap handler
    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      title.toString(),
      body.toString(),
      platformDetails,
      payload: jsonEncode(message.data), // Pass data for navigation
    );
  }

  static void updateMyAppointmentList() {
    // Update bloc state with new status
    getIt<AppointmentBloc>().add(const FetchAllAppointments(1, true));
  }

  static void refreshTipsBlocs(String? tipId) {
    // Refresh MyTipsBloc
    final myTipsBloc = getIt<TipsGuideBloc>();
    if (!myTipsBloc.isClosed) {
      myTipsBloc.fetchInitialTips(type: TipsGuideType.allMyTipsGuides);
    }

    // // Refresh PostsUnderReviewBloc
    final postsUnderReviewBloc = getIt<MyReviewPostsBloc>();
    if (!postsUnderReviewBloc.isClosed) {
      postsUnderReviewBloc.fetchInitialPosts();
    }

    // // Refresh TipsDetailsBloc if tipId is available and bloc is registered
    if (tipId != null && tipId.isNotEmpty && currentTipId == tipId) {
      final tipsDetailsBloc = getIt<TipsGuideBloc>();
      if (!tipsDetailsBloc.isClosed) {
        tipsDetailsBloc.fetchTipsDetails(tipId);
      }
    }

    final livePosts = getIt<MyLivePostsBloc>();
    if (!livePosts.isClosed) {
      livePosts.fetchInitialPosts();
    }
  }

  static void refreshEventBlocs(String? eventId) {
    // Refresh MyEventsBloc
    final myEventsBloc = getIt<EventsBloc>();
    if (!myEventsBloc.isClosed) {
      myEventsBloc.fetchInitial();
    }

    // // Refresh PostsUnderReviewBloc
    final postsUnderReviewBloc = getIt<MyReviewPostsBloc>();
    if (!postsUnderReviewBloc.isClosed) {
      postsUnderReviewBloc.fetchInitialPosts();
    }

    // // Refresh EventDetailBloc if eventId is available and bloc is registered
    if (eventId != null && eventId.isNotEmpty && currentEventId == eventId) {
      final eventDetailBloc = getIt<EventsBloc>();
      if (!eventDetailBloc.isClosed) {
        eventDetailBloc.fetchEventDetails(eventId);
      }
    }

    final livePosts = getIt<MyLivePostsBloc>();
    if (!livePosts.isClosed) {
      livePosts.fetchInitialPosts();
    }
  }

  // This is a custom in-app dialog for appointment end notifications, triggered from the foreground message handler. It provides a more immediate and interactive experience compared to a standard local notification.
  static void showInAppDialogApointmentEnded(RemoteMessage message) {
    final context = appRouter.navigatorKey.currentContext;

    if (context == null) {
      return;
    }

    // final title = message.data['title'] ?? 'Appointment Started';
    // final body = message.data['body'] ?? 'Your appointment has started';
    final title =
        message.data['title'] ??
        message.notification?.title ??
        'Appointment Started';
    final body =
        message.data['body'] ??
        message.notification?.body ??
        'Your appointment has started';
    bool isLoading = false;

    AppDialog.show(
      icon: Lottie.asset(AppIcons.lottie.completeSuccessful, repeat: true),
      context: context,
      title: 'Consultation Complete',
      content:
          'The consultation has been completed. You will be notified once the prescription is available',
      primaryLabel: 'View Details',
      onPrimary: () async {
        final appointmentId = message.data['appointmentId'].toString();
        appRouter.push(
          PetMedicalDetailsRoute(
            recordId: '',
            appointmentId: appointmentId,
            recordType: MedicalHistoryRecordTypeFilter.consultation,
          ),
        );
      },
      secondaryLabel: 'Done',
      onSecondary: () async {
        // Just close the dialog
        // Navigator.pop(context, true);
      },
    );
  }

  // This is a custom in-app dialog for appointment start notifications, triggered from the foreground message handler. It provides a more immediate and interactive experience compared to a standard local notification.
  static void showInAppDialogApointmentStarted(RemoteMessage message) {
    final context = appRouter.navigatorKey.currentContext;

    if (context == null) {
      return;
    }

    // final title = message.data['title'] ?? 'Appointment Started';
    // final body = message.data['body'] ?? 'Your appointment has started';
    final title =
        message.data['title'] ??
        message.notification?.title ??
        'Appointment Started';
    final body =
        message.data['body'] ??
        message.notification?.body ??
        'Your appointment has started';
    bool isLoading = false;

    IncomingCallDialog.show(
      context: context,

      clinicName: 'Dogs & Cats\nVeterinary Clinic',

      onAccept: () {
        final appointmentId = message.data['appointmentId'].toString();

        appRouter.push(
          ParentVetChatRoute(
            appointmentId: appointmentId,
            enableVideoCall: true,
            autoJoinVideoCall: true,
          ),
        );
      },
      onDecline: () {
        // debugPrint('Call Declined');
      },
    );
  }

  Future<String?> getDeviceToken() async {
    try {
      // 1️⃣ Check current permission status
      NotificationSettings settings = await _firebaseMessaging
          .getNotificationSettings();

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // Permission already granted, return the token
        String? token = await _firebaseMessaging.getToken();

        return token;
      } else {
        // Permission not granted, request it
        NotificationSettings requestedSettings = await _firebaseMessaging
            .requestPermission(alert: true, badge: true, sound: true);

        if (requestedSettings.authorizationStatus ==
                AuthorizationStatus.authorized ||
            requestedSettings.authorizationStatus ==
                AuthorizationStatus.provisional) {
          // Permission granted after request
          String? token = await _firebaseMessaging.getToken();

          return token;
        } else {
          // Permission denied

          return null;
        }
      }
    } catch (e, s) {
      return null;
    }
  }

  Future<void> deleteDeviceToken() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return info.id;
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return info.identifierForVendor ?? '';
    }
    return '';
  }

  void dispose() {
    _refreshHomeController.close();
  }
}
