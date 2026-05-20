import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

/// ======================================================
/// FULL SCREEN INCOMING CALL DIALOG
/// ======================================================

class IncomingCallDialog {
  static Future<void> show({
    required BuildContext context,
    required VoidCallback onAccept,
    required VoidCallback onDecline,
    String title = 'Chat',
    String clinicName = 'Dogs & Cats\nVeterinary Clinic',
    String imageUrl =
        'https://images.unsplash.com/photo-1628009368231-7bb7cfcb0def?q=80&w=1200&auto=format&fit=crop',
  }) {
    return showGeneralDialog(
      context: context,
      // barrierDismissible: false,
      barrierLabel: 'Incoming Call',
      barrierColor: Colors.black.withValues(alpha: 0.45),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, _, _) {
        return _IncomingCallView(
          title: title,
          clinicName: clinicName,
          imageUrl: imageUrl,
          onAccept: onAccept,
          onDecline: onDecline,
        );
      },
      transitionBuilder: (_, animation, _, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8 * animation.value,
            sigmaY: 8 * animation.value,
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}

/// ======================================================
/// UI
/// ======================================================

class _IncomingCallView extends StatefulWidget {
  final String title;
  final String clinicName;
  final String imageUrl;

  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _IncomingCallView({
    required this.title,
    required this.clinicName,
    required this.imageUrl,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  State<_IncomingCallView> createState() => _IncomingCallViewState();
}

class _IncomingCallViewState extends State<_IncomingCallView>
    with SingleTickerProviderStateMixin {
  double dragPosition = 0;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDrag(DragUpdateDetails details, BoxConstraints constraints) {
    final maxWidth = constraints.maxWidth - 90.w;

    setState(() {
      dragPosition += details.delta.dx;
      dragPosition = dragPosition.clamp(-maxWidth / 2, maxWidth / 2);
    });
  }

  void _handleDragEnd(BoxConstraints constraints) {
    final maxWidth = constraints.maxWidth - 90.w;

    /// ACCEPT
    if (dragPosition > maxWidth * 0.30) {
      Navigator.pop(context);

      widget.onAccept();
      return;
    }

    /// DECLINE
    if (dragPosition < -maxWidth * 0.30) {
      Navigator.pop(context);

      widget.onDecline();
      return;
    }

    /// RESET
    setState(() {
      dragPosition = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_50,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              PoochScreenAppBar(
                title: widget.title,
                onBack: () => {Navigator.pop(context), widget.onDecline()},
              ),

              /// HEADER
              SizedBox(height: 20.h),

              /// MAIN CARD
              Expanded(
                child: AppPrimaryBgContainer(
                  borderRadius: BorderRadius.circular(AppRadiusSize.r10.rr),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadiusSize.r10.rr),
                    ),
                    child: Column(
                      children: [
                        const Spacer(),

                        /// IMAGE
                        Container(
                          width: 190.w,
                          height: 191.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppRadiusSize.r10.rr,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(height: 18.h),

                        // ClINIC NAME
                        AppText.h3(
                          widget.clinicName,
                          textAlign: TextAlign.center,
                          fontSize: AppFontSize.fs16,
                        ),

                        const Spacer(),

                        /// MESSAGE BUTTON
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 21.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xDDCDB64A,
                            ).withValues(alpha: 0.29),
                            borderRadius: BorderRadius.circular(
                              AppRadiusSize.r5.rr,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.chat_bubble_outline, size: 13),
                              SizedBox(width: 8.w),
                              AppText.support('Message'),
                            ],
                          ),
                        ),

                        SizedBox(height: 40.h),

                        /// SLIDE ACTION
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                height: AppSize.cs84.csh,
                                width: double.infinity,
                                // margin: const EdgeInsets.all(20),
                                // padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.r),
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(
                                        0xFFFFBC20,
                                      ).withValues(alpha: 0.29),
                                      const Color(
                                        0xFFFFDB88,
                                      ).withValues(alpha: 0.29),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.08,
                                      ),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60.r),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 18,
                                      sigmaY: 18,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        /// LABELS
                                        Positioned(
                                          left: 28.w,
                                          child: AppText.h3(
                                            'Decline',
                                            color: Colors.red,
                                          ),
                                        ),

                                        Positioned(
                                          right: 28.w,
                                          child: AppText.h3(
                                            'Answer',
                                            color: Colors.green,
                                          ),
                                        ),

                                        /// DRAG BUTTON
                                        Transform.translate(
                                          offset: Offset(dragPosition, 0),
                                          child: GestureDetector(
                                            onHorizontalDragUpdate: (details) {
                                              _handleDrag(details, constraints);
                                            },
                                            onHorizontalDragEnd: (_) {
                                              _handleDragEnd(constraints);
                                            },
                                            child: Container(
                                              width: AppRadiusSize.r56.rr,
                                              height: AppRadiusSize.r56.rr,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                Icons.videocam_rounded,
                                                size: 36.sp,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              // return Container(
                              //   height: AppSize.cs84.csh,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(60.r),
                              //     gradient: LinearGradient(
                              //       colors: [
                              //         const Color(0xFFFFBC20).withValues(alpha: 0.29),
                              //         const Color(0xFFFFDB88).withValues(alpha: 0.29),
                              //       ],
                              //     ),
                              //   ),
                              //   child: Stack(
                              //     alignment: Alignment.center,
                              //     children: [
                              //       /// LABELS
                              //       Positioned(
                              //         left: 28.w,
                              //         child: AppText.h3(
                              //           'Decline',
                              //           color: Colors.red,
                              //         ),
                              //       ),

                              //       Positioned(
                              //         right: 28.w,
                              //         child: AppText.h3('Answer', color: Colors.green,),
                              //       ),

                              //       /// DRAG BUTTON
                              //       Transform.translate(
                              //         offset: Offset(dragPosition, 0),
                              //         child: GestureDetector(
                              //           onHorizontalDragUpdate: (details) {
                              //             _handleDrag(details, constraints);
                              //           },
                              //           onHorizontalDragEnd: (_) {
                              //             _handleDragEnd(constraints);
                              //           },
                              //           child: Container(
                              //             width: AppRadiusSize.r56.rr,
                              //             height: AppRadiusSize.r56.rr,
                              //             decoration: const BoxDecoration(
                              //               color: Colors.white,
                              //               shape: BoxShape.circle,
                              //               boxShadow: [
                              //                 BoxShadow(
                              //                   color: Colors.black12,
                              //                   blurRadius: 10,
                              //                   offset: Offset(0, 4),
                              //                 ),
                              //               ],
                              //             ),
                              //             child: Icon(
                              //               Icons.videocam_rounded,
                              //               size: 36.sp,
                              //               color: Colors.black87,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            },
                          ),
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
