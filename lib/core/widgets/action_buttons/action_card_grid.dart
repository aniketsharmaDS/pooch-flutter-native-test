import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

/// ---------------- MODEL ----------------
class ActionCardItem {
  final String title;
  final String iconPath;
  final VoidCallback? onTap;

  const ActionCardItem({
    required this.title,
    required this.iconPath,
    this.onTap,
  });
}

/// ---------------- GRID ----------------
class ActionCardGrid extends StatelessWidget {
  final List<ActionCardItem> items;
  final int crossAxisCount;
  final double spacing;

  const ActionCardGrid({
    super.key,
    required this.items,
    this.crossAxisCount = 3,
    this.spacing = 6,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.s16.w,
        AppSpacing.s15.h,
        AppSpacing.s17.w,
        AppSpacing.s10.h,
      ),
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing.w,
        mainAxisSpacing: spacing.h,
        // childAspectRatio: 1, // perfect square
      ),
      itemBuilder: (context, index) {
        return _ActionCardWidget(item: items[index]);
      },
    );
  }
}

/// ---------------- CARD UI ----------------
class _ActionCardWidget extends StatefulWidget {
  final ActionCardItem item;

  const _ActionCardWidget({required this.item});

  @override
  State<_ActionCardWidget> createState() => _ActionCardWidgetState();
}

class _ActionCardWidgetState extends State<_ActionCardWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 140),
      scale: isPressed ? 0.97 : 1,
      child: InkWell(
        onTap: widget.item.onTap,
        onHighlightChanged: (value) {
          setState(() => isPressed = value);
        },
        borderRadius: BorderRadius.circular(AppRadiusSize.r10.rr),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFEFD),
            borderRadius: BorderRadius.circular(AppRadiusSize.r10.rr),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: AppRadiusSize.r8.rr,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSize.cs10.csw),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcon(widget.item.iconPath, size: AppIconSize.is36.ir),
                SizedBox(height: AppSpacing.s8.h),
                Flexible(
                  child: AppText.h4(
                    widget.item.title,
                    color: const Color(0xFF320E02),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
