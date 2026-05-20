import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalHistorySyncBloc
    extends Bloc<MedicalHistorySyncEvent, MedicalHistorySyncState> {
  MedicalHistorySyncBloc() : super(const MedicalHistorySyncState()) {
    on<MedicalHistoryRecordAdded>(_onMedicalHistoryRecordAdded);
    on<MedicalHistorySyncCleared>(_onMedicalHistorySyncCleared);
  }

  void _onMedicalHistoryRecordAdded(
    MedicalHistoryRecordAdded event,
    Emitter<MedicalHistorySyncState> emit,
  ) {
    emit(state.copyWith(version: state.version + 1));
  }

  void _onMedicalHistorySyncCleared(
    MedicalHistorySyncCleared event,
    Emitter<MedicalHistorySyncState> emit,
  ) {
    emit(const MedicalHistorySyncState());
  }
}

sealed class MedicalHistorySyncEvent extends Equatable {
  const MedicalHistorySyncEvent();

  @override
  List<Object?> get props => const <Object?>[];
}

class MedicalHistoryRecordAdded extends MedicalHistorySyncEvent {
  const MedicalHistoryRecordAdded();
}

class MedicalHistorySyncCleared extends MedicalHistorySyncEvent {
  const MedicalHistorySyncCleared();
}

class MedicalHistorySyncState extends Equatable {
  const MedicalHistorySyncState({this.version = 0});

  final int version;

  MedicalHistorySyncState copyWith({int? version}) {
    return MedicalHistorySyncState(version: version ?? this.version);
  }

  @override
  List<Object?> get props => <Object?>[version];
}
