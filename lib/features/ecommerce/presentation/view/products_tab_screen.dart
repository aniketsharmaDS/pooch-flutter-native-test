import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

@RoutePage()
class ProductsTabScreen extends StatelessWidget {
  const ProductsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: AppText.bodyS('Explore Screen')),
    );
  }
}
