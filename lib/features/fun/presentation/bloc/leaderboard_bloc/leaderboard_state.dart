import 'package:equatable/equatable.dart';
import 'package:poochcare/features/fun/data/models/leaderboard_response_model.dart';

enum LeaderBoardStatus { initial, loading, success, failure }

class LeaderboardState extends Equatable {
  final LeaderBoardStatus leaderboardStatus;
  final String? errorMessage;
  final String? successMessage;
  final int currentPage;
  final bool hasReachedMax;
  final LeaderboardResponseModel? leaderboardData;
  final List<LeaderboardUserModel>? leaderboardSortedList;

  const LeaderboardState({
    this.errorMessage = '',
    this.successMessage = '',
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.leaderboardStatus = LeaderBoardStatus.initial,
    this.leaderboardData,
    this.leaderboardSortedList = const [],
  });

  LeaderboardState copyWith({
    LeaderBoardStatus? leaderboardStatus,
    String? errorMessage,
    String? successMessage,
    int? currentPage,
    bool? hasReachedMax,
    LeaderboardResponseModel? leaderboardData,
    List<LeaderboardUserModel>? leaderboardSortedList,
  }) {
    return LeaderboardState(
      leaderboardSortedList:
          leaderboardSortedList ?? this.leaderboardSortedList,
      leaderboardData: leaderboardData ?? this.leaderboardData,
      leaderboardStatus: leaderboardStatus ?? this.leaderboardStatus,
      errorMessage: errorMessage,
      successMessage: successMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    successMessage,
    currentPage,
    hasReachedMax,
    leaderboardStatus,
    leaderboardData,
    leaderboardSortedList,
  ];
}
