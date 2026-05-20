import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/theme/app_theme.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _page = 0;

  static const List<String> _titles = <String>[
    'Care for your pets',
    'Book services quickly',
    'Connect with pet community',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_page == _titles.length - 1) {
      _completeIntroAndContinue();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _completeIntroAndContinue() async {
    final authStore = context.read<AuthStoreBloc>();
    if (!authStore.state.introCompleted) {
      authStore.add(const IntroCompleted());
      await authStore.stream.firstWhere((state) => state.introCompleted);
      if (!mounted) {
        return;
      }
    }
    context.router.replaceAll([const HomeRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _titles.length,
                  onPageChanged: (int value) {
                    setState(() {
                      _page = value;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: AppText.h1(
                        _titles[index],
                        textAlign: TextAlign.center, // optional
                      ),
                    );
                  },
                ),
              ),
              AppButton(
                label: _page == _titles.length - 1 ? 'Get Started' : 'Next',
                onPressed: _onNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
