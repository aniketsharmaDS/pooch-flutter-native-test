import 'package:flutter/material.dart';

class TabNotifier extends StatefulWidget {
  final int activeIndex;
  final Widget child;

  const TabNotifier({
    super.key,
    required this.activeIndex,
    required this.child,
  });

  @override
  State<TabNotifier> createState() => _TabNotifierState();
}

class _TabNotifierState extends State<TabNotifier> {
  @override
  void didUpdateWidget(covariant TabNotifier oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.activeIndex != widget.activeIndex) {
      // Notify subtree via inherited widget rebuild
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabScope(index: widget.activeIndex, child: widget.child);
  }
}

class TabScope extends InheritedWidget {
  final int index;

  const TabScope({super.key, required this.index, required super.child});

  static TabScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TabScope>();
  }

  @override
  bool updateShouldNotify(covariant TabScope oldWidget) {
    return oldWidget.index != index;
  }
}
