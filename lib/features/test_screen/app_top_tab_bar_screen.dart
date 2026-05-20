import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/tabs/app_top_tab_bar.dart';
import 'package:poochcare/features/test_screen/app_button_screen.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class AppTopTabBarScreen extends StatefulWidget {
  const AppTopTabBarScreen({super.key});

  @override
  State<AppTopTabBarScreen> createState() => _AppTopTabBarScreenState();
}

class _AppTopTabBarScreenState extends State<AppTopTabBarScreen> {
  /// =============================
  /// UI
  /// =============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEAE0),
      appBar: AppBar(title: const Text('App Top Tab Bar')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: AppTopTabBar(
            leftTitle: 'List View',
            rightTitle: 'Grid View',
            leftScreen: AppButtonScreen(),
            rightScreen: AppButtonScreen(),
          ),
        ),
      ),
    );
  }
}
