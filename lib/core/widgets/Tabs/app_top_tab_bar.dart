import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppTopTabBar extends StatefulWidget {
  const AppTopTabBar({
    super.key,
    required this.leftTitle,
    required this.rightTitle,
    required this.leftScreen,
    required this.rightScreen,
    this.initialIndex = 0,
    this.selectedIndex,
    this.onTabChanged,
    this.child,
  }) : assert(initialIndex == 0 || initialIndex == 1);

  final String leftTitle;
  final String rightTitle;
  final Widget leftScreen;
  final Widget rightScreen;
  final int initialIndex;
  final int? selectedIndex;
  final ValueChanged<int>? onTabChanged;
  final Widget? child;

  @override
  State<AppTopTabBar> createState() => _AppTopTabBarState();
}

class _AppTopTabBarState extends State<AppTopTabBar> {
  static const double _tabHeight = 60;
  static const Duration _tabDuration = Duration(milliseconds: 320);
  static const Duration _screenDuration = Duration(milliseconds: 260);

  late int _selectedIndex;
  int _lastIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? widget.initialIndex;
    _lastIndex = _selectedIndex;
  }

  @override
  void didUpdateWidget(covariant AppTopTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != null &&
        widget.selectedIndex != _selectedIndex) {
      _lastIndex = _selectedIndex;
      _selectedIndex = widget.selectedIndex!;
    }
  }

  void _onTabTap(int index) {
    final int effectiveIndex = widget.selectedIndex ?? _selectedIndex;
    if (effectiveIndex == index) {
      return;
    }

    if (widget.selectedIndex == null) {
      setState(() {
        _lastIndex = _selectedIndex;
        _selectedIndex = index;
      });
    }
    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final int effectiveIndex = widget.selectedIndex ?? _selectedIndex;
    final List<Widget> screens = [widget.leftScreen, widget.rightScreen];

    return Column(
      children: [
        _AnimatedTabHeader(
          height: _tabHeight,
          selectedIndex: effectiveIndex,
          leftTitle: widget.leftTitle,
          rightTitle: widget.rightTitle,
          onTap: _onTabTap,
        ),
        Expanded(
          child:
              widget.child ??
              AnimatedSwitcher(
                duration: _screenDuration,
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final bool movingForward = effectiveIndex > _lastIndex;
                  final Animation<Offset> slideAnimation = Tween<Offset>(
                    begin: Offset(movingForward ? 0.08 : -0.08, 0),
                    end: Offset.zero,
                  ).animate(animation);

                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: child,
                    ),
                  );
                },
                child: KeyedSubtree(
                  key: ValueKey<int>(effectiveIndex),
                  child: screens[effectiveIndex],
                ),
              ),
        ),
      ],
    );
  }
}

class _AnimatedTabHeader extends StatelessWidget {
  const _AnimatedTabHeader({
    required this.height,
    required this.selectedIndex,
    required this.leftTitle,
    required this.rightTitle,
    required this.onTap,
  });

  final double height;
  final int selectedIndex;
  final String leftTitle;
  final String rightTitle;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double segmentWidth = constraints.maxWidth / 2;

          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _TabBackgroundPainter(
                    color: const Color(0xFFFFF9E9),
                    radius: 16,
                    selectedIndex: selectedIndex,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: _AppTopTabBarState._tabDuration,
                curve: Curves.easeInOutCubic,
                left: selectedIndex == 0 ? 0 : segmentWidth,
                top: 0,
                width: segmentWidth,
                height: height,
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: TabShapePainter(
                      color: const Color(0xFFF2EDDD),
                      isLeft: selectedIndex == 0,
                      isSelected: true,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: _TabLabel(
                        title: leftTitle,
                        selected: selectedIndex == 0,
                        onTap: () => onTap(0),
                      ),
                    ),
                    Expanded(
                      child: _TabLabel(
                        title: rightTitle,
                        selected: selectedIndex == 1,
                        onTap: () => onTap(1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: selected
                ? AppText.h3(
                    title,
                    color: const Color(0xFF320E02),
                    fontSize: 16.sp,
                  )
                : AppText.h4(
                    title,
                    color: const Color(0xFF320E02),
                    fontSize: 16.sp,
                  ),
            // child: Text(
            //   title,
            //   overflow: TextOverflow.ellipsis,
            //   maxLines: 1,
            //   style: TextStyle(
            //     fontWeight: FontWeight.w400,
            //     // fontFamily: selected == false ? "Gilroy500" : "Gilroy700",
            //     fontSize: 16,
            //     color: const Color(0xFF320E02),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}

class _TabBackgroundPainter extends CustomPainter {
  const _TabBackgroundPainter({
    required this.color,
    required this.radius,
    required this.selectedIndex,
  });

  final Color color;
  final double radius;
  final int selectedIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Radius rounded = Radius.circular(radius);
    final Radius zero = Radius.zero;

    final RRect bg = RRect.fromRectAndCorners(
      Offset.zero & size,
      topLeft: rounded,
      topRight: rounded,
      bottomLeft: selectedIndex == 1 ? zero : rounded,
      bottomRight: selectedIndex == 0 ? zero : rounded,
    );
    canvas.drawRRect(bg, paint);
  }

  @override
  bool shouldRepaint(covariant _TabBackgroundPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.selectedIndex != selectedIndex;
  }
}

class TabShapePainter extends CustomPainter {
  static const Color _shadowColor = Color(0x0D000000);

  final Color color;
  final bool isLeft;
  final bool isSelected;

  TabShapePainter({
    required this.color,
    required this.isLeft,
    required this.isSelected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    const double r = 20.0;

    if (isLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, r);
      path.quadraticBezierTo(0, 0, r, 0);
      path.lineTo(size.width - r, 0);
      path.quadraticBezierTo(size.width, 0, size.width, r);
      path.lineTo(size.width, size.height - r);
      path.quadraticBezierTo(
        size.width,
        size.height,
        size.width + r,
        size.height,
      );

      path.lineTo(0, size.height);
      path.close();
    } else {
      path.moveTo(size.width, size.height);
      path.lineTo(size.width, r);
      path.quadraticBezierTo(size.width, 0, size.width - r, 0);
      path.lineTo(r, 0);
      path.quadraticBezierTo(0, 0, 0, r);
      path.lineTo(0, size.height - r);
      path.quadraticBezierTo(0, size.height, -r, size.height);
      path.lineTo(size.width, size.height);
      path.close();
    }

    if (isSelected) {
      canvas.drawShadow(
        path.shift(const Offset(0, -1)),
        _shadowColor,
        3.0,
        true,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TabShapePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.isLeft != isLeft ||
        oldDelegate.isSelected != isSelected;
  }
}
