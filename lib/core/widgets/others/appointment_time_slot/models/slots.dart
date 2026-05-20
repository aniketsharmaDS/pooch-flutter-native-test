import 'package:flutter/material.dart';

class Slots {
  final bool isAvailable;
  final VoidCallback onTap;
  final String slotTime;
  final bool isSelected;

  Slots({
    required this.isAvailable,
    required this.onTap,
    required this.slotTime,
    this.isSelected = false,
  });
}
