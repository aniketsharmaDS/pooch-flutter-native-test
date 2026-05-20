import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';

/// =============================
/// MODEL
/// =============================
class AppPopupMenuItem {
  final String? title;
  final Widget? titleWidget;
  final VoidCallback onTap;
  final Widget? icon;

  const AppPopupMenuItem({
    this.title,
    this.titleWidget,
    required this.onTap,
    this.icon,
  });
}

/// =============================
/// APP POPUP MENU
/// =============================
class AppPopupMenu extends StatefulWidget {
  final Widget? child;
  final String? headerTitle;
  final String? iconPath;

  final List<AppPopupMenuItem> items;
  final bool showCloseIcon;
  final VoidCallback? onClose;
  final AppCircleButtonSize size;
  final double? iconSize;
  final AppCircleButtonVariant variant;
  final EdgeInsetsGeometry? padding;
  final Color? iconColor;

  const AppPopupMenu({
    super.key,
    // required this.child,
    required this.items,
    this.headerTitle,
    this.showCloseIcon = false,
    this.onClose,
    this.size = AppCircleButtonSize.regular,
    this.variant = AppCircleButtonVariant.secondary,
    this.iconPath,
    this.iconSize,
    this.padding,
    this.iconColor,
    this.child,
  });

  @override
  State<AppPopupMenu> createState() => _AppPopupMenuState();
}

class _AppPopupMenuState extends State<AppPopupMenu>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;

  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  final FocusNode _focusNode = FocusNode();
  final GlobalKey _menuKey = GlobalKey();

  int _focusedIndex = 0;

  static const double _minWidth = 140;
  static const double _maxWidth = 220;
  static const double _maxHeight = 300;
  static const double _screenPadding = 12;

  double _left = 0;
  double _top = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 160),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween(begin: 0.95, end: 1.0).animate(_fade);
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_overlayEntry != null) {
      _hide();
    } else {
      _show();
    }
  }

  /// =============================
  /// SHOW MENU
  /// =============================
  void _show() {
    if (widget.items.isEmpty) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final overlayBox = overlay.context.findRenderObject() as RenderBox;

    final triggerSize = renderBox.size;
    final triggerOffset = renderBox.localToGlobal(
      Offset.zero,
      ancestor: overlayBox,
    );

    final screenWidth = overlayBox.size.width;
    final screenHeight = overlayBox.size.height;

    /// Estimate height
    final estimatedHeight =
        (widget.items.length * 44.0) + (widget.headerTitle != null ? 50 : 0);

    /// Vertical positioning
    final spaceBelow = screenHeight - (triggerOffset.dy + triggerSize.height);
    final spaceAbove = triggerOffset.dy;

    if (spaceBelow >= estimatedHeight) {
      _top = triggerOffset.dy + triggerSize.height + 6;
    } else if (spaceAbove >= estimatedHeight) {
      _top = triggerOffset.dy - estimatedHeight - 6;
    } else {
      _top = (screenHeight - estimatedHeight) / 2;
    }

    /// Horizontal positioning
    _left = triggerOffset.dx;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            /// Tap outside
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  widget.onClose?.call(); // ✅ notify parent
                  _hide();
                },
                behavior: HitTestBehavior.translucent,
              ),
            ),

            /// Menu
            Positioned(left: _left, top: _top, child: _buildMenu()),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    _controller.forward(from: 0);

    /// Post layout fix (width + boundaries)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _menuKey.currentContext;
      if (ctx == null) return;

      final box = ctx.findRenderObject() as RenderBox;
      final menuSize = box.size;

      double newLeft = triggerOffset.dx;
      double newTop = _top;

      /// Horizontal fix
      if (newLeft + menuSize.width > screenWidth - _screenPadding) {
        newLeft = triggerOffset.dx + triggerSize.width - menuSize.width;
      }

      if (newLeft < _screenPadding) {
        newLeft = _screenPadding;
      }

      /// Vertical fix
      if (newTop + menuSize.height > screenHeight - _screenPadding) {
        newTop = screenHeight - menuSize.height - _screenPadding;
      }

      if (newTop < _screenPadding) {
        newTop = _screenPadding;
      }

      if (newLeft != _left || newTop != _top) {
        _left = newLeft;
        _top = newTop;
        _overlayEntry?.markNeedsBuild();
      }
    });

    /// Keyboard focus
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) _focusNode.requestFocus();
    });
  }

  Future<void> _hide() async {
    await _controller.reverse();
    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// =============================
  /// KEYBOARD NAVIGATION
  /// =============================
  void _handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _focusedIndex = (_focusedIndex + 1) % widget.items.length;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _focusedIndex =
            (_focusedIndex - 1 + widget.items.length) % widget.items.length;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.enter) {
      widget.items[_focusedIndex].onTap();
      _hide();
    } else if (event.logicalKey == LogicalKeyboardKey.escape) {
      _hide();
    }
  }

  /// =============================
  /// MENU UI
  /// =============================
  Widget _buildMenu() {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        alignment: Alignment.topLeft,
        child: Material(
          key: _menuKey,
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: IntrinsicWidth(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: _minWidth,
                  maxWidth: _maxWidth,
                  maxHeight: _maxHeight,
                ),
                child: KeyboardListener(
                  focusNode: _focusNode,
                  onKeyEvent: _handleKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// HEADER
                        if (widget.headerTitle != null) ...[
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.headerTitle!,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (widget.showCloseIcon)
                                InkResponse(
                                  onTap: () {
                                    widget.onClose?.call(); // ✅ notify parent
                                    _hide();
                                  },
                                  radius: 18,
                                  child: const Icon(Icons.close),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],

                        /// ITEMS
                        for (int i = 0; i < widget.items.length; i++) ...[
                          _menuItem(widget.items[i]),
                          if (i != widget.items.length - 1)
                            const Divider(height: 10, color: Color(0xFFECECEC)),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(AppPopupMenuItem item) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          item.onTap();
          _hide();
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          child: Row(
            children: [
              if (item.icon != null) ...[
                IconTheme(
                  data: IconThemeData(
                    size: 20,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                  ),
                  child: item.icon!,
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child:
                    item.titleWidget ??
                    Text(
                      item.title ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =============================
  /// TRIGGER
  /// =============================
  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return GestureDetector(
        onTap: _toggle,
        behavior: HitTestBehavior.opaque,
        child: widget.child,
      );
    }
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: AppCircleButton(
        variant: widget.variant,
        size: widget.size,
        showShadow: false,
        icon: widget.iconPath ?? AppIcons.svg.generic.filter,
        onTap: _toggle,
        iconColor: widget.iconColor ?? const Color(0xFF2D2D2E),
        iconSize: widget.iconSize,
      ),
    );
  }
}
