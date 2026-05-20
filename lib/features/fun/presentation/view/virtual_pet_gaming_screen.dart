import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';

@RoutePage()
class VirtualPetGamingScreen extends StatefulWidget {
  const VirtualPetGamingScreen({super.key});

  @override
  State<VirtualPetGamingScreen> createState() => _VirtualPetGamingScreenState();
}

class _VirtualPetGamingScreenState extends State<VirtualPetGamingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppPrimaryBgContainer(child: SafeArea(child: Column())),
    );
  }
}
