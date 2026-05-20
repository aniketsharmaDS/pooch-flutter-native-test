import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/fun/data/models/leaderboard_response_model.dart';
import 'package:poochcare/features/fun/presentation/bloc/leaderboard_bloc/leaderboard_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/leaderboard_bloc/leaderboard_state.dart';
import 'package:poochcare/features/fun/repository/accessories_repository.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final AccessoriesRepository repository;

  LeaderboardBloc(this.repository) : super(const LeaderboardState()) {
    on<FetchLeaderboardEvent>(_onFetchLeaderboar);
  }
  FutureOr<void> _onFetchLeaderboar(
    FetchLeaderboardEvent event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(state.copyWith(leaderboardStatus: LeaderBoardStatus.loading));
    final leaderBoardData = await repository.getLeaderboard();
    List<LeaderboardUserModel> leaderboardSortedData = List.from(
      leaderBoardData.leaderboard,
    );
    leaderboardSortedData.removeWhere(
      (element) => element.name.trim().isEmpty && (element.phone ?? '').isEmpty,
    );
    leaderboardSortedData.sort((a, b) => a.rank.compareTo(b.rank));
    emit(
      state.copyWith(
        leaderboardStatus: LeaderBoardStatus.success,
        leaderboardData: leaderBoardData,
        leaderboardSortedList: leaderboardSortedData,
      ),
    );

    try {} catch (e) {
      emit(
        state.copyWith(
          leaderboardStatus: LeaderBoardStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
