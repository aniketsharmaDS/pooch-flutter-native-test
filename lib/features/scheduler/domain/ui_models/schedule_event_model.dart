import 'package:flutter/material.dart';

class ScheduleEventModel {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;

  const ScheduleEventModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.color,
  });
}
