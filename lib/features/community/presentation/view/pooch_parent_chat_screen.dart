import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class PoochParentChatScreen extends StatefulWidget {
  final String userName;
  final String source;

  const PoochParentChatScreen({
    super.key,
    required this.userName,
    required this.source,
  });

  @override
  State<PoochParentChatScreen> createState() => _PoochParentChatScreenState();
}

class _PoochParentChatScreenState extends State<PoochParentChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hi! Can you tell me about the event you organized?',
      'isMe': true,
      'time': '14:55',
    },
    {
      'text': 'Sure! It was a pet social and adoption day.',
      'isMe': false,
      'time': '14:55',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope<bool>(
      canPop: false, // 🔥 blocks system back
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        handleBackNavigation();
        // 🔥 Show confirmation toast/snackbar/dialog
        // final shouldExit = await _showExitConfirmation();

        // if (shouldExit == true) {
        //   // 🔥 allow pop manually
        //   context.router.pop(true);
        // }
      },
      child: AppPrimaryScreenContainer(
        backgroundColor: AppColors.white_50,
        title: '',
        resizeToAvoidBottomInset: true,
        onBack: () => handleBackNavigation(),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.s8.w,
            ).copyWith(bottom: AppSpacing.s9.h),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                border: Border.all(
                  color: AppColors.transparent, // or your theme color
                  width: 1.5,
                ),
              ),
              child: AppPrimaryBgContainer(
                borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.s14.h),
                      decoration: BoxDecoration(
                        color: AppColors.p2_100,
                        borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText.h1(
                            widget.userName,
                            fontSize: AppFontSize.fs14,
                          ),
                        ],
                      ),
                    ),

                    Expanded(child: _chatList()),
                    _inputBar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chatList() {
    return ListView.builder(
      padding: EdgeInsets.all(AppSpacing.s16.w),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        return _messageBubble(
          text: (msg['text'] ?? '') as String,
          isMe: (msg['isMe'] ?? false) as bool,
          time: (msg['time'] ?? '') as String,
        );
      },
    );
  }

  Widget _messageBubble({
    required String text,
    required bool isMe,
    required String time,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.h),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.s14.w,
              vertical: AppSpacing.s10.h,
            ),
            decoration: BoxDecoration(
              color: isMe ? AppColors.p1_400 : AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.s14.r),
            ),
            child: AppText.bodyM(text, color: AppColors.textPrimary),
          ),
          AppText.support(time, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _inputBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s10.w,
        vertical: AppSpacing.s8.h,
      ),
      child: Row(
        children: [
          /// 🔹 MAIN INPUT CONTAINER
          Expanded(
            child: Container(
              padding: EdgeInsets.all(
                AppSpacing.s10.w,
              ).copyWith(bottom: AppSpacing.s8.h),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.s16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Start typing...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  AppIcon(
                    AppIcons.svg.generic.pinAttachment,
                    color: AppColors.p4_900,
                  ),
                  AppSpacing.s10.wBox,
                  AppIcon(AppIcons.svg.generic.camera, color: AppColors.p4_900),
                ],
              ),
            ),
          ),

          /// 🔸 SPACE BETWEEN
          SizedBox(width: AppSpacing.s10.w),

          /// 🔺 SEND BUTTON (OUTSIDE)
          ///
          AppCircleButton(
            preserveSvgColor: true,
            onTap: _sendMessage,
            icon: AppIcons.svg.generic.send,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        'text': _controller.text.trim(),
        'isMe': true,
        'time': 'Now',
      });
    });

    _controller.clear();
  }

  void handleBackNavigation() async {
    // context.router.pop();
    if (widget.source.isEmpty) {
      context.router.pop();
    } else if (widget.source.toLowerCase() == 'community_screen') {
      context.router.pop();
    } else if (widget.source.toLowerCase() ==
        'community_event_details_screen') {
      context.router.pop();
    } else if (widget.source.toLowerCase() == 'missing_pet_chat') {
      final secureStorage = getIt<SecureStorageService>();
      String returnType = await secureStorage.readChatJourney() ?? 'none';
      if (!mounted) {
        return;
      }

      if (returnType == 'none') {
        context.router.popUntilRoot();
        return;
      }
      if (returnType == ChatReturnType.allMissingPetUserTab.name) {
        context.router.navigate(
          MyCommunityHomeRoute(
            children: [
              MyPostTabRoute(
                // ignore: avoid_redundant_argument_values
                initialIndex: 0,
                children: const [MyPostedAllRoute()],
              ),
            ],
          ),
        );
      } else if (returnType == ChatReturnType.allMissingPetUserList.name) {
        context.router.navigate(
          MyCommunityHomeRoute(
            children: [
              MyPostTabRoute(
                // ignore: avoid_redundant_argument_values
                initialIndex: 3,
                children: const [MyPostedMissingPetsRoute()],
              ),
            ],
          ),
        );
      } else if (returnType == ChatReturnType.allMissingPetsTab.name) {
        context.router.popUntilRoot();
      } else if (returnType == ChatReturnType.allMissingPetList.name) {
        context.router.popUntilRoot();
        // context.router.popUntilRouteWithName(AllMissingPoochListRoute.name);
        // context.router.navigate(AllMissingPoochListRoute());
      } else {
        context.router.popUntilRoot();
      }
    }
  }
}
