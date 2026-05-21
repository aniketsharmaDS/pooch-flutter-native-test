import 'package:flutter/material.dart';

class StateWrapper extends StatelessWidget {
  final bool isLoading;
  final bool isError;
  final bool isEmpty;
  final String title;
  final Widget child;
  final VoidCallback? onRetry;
  final Widget? emptyWidget;

  const StateWrapper({
    super.key,
    required this.isLoading,
    required this.isError,
    required this.isEmpty,
    required this.title,
    required this.child,
    this.onRetry,
    this.emptyWidget,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Handle Error State
    if (isError) {
      return _buildCenteredMessage(
        icon: Icons.error_outline,
        message: 'Something went wrong with your $title.',
        action: onRetry != null
            ? TextButton(onPressed: onRetry, child: const Text('Retry'))
            : null,
      );
    }

    // 2. Handle Empty State
    if (isEmpty && !isLoading) {
      return emptyWidget ??
          _buildCenteredMessage(
            icon: Icons.inbox_outlined,
            message: 'No ${title}s available.',
          );
    }

    // 3. Handle Loading & Success States
    // We use a Stack so the loader appears over the child/shimmer
    // without changing the widget tree's height.
    return isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : child;
  }

  Widget _buildCenteredMessage({
    required IconData icon,
    required String message,
    Widget? action,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            if (action != null) ...[const SizedBox(height: 10), action],
          ],
        ),
      ),
    );
  }
}
