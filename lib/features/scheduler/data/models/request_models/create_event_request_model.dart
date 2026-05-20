class CreateEventRequestModel {
  final String petId;
  final String title;
  final String date;
  final String endDate;
  final String time;
  final String eventType;
  final String location;
  final String notes;

  const CreateEventRequestModel({
    required this.petId,
    required this.title,
    required this.date,
    required this.endDate,
    required this.time,
    required this.eventType,
    required this.location,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'petId': petId,
      'title': title,
      'date': date,
      'endDate': endDate,
      'time': time,
      'eventType': eventType,
      'location': location,
      'notes': notes,
    };
  }
}
