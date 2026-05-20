import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';

Widget buildDocumentFileIconFromFile(
  File file, {
  double width = 24,
  double height = 32,
  Color? color,
}) {
  return buildDocumentFileIconFromType(
    p.extension(file.path),
    width: width,
    height: height,
    color: color,
  );
}

Widget buildDocumentFileIconFromType(
  String type, {
  double width = 24,
  double height = 32,
  Color? color,
}) {
  final normalizedType = _normalizeType(type);
  final iconPath = _iconPathForType(normalizedType);

  return AppIcon(iconPath, width: width.w, height: height.h, color: color);
}

String _normalizeType(String type) {
  final value = type.trim().toLowerCase();
  if (value.startsWith('.')) {
    return value.substring(1);
  }
  switch (value) {
    case 'application/pdf':
      return 'pdf';
    case 'image/jpeg':
      return 'jpg';
    case 'image/jpg':
      return 'jpg';
    case 'image/png':
      return 'png';
    case 'application/msword':
      return 'doc';
    case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
      return 'docx';
    default:
      return value;
  }
}

String _iconPathForType(String type) {
  if (type == 'pdf') {
    return AppIcons.svg.documentIcons.pdf;
  }

  if (type == 'doc' || type == 'docx') {
    return AppIcons.svg.documentIcons.doc;
  }

  return AppIcons.svg.documentIcons.jpg;
}
