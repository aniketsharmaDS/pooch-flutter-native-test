import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class AppointmentsTabScreen extends StatefulWidget {
  const AppointmentsTabScreen({super.key});

  @override
  State<AppointmentsTabScreen> createState() => _AppointmentsTabScreenState();
}

class _AppointmentsTabScreenState extends State<AppointmentsTabScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/videos/pooch-v1.mp4')
      ..initialize().then((_) {
        _controller
          ..setLooping(true)
          ..setVolume(0)
          ..play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text('Appointments Tab', style: TextStyle(fontSize: 18)),
          ),

          /// 🎬 Transparent Video Layer
          if (_controller.value.isInitialized)
            Positioned.fill(
              child: IgnorePointer(
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    AppColors.transparent,
                    BlendMode.multiply, // 🔥 removes black background
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
