class CreateReminderRequestModel {
  final String petId;

  final String title;

  final String date;

  final String time;

  final String taskCategory;

  final String notes;

  const CreateReminderRequestModel({
    required this.petId,
    required this.title,
    required this.date,
    required this.time,
    required this.taskCategory,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'petId': petId,
      'title': title,
      'date': date,
      'time': time,
      'taskCategory': taskCategory,
      'notes': notes,
    };
  }
}
