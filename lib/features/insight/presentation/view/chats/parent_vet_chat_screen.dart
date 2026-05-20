// ignore_for_file: inference_failure_on_function_invocation, prefer_final_fields, unused_field
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:poochcare/core/services/image_picker_service.dart';
import 'package:poochcare/core/services/notification_service.dart';

/// ---------------------------
/// YOUR IMPORTS
/// ---------------------------
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_card.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_chat_header_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/video_player/app_call_video_view.dart';
import 'package:poochcare/features/appointments/data/models/appointments_response_model.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:video_player/video_player.dart';

/// OLD LOGIC IMPORTS
// import 'package:pooch_fe_native/core/utils/service/image_picker_service.dart';
// import 'package:pooch_fe_native/features/insights/data/models/appointment_detail_model.dart';
// import 'package:pooch_fe_native/features/insights/domain/controller/clinics_controller.dart';

/// VIDEO PLAYER
// import 'package:pooch_fe_native/features/tips_and_tricks/presentation/widgets/custom_awesome_video_player.dart';

@RoutePage()
class ParentVetChatScreen extends StatefulWidget {
  final String appointmentId;
  final bool enableVideoCall;
  final AppointmentApiModel? appointmentDetails;
  final bool autoJoinVideoCall;

  const ParentVetChatScreen({
    super.key,
    required this.appointmentId,
    required this.enableVideoCall,
    this.appointmentDetails,
    this.autoJoinVideoCall = false,
  });

  @override
  State<ParentVetChatScreen> createState() => _ParentVetChatScreenState();
}

enum MessageType { text, image, callNotification }

class ChatMessage {
  final String id;
  final String text;
  final bool isFromCurrentUser;
  final DateTime timestamp;
  final MessageType messageType;
  final File? imageFile;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isFromCurrentUser,
    required this.timestamp,
    required this.messageType,
    this.imageFile,
  });
}

class MessageGroup {
  final String dateLabel;
  final List<ChatMessage> messages;

  MessageGroup({required this.dateLabel, required this.messages});
}

class _ParentVetChatScreenState extends State<ParentVetChatScreen>
    with SingleTickerProviderStateMixin {
  ///
  /// CONTROLLERS
  ///
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final ImagePickerService _imagePickerService = ImagePickerService();

  // final ClinicsController _clinicsController = ClinicsController();

  late AnimationController _controller;
  late VideoPlayerController _videoController;

  ///
  /// CHAT DATA
  ///
  final List<ChatMessage> _messages = [];

  ///
  /// APPOINTMENT
  ///
  AppointmentApiModel? _appointmentDetails;

  bool _isLoadingAppointment = false;

  String? _appointmentErrorMessage;

  ///
  /// VIDEO OVERLAY
  ///
  bool _showVideoOverlay = false;

  bool _isMinimized = false;

  double _overlayLeft = 20;

  double _overlayTop = 100;

  ///
  /// CALL ACTIVE
  ///
  bool isCallActive = false;
  StreamSubscription<String>? _appointmentEndedSubscription;

  @override
  void initState() {
    super.initState();

    _appointmentEndedSubscription = NotificationService.appointmentEndedStream
        .listen((appointmentId) {
          // Only close current appointment screen
          if (appointmentId != widget.appointmentId) {
            return;
          }
          if (!mounted) {
            return;
          }
          setState(() {
            _showVideoOverlay = false;
            _isMinimized = false;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Appointment ended')));
        });

    _videoController =
        VideoPlayerController.asset('assets/videos/video_call.mp4')
          ..initialize().then((_) {
            setState(() {});
          })
          ..setLooping(true)
          ..play();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _initializeAppointmentDetails();

    Future.delayed(const Duration(milliseconds: 500), () {
      _loadMockMessages();

      if (widget.autoJoinVideoCall) {
        setState(() {
          _showVideoOverlay = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _appointmentEndedSubscription?.cancel(); // ADD THIS

    _messageController.dispose();
    _scrollController.dispose();
    _controller.dispose();
    _videoController.dispose(); // ADD THIS
    super.dispose();
  }

  Widget _buildHeaderSkeleton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: AppSpacing.s10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.p2_100,
        borderRadius: BorderRadius.circular(AppSpacing.s16.r),
      ),
      child: Row(
        children: [
          ///
          /// IMAGE
          ///
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),

          SizedBox(width: 12.w),

          ///
          /// TEXTS
          ///
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),

                SizedBox(height: 8.h),

                Container(
                  height: 12.h,
                  width: 220.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          ///
          /// CALL ICON
          ///
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// INIT APPOINTMENT
  ///
  Future<void> _initializeAppointmentDetails() async {
    // To Fetch Appointment Details,
    context.read<ClinicBloc>().add(
      FetchAppointmentDetails(appointmentId: widget.appointmentId),
    );
    // To Fetch Chat list based on appointment details,
    // context.read<ClinicBloc>().add(
    //   FetchAppointmentDetails(appointmentId: widget.appointmentId),
    // );
  }

  ///
  /// MOCK DATA
  ///
  void _loadMockMessages() {
    final now = DateTime.now();

    _messages.addAll([
      ChatMessage(
        id: '1',
        text: 'Hi, a doctor will be available in the next 30 mins',
        isFromCurrentUser: false,
        timestamp: now.subtract(const Duration(hours: 2)),
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '2',
        text: 'Please type the problem...',
        isFromCurrentUser: false,
        timestamp: now.subtract(const Duration(hours: 2)),
        messageType: MessageType.text,
      ),
      ChatMessage(
        id: '3',
        text: 'Bella is unwell from past 4-5 days.',
        isFromCurrentUser: true,
        timestamp: now.subtract(const Duration(minutes: 45)),
        messageType: MessageType.text,
      ),
    ]);

    setState(() {});
  }

  ///
  /// SEND MESSAGE
  ///
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: _messageController.text.trim(),
          isFromCurrentUser: true,
          timestamp: DateTime.now(),
          messageType: MessageType.text,
        ),
      );
    });

    _messageController.clear();

    _scrollToBottom();
  }

  ///
  /// SEND IMAGE
  ///
  void _sendImage(File imageFile) {
    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: '',
          isFromCurrentUser: true,
          timestamp: DateTime.now(),
          messageType: MessageType.image,
          imageFile: imageFile,
        ),
      );
    });

    _scrollToBottom();
  }

  ///
  /// SCROLL
  ///
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  ///
  /// ATTACHMENT SHEET
  ///
  void _showAttachmentBottomSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _attachmentButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () async {
                    Navigator.pop(context);

                    final files = await _imagePickerService.pickImage(
                      context: context,
                      source: PickerSourceType.gallery,
                    );

                    if (files != null && files.isNotEmpty) {
                      _sendImage(files.first);
                    }
                  },
                ),
                _attachmentButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () async {
                    Navigator.pop(context);

                    final files = await _imagePickerService.pickImage(
                      context: context,
                      source: PickerSourceType.camera,
                    );

                    if (files != null && files.isNotEmpty) {
                      _sendImage(files.first);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _attachmentButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 30.r, child: Icon(icon)),
          SizedBox(height: 8.h),
          Text(label),
        ],
      ),
    );
  }

  ///
  /// GROUP BY DATE
  ///
  List<MessageGroup> _groupMessagesByDate(List<ChatMessage> messages) {
    final Map<String, List<ChatMessage>> grouped = {};

    final now = DateTime.now();

    for (var message in messages) {
      final messageDate = DateTime(
        message.timestamp.year,
        message.timestamp.month,
        message.timestamp.day,
      );

      final today = DateTime(now.year, now.month, now.day);

      final yesterday = today.subtract(const Duration(days: 1));

      String dateLabel;

      if (messageDate == today) {
        dateLabel = 'Today';
      } else if (messageDate == yesterday) {
        dateLabel = 'Yesterday';
      } else {
        dateLabel = DateFormat('dd MMM yyyy').format(message.timestamp);
      }

      grouped.putIfAbsent(dateLabel, () => []);

      grouped[dateLabel]!.add(message);
    }

    return grouped.entries
        .map((e) => MessageGroup(dateLabel: e.key, messages: e.value))
        .toList();
  }

  ///
  /// BUILD
  ///
  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      backgroundColor: AppColors.white_50,
      title: 'Chat',
      resizeToAvoidBottomInset: true,
      onBack: () => context.router.pop(),
      child: SafeArea(
        child: Stack(
          children: [
            ///
            /// CHAT UI
            ///
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s7.h,
              ).copyWith(bottom: AppSpacing.s7.h),
              child: AppPrimaryBgContainer(
                borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
                child: Column(
                  children: [
                    ///
                    /// HEADER
                    ///
                    Expanded(
                      child: Container(
                        // margin: EdgeInsets.symmetric(horizontal: AppSpacing.s8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                        ),
                        child: Column(
                          children: [
                            ///
                            /// TOP BAR
                            ///
                            BlocBuilder<ClinicBloc, ClinicState>(
                              buildWhen: (previous, current) =>
                                  previous.appointmentDetailsStatus !=
                                      current.appointmentDetailsStatus ||
                                  previous.appointmentDetails !=
                                      current.appointmentDetails,
                              builder: (context, state) {
                                ///
                                /// LOADING
                                ///
                                if (state.appointmentDetailsStatus ==
                                    AppointmentDetailsStatus.loading) {
                                  return _buildHeaderSkeleton();
                                }

                                ///
                                /// FAILURE
                                ///
                                /// SUCCESS
                                ///
                                final appointment = state.appointmentDetails;

                                final clinic = appointment?.clinic;

                                String location = '';

                                if (clinic?.city != null &&
                                    clinic!.city.isNotEmpty) {
                                  location = clinic.city;
                                } else if (location.isEmpty &&
                                    clinic?.address != null &&
                                    clinic!.address!.isNotEmpty) {
                                  location = clinic.address!;
                                }

                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppSpacing.s6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.p2_100,
                                    borderRadius: BorderRadius.circular(
                                      AppSpacing.s16.r,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 12.w),

                                      Expanded(
                                        child: ClinicDetailsChatHeaderCard(
                                          clinic: ClinicDetailsCardModel(
                                            id: clinic?.id ?? '',
                                            name: _showVideoOverlay
                                                .toString(), // '',
                                            image: clinic?.clinicImage ?? '',
                                            vetCount: '',
                                            experience: '',
                                            status: '',
                                            closingTime: '',
                                            basePrice: '',
                                            location: location,
                                          ),

                                          onCardTap: () {},

                                          enableVideoCall:
                                              widget.enableVideoCall,

                                          onVideoCallTap: () {
                                            setState(() {
                                              _showVideoOverlay = true;
                                            });
                                          },

                                          onAudioCallTap: () {
                                            setState(() {
                                              _showVideoOverlay = false;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            ///
                            /// MESSAGES
                            ///
                            Expanded(child: _buildMessageList()),

                            ///
                            /// INPUT
                            ///
                            _buildInputBar(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///
            /// VIDEO OVERLAY
            ///
            if (_showVideoOverlay)
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _isMinimized
                      ? Stack(
                          key: const ValueKey('mini_stack'),
                          children: [
                            Positioned(
                              left: _overlayLeft,
                              top: _overlayTop,
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  setState(() {
                                    _overlayLeft += details.delta.dx;
                                    _overlayTop += details.delta.dy;
                                  });
                                },
                                child: _buildMiniVideo(),
                              ),
                            ),
                          ],
                        )
                      : _buildFullScreenVideo(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  ///
  /// MESSAGE LIST
  ///
  Widget _buildMessageList() {
    final grouped = _groupMessagesByDate(_messages);

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(16.w),
      itemCount: grouped.length,
      itemBuilder: (_, groupIndex) {
        final group = grouped[groupIndex];

        return Column(
          children: [
            ///
            /// DATE HEADER
            ///
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: AppText.support(
                  group.dateLabel,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            ///
            /// MESSAGES
            ///
            ...group.messages.map((message) => _messageBubble(message)),
          ],
        );
      },
    );
  }

  ///
  /// MESSAGE BUBBLE
  ///
  Widget _messageBubble(ChatMessage message) {
    final isMe = message.isFromCurrentUser;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth * 0.9,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.p1_400 : AppColors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: isMe
                          ? Radius.circular(AppSpacing.s14.r)
                          : Radius.zero, // removed
                      topRight: !isMe
                          ? Radius.circular(AppSpacing.s14.r)
                          : Radius.zero, // removed
                      bottomLeft: Radius.circular(AppSpacing.s14.r),
                      bottomRight: Radius.circular(AppSpacing.s14.r),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s14.w,
                    vertical: AppSpacing.s10.h,
                  ),
                  child: message.messageType == MessageType.image
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppRadiusSize.r12.rr,
                          ),
                          child: Image.file(message.imageFile!),
                        )
                      : AppText.bodyM(
                          message.text,
                          color: AppColors.textPrimary,
                          variant: AppTextVariant.noEllipsis,
                        ),
                ),
              ),
              AppText.support(
                DateFormat('HH:mm').format(message.timestamp),
                color: AppColors.textSecondary,
              ),
            ],
          );
        },
      ),
    );
  }

  ///
  /// INPUT BAR
  ///
  Widget _buildInputBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        // horizontal: AppSpacing.s10.w,
        vertical: AppSpacing.s8.h,
      ).copyWith(left: AppSpacing.s10.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s10.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.s16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Start typing...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  ///
                  /// ATTACHMENT
                  ///
                  GestureDetector(
                    onTap: _showAttachmentBottomSheet,
                    child: AppIcon(
                      AppIcons.svg.generic.pinAttachment,
                      color: AppColors.p4_900,
                    ),
                  ),

                  AppSpacing.s10.wBox,

                  ///
                  /// CAMERA
                  ///
                  GestureDetector(
                    onTap: () async {
                      final files = await _imagePickerService.pickImage(
                        context: context,
                        source: PickerSourceType.camera,
                      );

                      if (files != null && files.isNotEmpty) {
                        _sendImage(files.first);
                      }
                    },
                    child: AppIcon(
                      AppIcons.svg.generic.camera,
                      color: AppColors.p4_900,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // SizedBox(width: AppSpacing.s10.w),

          ///
          /// SEND
          ///
          AppCircleButton(
            shape: AppCircleButtonShape.square,
            preserveSvgColor: true,
            onTap: _sendMessage,
            icon: AppIcons.svg.generic.send,
            borderRadius: AppRadiusSize.r16.rr,
          ),
        ],
      ),
    );
  }

  Widget _buildFullScreenVideo() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          ///
          /// VIDEO
          ///
          Positioned.fill(
            child: AppCallVideoView(
              controller: _videoController,

              ///
              /// FULLSCREEN CONTROLS
              ///
              overlay: Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 10,
                // right: 12,
                child: CallControlsUI(
                  onCloseClick: () {
                    setState(() {
                      _showVideoOverlay = false;
                    });
                  },
                  onMinimizeClick: () {
                    setState(() {
                      _isMinimized = true;
                    });
                  },
                ),

                // child: Row(
                //   children: [
                //     ///
                //     /// MINIMIZE
                //     ///
                //     IconButton(
                //       onPressed: () {
                //         setState(() {
                //           _isMinimized = true;
                //         });
                //       },
                //       icon: const Icon(
                //         Icons.fullscreen_exit,
                //         color: Colors.white,
                //       ),
                //     ),

                //     ///
                //     /// END CALL
                //     ///
                //     IconButton(
                //       onPressed: () {
                //         setState(() {
                //           _showVideoOverlay = false;
                //         });
                //       },
                //       icon: const Icon(Icons.call_end, color: Colors.red),
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniVideo() {
    return SizedBox(
      width: 140.w,
      height: 220.h,
      child: AppCallVideoView(
        controller: _videoController,
        borderRadius: BorderRadius.circular(16.r),

        ///
        /// MINI CONTROLS
        ///
        overlay: Stack(
          children: [
            ///
            /// TAP TO MAXIMIZE
            ///
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isMinimized = false;
                  });
                },
              ),
            ),

            ///
            /// END CALL
            ///
            Positioned(
              top: 6,
              right: 6,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _showVideoOverlay = false;
                  });
                },
                icon: const Icon(Icons.call_end, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CallControlsUI extends StatelessWidget {
  final VoidCallback? onCloseClick;
  final VoidCallback? onMinimizeClick;

  const CallControlsUI({
    super.key,
    required this.onCloseClick,
    required this.onMinimizeClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadiusSize.r20.rr),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFBC20).withValues(alpha: .75),
            const Color(0xFFFFDB88).withValues(alpha: 0.75),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadiusSize.r20.rr),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _circleButton(
                icon: Icons.more_vert,
                onTap: () {
                  onMinimizeClick?.call();
                },
              ),

              const SizedBox(width: 12),

              _circleButton(icon: Icons.videocam_outlined, onTap: () {}),

              const SizedBox(width: 12),

              _circleButton(icon: Icons.mic_none_rounded, onTap: () {}),

              const SizedBox(width: 12),

              _circleButton(icon: Icons.volume_up_outlined, onTap: () {}),

              const SizedBox(width: 12),

              _circleButton(
                icon: Icons.call_end,
                backgroundColor: const Color(0xFFFF3B3B),
                iconColor: Colors.white,
                onTap: () {
                  onCloseClick?.call();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color backgroundColor = Colors.white,
    Color iconColor = const Color(0xFF5B5B5B),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 28),
      ),
    );
  }
}
