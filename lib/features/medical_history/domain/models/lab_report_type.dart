import 'package:equatable/equatable.dart';

class LabReportType extends Equatable {
  const LabReportType({
    required this.code,
    required this.name,
    required this.species,
  });

  final String code;
  final String name;
  final String species;

  @override
  List<Object?> get props => <Object?>[code, name, species];
}
