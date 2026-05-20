import 'package:flutter/material.dart';

class ScheduleItemUIModel {
  final String id;

  final String type;

  final String title;

  final String time;

  final String date;

  final DateTime startDateTime;

  final String petId;

  final String petName;

  final String petType;

  final String petGender;

  final String taskCategory;

  final String eventType;

  final String notes;

  final String location;

  final String endDate;

  final bool isMultiDay;

  final String formattedTime;

  final Color indicatorColor;

  const ScheduleItemUIModel({
    required this.id,
    required this.type,
    required this.title,
    required this.time,
    required this.date,
    required this.startDateTime,
    required this.petId,
    required this.petName,
    required this.petType,
    required this.petGender,
    required this.taskCategory,
    required this.eventType,
    required this.notes,
    required this.location,
    required this.endDate,
    required this.isMultiDay,
    required this.formattedTime,
    required this.indicatorColor,
  });
}
