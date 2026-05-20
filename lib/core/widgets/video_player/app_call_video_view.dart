import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppCallVideoView extends StatelessWidget {
  final VideoPlayerController controller;

  final BorderRadius? borderRadius;

  final BoxFit fit;

  final Widget? overlay;

  const AppCallVideoView({
    super.key,
    required this.controller,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.overlay,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ///
          /// VIDEO
          ///
          if (controller.value.isInitialized)
            FittedBox(
              fit: fit,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            )
          else
            const Center(child: CircularProgressIndicator(color: Colors.white)),

          ///
          /// DARK OVERLAY
          ///
          Container(color: Colors.black.withValues(alpha: 0.08)),

          ///
          /// CUSTOM OVERLAY
          ///
          // ignore: use_null_aware_elements
          if (overlay != null) overlay!,
        ],
      ),
    );
  }
}
