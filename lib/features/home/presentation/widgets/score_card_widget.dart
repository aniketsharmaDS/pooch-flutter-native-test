import 'dart:math';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/cards/app_glass_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ScoreCardWidget extends StatelessWidget {
  final double score;
  final String title;
  final String subtitle;

  const ScoreCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.54, // Adjust as needed for desired width-to-height ratio
      child: LayoutBuilder(
        builder: (context, constraints) {
          final circleSize = AppRadiusSize
              .r60
              .rr; // circle diameter based on width (can adjust as needed)
          return AppGlassCard(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(
                    horizontal: AppSpacing.s22.w,
                    vertical: AppSpacing.s12.h,
                  ).copyWith(
                    left: AppSpacing.s12.w,
                  ), // extra right padding for circle
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Left Text
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.h3(
                        title,
                        fontSize: AppFontSize.fs14,
                        color: const Color(0xFF302D31),
                        style: TextStyle(
                          height: AppSize.cs16.csh / AppFontSize.fs14,
                        ),
                      ),
                      AppText.tabLabel(
                        subtitle,
                        fontSize: AppFontSize.fs14,
                        color: const Color(0xFF302D31),
                        style: TextStyle(
                          height: AppSize.cs16.csh / AppFontSize.fs14,
                        ),
                      ),
                    ],
                  ),

                  /// Right Circle
                  SizedBox(
                    width: circleSize,
                    height: circleSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: Size(circleSize, circleSize),
                          painter: _ArcPainter(percentage: score),
                        ),
                        AppText.buttonL(
                          '${score.toInt()}%',
                          fontSize: AppFontSize.fs13,
                          color: const Color(0xFFFF8918),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double percentage;

  _ArcPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.28;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    /// Background circle
    final backgroundPaint = Paint()
      ..color = const Color(0xFFFBEEE1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, 2 * pi, false, backgroundPaint);

    /// Arc sweep (UNCHANGED)
    // final sweepAngle = (percentage / 100) * 2 * pi * 0.75;

    final sweepAngle = (percentage / 100) * 2 * pi;

    /// ✅ Linear gradient (NO wrapping issue)
    final gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFF8917), Color(0xFFFFD677)],
    );

    final foregroundPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    /// Foreground arc
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}

// class _ArcPainter1 extends CustomPainter {
//   final double percentage;

//   _ArcPainter1({required this.percentage});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final strokeWidth = size.width * 0.12;

//     final backgroundPaint = Paint()
//       ..color = const Color(0xFFE6D8C9)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;

//     final foregroundPaint = Paint()
//       ..color = Colors.orange
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;

//     final rect = Rect.fromLTWH(0, 0, size.width, size.height);

//     canvas.drawArc(rect, 0, 2 * pi, false, backgroundPaint);

//     final sweepAngle = (percentage / 100) * 2 * pi * 0.75;

//     canvas.drawArc(rect, -pi / 2, sweepAngle, false, foregroundPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

/**

How to Use (Dynamic Layout)
✔️ Case 1: 2 cards in a row
Row(
  children: const [
    Expanded(child: ScoreCardWidget(score: 45)),
    SizedBox(width: 12),
    Expanded(child: ScoreCardWidget(score: 75)),
  ],
)

✔️ Case 2: 1 card full width
const ScoreCardWidget(score: 85)

✔️ Case 3: Grid (best for scaling)
GridView.count(
  crossAxisCount: 2,
  shrinkWrap: true,
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
  physics: NeverScrollableScrollPhysics(),
  children: const [
    ScoreCardWidget(score: 45),
    ScoreCardWidget(score: 75),
  ],
)

*/
