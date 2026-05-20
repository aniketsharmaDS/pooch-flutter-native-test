import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/features/intro_transition/data/intro_transition_data.dart';
import 'package:poochcare/features/intro_transition/data/models/intro_transition_model.dart';
import 'package:poochcare/features/intro_transition/presentation/view/intro_transition_content_screen.dart';
import 'package:poochcare/features/intro_transition/presentation/widgets/bottom_navigation_persistent.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class IntroTransitionScreen extends StatefulWidget {
  const IntroTransitionScreen({super.key});

  @override
  State<IntroTransitionScreen> createState() => _IntroTransitionScreenState();
}

class _IntroTransitionScreenState extends State<IntroTransitionScreen> {
  late final PageController _pageController;
  List<IntroTransitionModel> get screens => getIntroTransitionScreen();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    _pageController = PageController();

    _updateStatusBar(0); // 👈 first screen color
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateStatusBar(int index) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // adjust if needed
      ),
    );
  }

  void _onNext() {
    if (_currentIndex < screens.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
      return;
    }

    context.read<AuthStoreBloc>().add(const IntroCompleted());
    final bool isAuthenticated = context
        .read<AuthStoreBloc>()
        .state
        .isAuthenticated;

    final PageRouteInfo route = isAuthenticated
        ? const HomeRoute()
        : const RegisterRoute();

    context.router.replaceAll(<PageRouteInfo<dynamic>>[route]);
  }

  void _onSkip() {
    _pageController.animateToPage(
      screens.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentIndex == screens.length - 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: PageView.builder(
              controller: _pageController,
              physics: const PageScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _updateStatusBar(index);
              },
              itemCount: screens.length,
              itemBuilder: (context, index) {
                final data = screens[index];
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: IntroTransitionContent(
                    key: ValueKey(index),
                    data: data,
                    onSkip: _onSkip,
                    isActive: index == _currentIndex,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationPersistent(
                isLast: isLast,
                onNext: _onNext,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
