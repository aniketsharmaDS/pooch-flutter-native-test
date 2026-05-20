import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/transitions/presentation/widgets/collage_item.dart';

@RoutePage()
class EcommerceTransitionScreen extends StatefulWidget {
  const EcommerceTransitionScreen({super.key});

  @override
  State<EcommerceTransitionScreen> createState() =>
      _EcommerceTransitionScreenState();
}

class _EcommerceTransitionScreenState extends State<EcommerceTransitionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        context.router.pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: AppPrimaryBgContainer(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: topPadding + 8),
                SizedBox(
                  height: size.height * 0.68,
                  child: Stack(
                    children: [
                      CollageItem(
                        imagePath: AppIcons.png.transitions.puppy,
                        circleSize: AppSize.cs96,
                        imageSize: AppSize.cs120,
                        backgroundColor: const Color(0xFFD2ECD0),
                        alignment: const Alignment(0, -0.9),
                        imageAlignment: const Alignment(0.4, -0.9),
                        // circleAlignment: const Alignment(0.6, -0.1),
                        imageOffset: const Offset(0.6, -10),
                        imagePositionOffset: const Offset(-3, -8),
                      ),

                      CollageItem(
                        imagePath: AppIcons.png.transitions.huskyDog,
                        backgroundColor: const Color(0xFFA5C6FB),
                        circleSize: 142,
                        imageSize: 200,
                        alignment: const Alignment(-1, -0.25),
                        imageAlignment: const Alignment(-0.5, -0.5),
                        imagePositionOffset: const Offset(-3, -20),
                        circleAlignment: const Alignment(0.2, 0.5),
                        imageOffset: const Offset(-4, -15),
                        delay: const Duration(milliseconds: 120),
                      ),

                      CollageItem(
                        imagePath: AppIcons.png.transitions.gingerCat,
                        circleSize: 117,
                        imageSize: 138,
                        backgroundColor: const Color(0xFFFEC326),
                        alignment: const Alignment(0.9, -0.5),
                        imageAlignment: const Alignment(0.7, -0.25),
                        imagePositionOffset: const Offset(2, -12),
                        circleAlignment: const Alignment(0.3, 0.6),
                        imageOffset: const Offset(0, -16),
                        delay: const Duration(milliseconds: 240),
                      ),

                      CollageItem(
                        imagePath: AppIcons.png.transitions.berneseDog,
                        circleSize: 180,
                        imageSize: 230,
                        backgroundColor: const Color(0xFFF28A07),
                        alignment: const Alignment(0.75, 0.3),
                        imageOffset: const Offset(2, -24),
                        imageAlignment: const Alignment(2, 0.3),
                        circleAlignment: const Alignment(-0.3, 0.2),
                        delay: const Duration(milliseconds: 360),
                      ),

                      CollageItem(
                        imagePath: AppIcons.png.transitions.pubDog,
                        circleSize: 130,
                        imageSize: 150,
                        circleAlignment: const Alignment(0.4, -0.1),
                        imageAlignment: const Alignment(0.6, 0.7),
                        imagePositionOffset: const Offset(4, 10),
                        backgroundColor: const Color(0xFFF8C5B6),
                        alignment: const Alignment(-0.8, 0.7),
                        imageOffset: const Offset(-4, -10),
                        delay: const Duration(milliseconds: 480),
                      ),

                      CollageItem(
                        imagePath: AppIcons.png.transitions.orangeCat,
                        circleSize: 100,
                        imageSize: 130,
                        circleAlignment: const Alignment(0.5, 0.1),
                        imageAlignment: const Alignment(0.5, 0.6),
                        imagePositionOffset: const Offset(0, 8),
                        backgroundColor: const Color(0xFFD6A78C),
                        alignment: const Alignment(0.4, 0.98),
                        imageOffset: const Offset(-2, 12),
                        delay: const Duration(milliseconds: 600),
                      ),
                    ],
                  ),
                ),
                AppSpacing.s20.hBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppText.h4(
                    'Pooches\nYou\'ll Love',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF131313),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: AppText.bodyL(
                    'Curated companions ready for\ntheir forever families.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
