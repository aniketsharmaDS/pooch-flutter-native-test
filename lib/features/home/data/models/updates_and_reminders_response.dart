import 'package:poochcare/core/utils/safe_parser_service.dart';

class UpdatesAndRemindersResponse {
  final bool success;
  final String message;
  final int status;
  final List<UpdateReminderItem> data;

  UpdatesAndRemindersResponse({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  factory UpdatesAndRemindersResponse.fromJson(Map<String, dynamic> json) {
    return UpdatesAndRemindersResponse(
      success: SafeParserService.parseBool(json['success']),
      message: SafeParserService.parseString(json['message']),
      status: SafeParserService.parseInt(json['status']),
      data: SafeParserService.parseList(
        json['data'],
        fromJson: (item) =>
            UpdateReminderItem.fromJson(SafeParserService.parseMap(item)),
      ),
    );
  }
}

class UpdateReminderItem {
  final String id;
  final String title;
  final String date;
  final String time;
  final String type;
  final String viewType;
  final PetEventModel raw;

  UpdateReminderItem({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.type,
    required this.viewType,
    required this.raw,
  });

  factory UpdateReminderItem.fromJson(Map<String, dynamic> json) {
    return UpdateReminderItem(
      id: SafeParserService.parseString(json['id']),
      title: SafeParserService.parseString(json['title']),
      date: SafeParserService.parseString(json['date']),
      time: SafeParserService.parseString(json['time']),
      type: SafeParserService.parseString(json['type']),
      viewType: SafeParserService.parseString(json['viewType']),
      raw: PetEventModel.fromJson(SafeParserService.parseMap(json['raw'])),
    );
  }
}

class PetEventModel {
  final String id;
  final String petId;
  final String petName;
  final String title;
  final DateTime? date; // Parsed to a proper DateTime object
  final String
  timeString; // Kept as raw String "16:21:00" for layout flexibility
  final String location;
  final String notes;
  final int daysUntil;
  final String viewType;
  final String profilePicture;

  PetEventModel({
    required this.id,
    required this.petId,
    required this.petName,
    required this.title,
    this.date,
    required this.timeString,
    required this.location,
    required this.notes,
    required this.daysUntil,
    required this.viewType,
    required this.profilePicture,
  });

  factory PetEventModel.fromJson(Map<String, dynamic> json) {
    return PetEventModel(
      profilePicture: SafeParserService.parseString(json['petProfileImage']),
      id: SafeParserService.parseString(json['id']),
      petId: SafeParserService.parseString(json['petId']),
      petName: SafeParserService.parseString(json['petName']),
      title: SafeParserService.parseString(json['title']),
      date: SafeParserService.parseDateTime(json['date']),
      timeString: SafeParserService.parseString(json['time']),
      location: SafeParserService.parseString(json['location']),
      notes: SafeParserService.parseString(json['notes']),
      daysUntil: SafeParserService.parseInt(json['daysUntil']),
      viewType: SafeParserService.parseString(json['viewType']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'petId': petId,
      'petName': petName,
      'title': title,
      'date': date?.toIso8601String().substring(
        0,
        10,
      ), // Keeps "YYYY-MM-DD" format
      'time': timeString,
      'location': location,
      'notes': notes,
      'daysUntil': daysUntil,
      'viewType': viewType,
    };
  }
}
