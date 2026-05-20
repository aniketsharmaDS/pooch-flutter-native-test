import 'package:flutter/material.dart';
import 'package:poochcare/core/services/loader_service.dart';
import 'package:poochcare/core/widgets/app_loader.dart';
import 'package:provider/provider.dart';

/// Place this widget above MaterialApp or at the root of your app.
/// It listens to LoaderService and displays the loader globally.
class GlobalLoaderOverlay extends StatelessWidget {
  final Widget child;
  const GlobalLoaderOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoaderService>.value(
      value: LoaderService.instance,
      child: Stack(
        children: [
          child,
          Consumer<LoaderService>(
            builder:
                (BuildContext context, LoaderService loader, Widget? child) {
                  if (!loader.isLoading) return const SizedBox.shrink();
                  return AppLoader(child: loader.customLoader);
                },
          ),
        ],
      ),
    );
  }
}
