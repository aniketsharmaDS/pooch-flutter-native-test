class UpdatedAndReminderModel {
  final String petName;
  final String title;
  final String time;
  final String? oldTime;
  final String image;
  final String? message;
  final String type;

  const UpdatedAndReminderModel({
    required this.petName,
    required this.title,
    required this.time,
    this.oldTime,
    required this.image,
    this.message,
    required this.type,
  });
}
