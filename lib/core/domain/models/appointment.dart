import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.petId,
    required this.service,
    required this.dateLabel,
  });

  final String id;
  final String petId;
  final String service;
  final String dateLabel;

  Appointment copyWith({
    String? id,
    String? petId,
    String? service,
    String? dateLabel,
  }) {
    return Appointment(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      service: service ?? this.service,
      dateLabel: dateLabel ?? this.dateLabel,
    );
  }

  @override
  List<Object?> get props => <Object?>[id, petId, service, dateLabel];
}
