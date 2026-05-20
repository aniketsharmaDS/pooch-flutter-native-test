import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';

class PoochWillBeHomeSoonBottom extends StatelessWidget {
  final VoidCallback? onContinuePressed;

  const PoochWillBeHomeSoonBottom({super.key, this.onContinuePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [AppButton(label: 'Continue', onPressed: onContinuePressed)],
    );
  }
}
