import 'dart:typed_data';
import 'package:image/image.dart' as image;
import 'package:image/image.dart';

/// Image with detail information.
class ImageDetail<T> {
  ImageDetail({required this.image, required this.width, required this.height});

  final T image;
  final double width;
  final double height;

  late final bool isLandscape = width >= height;
  late final bool isPortrait = width < height;
}

/// Interface for parsing image and build [ImageDetail] from given [data].
typedef ImageParser<T> =
    ImageDetail<T> Function(Uint8List data, {ImageFormat? inputFormat});

/// Implementation of [ImageParser] using image package
/// Parsed image is represented as [image.Image]
ImageDetail<Object?> imageImageParser(
  Uint8List data, {
  image.ImageFormat? inputFormat,
}) {
  late final image.Image? tempImage;
  try {
    tempImage = _decodeWith(data, format: inputFormat);
  } on InvalidInputFormatException {
    rethrow;
  }

  assert(tempImage != null);

  // check orientation
  final parsed = switch (tempImage?.exif.exifIfd.orientation ?? -1) {
    3 => image.copyRotate(tempImage!, angle: 180),
    6 => image.copyRotate(tempImage!, angle: 90),
    8 => image.copyRotate(tempImage!, angle: -90),
    _ => tempImage!,
  };

  return ImageDetail(
    image: parsed,
    width: parsed.width.toDouble(),
    height: parsed.height.toDouble(),
  );
}

image.Image? _decodeWith(Uint8List data, {ImageFormat? format}) {
  try {
    return switch (format) {
      ImageFormat.jpg => image.decodeJpg(data),
      ImageFormat.png => image.decodePng(data),
      ImageFormat.bmp => image.decodeBmp(data),
      ImageFormat.ico => image.decodeIco(data),
      ImageFormat.webp => image.decodeWebP(data),
      _ => image.decodeImage(data),
    };
  } on image.ImageException {
    throw InvalidInputFormatException(format);
  }
}

class InvalidInputFormatException implements Exception {
  final ImageFormat? inputFormat;

  InvalidInputFormatException(this.inputFormat);
}
