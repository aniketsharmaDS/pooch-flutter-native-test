import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class InsightCareScreen extends StatefulWidget {
  const InsightCareScreen({super.key});

  @override
  State<InsightCareScreen> createState() => _InsightCareScreenState();
}

class _InsightCareScreenState extends State<InsightCareScreen> {
  final int itemCount = 200;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Gut Care'));
  }
}
