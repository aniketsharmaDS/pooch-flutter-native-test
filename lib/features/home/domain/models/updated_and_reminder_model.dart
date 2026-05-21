import 'package:poochcare/features/home/data/models/updates_and_reminders_response.dart';

class UpdatedAndReminderModel {
  final String id;
  final String title;
  final String date;
  final String time;
  final String type;
  final String viewType;
  final DateTime dateTime;
  final String? petName;
  final String? oldTime;
  final String? image;
  final String? message;

  const UpdatedAndReminderModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.type,
    required this.viewType,
    required this.dateTime,
    this.petName,
    this.oldTime,
    this.image,
    this.message,
  });

  factory UpdatedAndReminderModel.fromApi(UpdateReminderItem item) {
    final DateTime parsedDate = _parseDateTime(item.date, item.time);

    return UpdatedAndReminderModel(
      id: item.id,
      title: item.title.trim().isEmpty ? 'Update' : item.title,
      date: item.date,
      time: item.time,
      type: item.type,
      viewType: item.viewType,
      dateTime: parsedDate,
      petName: item.raw.petName,
      oldTime: item.raw.date.toString(),
      image: item.raw.profilePicture,
      message: item.raw.title,
    );
  }

  static DateTime _parseDateTime(String date, String time) {
    final trimmedDate = date.trim();
    final trimmedTime = time.trim();

    final parsedDate = DateTime.tryParse(trimmedDate);
    if (parsedDate != null) {
      return parsedDate.toLocal();
    }

    final parsedCombined = DateTime.tryParse('$trimmedDate $trimmedTime');
    if (parsedCombined != null) {
      return parsedCombined.toLocal();
    }

    return DateTime.now();
  }

}
