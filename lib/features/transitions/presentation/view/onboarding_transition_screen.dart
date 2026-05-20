import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/router/app_router.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class OnboardingTransitionScreen extends StatefulWidget {
  const OnboardingTransitionScreen({
    super.key,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
  });

  final String? initialPhoneNumber;
  final String? initialEmail;
  final String? initialCountryCode;

  @override
  State<OnboardingTransitionScreen> createState() =>
      _OnboardingTransitionScreenState();
}

class _OnboardingTransitionScreenState extends State<OnboardingTransitionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _videoOpacity;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _videoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Initialize video controller
    _videoController = VideoPlayerController.asset('assets/videos/pooch.mp4')
      ..initialize().then((_) {
        if (mounted) {
          // Auto-play and loop the video
          _videoController.play();
          _videoController.setLooping(true);
          // Trigger fade-in animation after a short delay
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted && !_animationController.isAnimating) {
              _animationController.forward();
            }
          });
          setState(() {});
        }
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        context.router.replaceAll([
          SelectPetOptionRoute(
            initialPhoneNumber: widget.initialPhoneNumber,
            initialEmail: widget.initialEmail,
            initialCountryCode: widget.initialCountryCode,
          ),
        ]);
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return AppPrimaryBgContainer(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              SizedBox(height: topPadding + 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: AppText.h4(
                  "Let's Onboard\nYour Pooch!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: AppText.bodyL(
                  'Let us add your babies',
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF232324),
                  ),
                ),
              ),
              const Spacer(),

              Align(
                alignment: Alignment.bottomCenter,
                child: FadeTransition(
                  opacity: _videoOpacity,
                  child: _videoController.value.isInitialized
                      ? SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: VideoPlayer(_videoController),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
