import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';

class AppIcon extends StatelessWidget {
  final String path;
  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  const AppIcon(
    this.path, {
    super.key,
    this.size,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  bool get _isSvg => path.toLowerCase().endsWith('.svg');

  bool get _isNetwork =>
      path.startsWith('http://') || path.startsWith('https://');

  double? get _width => width ?? size;
  double? get _height => height ?? size;

  @override
  Widget build(BuildContext context) {
    /// =============================
    /// SVG HANDLING
    /// =============================
    if (_isSvg) {
      if (_isNetwork) {
        return SvgPicture.network(
          path,
          width: _width,
          height: _height,
          fit: fit,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
          placeholderBuilder: (context) => _placeholder(),
        );
      } else {
        return SvgPicture.asset(
          path,
          width: _width,
          height: _height,
          fit: fit,
          colorFilter: color != null
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
        );
      }
    }
    log('_isNetwork-->$_isNetwork');

    /// =============================
    /// IMAGE HANDLING
    /// =============================
    if (_isNetwork) {
      final uri = Uri.parse(path);
      return CachedNetworkImage(
        imageUrl: path,
        cacheKey: '${uri.host}${uri.path}',
        width: _width,
        height: _height,
        fit: fit,
        color: color,

        /// While loading
        placeholder: (context, url) => _placeholder(),

        /// On error
        errorWidget: (context, url, error) => _errorWidget(),

        /// Optional fade animation (nice UX)
        fadeInDuration: const Duration(milliseconds: 200),
      );
    }

    /// =============================
    /// ASSET IMAGE
    /// =============================

    return Image.asset(
      path,
      width: _width,
      height: _height,
      fit: fit,
      color: color,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) {
        return _errorWidget(); // your custom widget
      },
    );
  }

  /// =============================
  /// PLACEHOLDER
  /// =============================
  Widget _placeholder() {
    return SizedBox(
      width: _width,
      height: _height,
      child: const Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  /// =============================
  /// ERROR WIDGET
  /// =============================
  Widget _errorWidget() {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        color: const Color(0xFFF6F0E6),
        child: Center(
          child: AppIcon(
            AppIcons.svg.generic.poochLogo,
            width: AppSize.cs18,
            height: AppSize.cs18,
          ),
        ),
      ),
    );
  }
}
