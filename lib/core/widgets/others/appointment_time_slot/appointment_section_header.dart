import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppointmentSectionHeader extends StatelessWidget {
  final String title;
  final String timing;
  final String iconPath;
  const AppointmentSectionHeader({
    super.key,
    required this.title,
    required this.timing,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xffFFF9E9),
          child: SvgPicture.asset(iconPath),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.h4(title, color: const Color(0xff6B5210)),
            AppText.bodyS(timing, color: const Color(0xff6B5210)),
          ],
        ),
      ],
    );
  }
}
