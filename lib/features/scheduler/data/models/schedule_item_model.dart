import 'package:poochcare/core/utils/parser_utils.dart';

class ScheduleItemModel {
  final String type;

  final String id;

  final String title;

  final String time;

  final String notes;

  final String petId;

  final String petName;

  final String petType;

  final String petGender;

  final String taskCategory;

  final String repeatType;

  final String eventType;

  final String location;

  final String latitude;

  final String longitude;

  final String addressDetails;

  final String endDate;

  final String source;

  final bool isMultiDay;

  const ScheduleItemModel({
    required this.type,
    required this.id,
    required this.title,
    required this.time,
    required this.notes,
    required this.petId,
    required this.petName,
    required this.petType,
    required this.petGender,
    required this.taskCategory,
    required this.repeatType,
    required this.eventType,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.addressDetails,
    required this.endDate,
    required this.source,
    required this.isMultiDay,
  });

  factory ScheduleItemModel.fromMap(Map<String, dynamic> map) {
    return ScheduleItemModel(
      type: ParserUtils.readString(map['type']),

      id: ParserUtils.readString(map['id']),

      title: ParserUtils.readString(map['title']),

      time: ParserUtils.readString(map['time']),

      notes: ParserUtils.readString(map['notes']),

      petId: ParserUtils.readString(map['petId']),

      petName: ParserUtils.readString(map['petName']),

      petType: ParserUtils.readString(map['petType']),

      petGender: ParserUtils.readString(map['petGender']),

      taskCategory: ParserUtils.readString(map['taskCategory']),

      repeatType: ParserUtils.readString(map['repeatType']),

      eventType: ParserUtils.readString(map['eventType']),

      location: ParserUtils.readString(map['location']),

      latitude: ParserUtils.readString(map['latitude']),

      longitude: ParserUtils.readString(map['longitude']),

      addressDetails: ParserUtils.readString(map['addressDetails']),

      endDate: ParserUtils.readString(map['endDate']),

      source: ParserUtils.readString(map['source']),

      isMultiDay: ParserUtils.readBool(map['isMultiDay']),
    );
  }
}
