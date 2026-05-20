import 'package:equatable/equatable.dart';

sealed class SaveHouseDetailsEvent extends Equatable {
  const SaveHouseDetailsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class SaveHouseDetailsStarted extends SaveHouseDetailsEvent {
  const SaveHouseDetailsStarted();
}

class SaveHouseDetailsSubmitted extends SaveHouseDetailsEvent {
  const SaveHouseDetailsSubmitted({
    required this.parentName,
    required this.houseName,
    required this.relation,
    required this.isMultiplePets,
  });

  final String parentName;
  final String houseName;
  final String relation;
  final bool isMultiplePets;

  @override
  List<Object?> get props => <Object?>[
    parentName,
    houseName,
    relation,
    isMultiplePets,
  ];
}
