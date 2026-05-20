import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class NameScrollerItem {
  const NameScrollerItem({required this.id, required this.name});

  final String id;
  final String name;
}

class NameScroller extends StatefulWidget {
  const NameScroller({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onSelected,
  });

  final List<NameScrollerItem> items;
  final String? selectedId;
  final ValueChanged<NameScrollerItem> onSelected;

  @override
  State<NameScroller> createState() => _NameScrollerState();
}

class _NameScrollerState extends State<NameScroller> {
  final ScrollController _scrollController = ScrollController();

  late List<NameScrollerItem> _items;

  bool _sameItems(List<NameScrollerItem> a, List<NameScrollerItem> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
      if (a[i].name != b[i].name) return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _items = List<NameScrollerItem>.from(widget.items);
  }

  @override
  void didUpdateWidget(covariant NameScroller oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameItems(oldWidget.items, widget.items)) {
      _items = List<NameScrollerItem>.from(widget.items);
    }
  }

  void onTapItem(int index) {
    setState(() {
      final selectedItem = _items[index];
      _items.removeAt(index);
      _items.insert(0, selectedItem);
    });

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );

    widget.onSelected(_items.first);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.s42.h,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          final bool isSelected =
              (widget.selectedId != null && item.id == widget.selectedId) ||
              (widget.selectedId == null && index == 0);
          return GestureDetector(
            onTap: () => onTapItem(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 0 : AppSpacing.s10.w,
              ),
              alignment: Alignment.bottomCenter,
              child: isSelected
                  ? ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.65,
                      ),
                      child: AppText.displayL(
                        item.name,
                        maxLines: 1,
                        color: const Color(0xffDFA015),
                        style: TextStyle(fontSize: AppFontSize.fs42),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.s4,
                      ),
                      child: AppText.h1(
                        item.name,
                        fontSize: AppFontSize.fs14,
                        color: const Color(0xffD7BC97),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
