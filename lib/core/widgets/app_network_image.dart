import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    required this.imageUrl,
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit,
        loadingBuilder:
            (BuildContext context, Widget child, ImageChunkEvent? progress) {
              if (progress == null) {
                return child;
              }
              return const SizedBox(
                height: 60,
                width: 60,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
              return Container(
                height: height,
                width: width,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                alignment: Alignment.center,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              );
            },
      ),
    );
  }
}
