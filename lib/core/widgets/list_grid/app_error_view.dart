import 'package:flutter/material.dart';

class AppErrorView extends StatelessWidget {
  final String title;
  final String? message;
  final IconData icon;
  final String retryText;
  final VoidCallback onRetry;

  const AppErrorView({
    super.key,
    this.title = 'Something went wrong',
    this.message,
    this.icon = Icons.error_outline,
    this.retryText = 'Retry',
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: Colors.red.shade300),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B1B1B),
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Color(0xFF6C6C6C)),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: Text(retryText)),
          ],
        ),
      ),
    );
  }
}
