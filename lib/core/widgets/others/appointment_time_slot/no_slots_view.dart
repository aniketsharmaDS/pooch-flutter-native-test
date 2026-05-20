import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class NoSlotsView extends StatelessWidget {
  const NoSlotsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: AppText.bodyM('No slots available for this day.'));
  }
}
