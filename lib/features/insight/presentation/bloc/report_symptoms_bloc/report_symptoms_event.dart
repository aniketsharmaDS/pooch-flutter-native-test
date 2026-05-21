import 'package:equatable/equatable.dart';

sealed class ReportSymptomsEvent extends Equatable {
  const ReportSymptomsEvent();

  @override
  List<Object?> get props => [];
}

class FetchSymptomsEvent extends ReportSymptomsEvent {
  const FetchSymptomsEvent();
}
