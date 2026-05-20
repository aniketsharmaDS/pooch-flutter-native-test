import 'package:equatable/equatable.dart';

sealed class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object?> get props => [];
}

class FetchLeaderboardEvent extends LeaderboardEvent {
  final int? page;
  final bool isForceRefresh;
  const FetchLeaderboardEvent(this.page, this.isForceRefresh);

  @override
  List<Object?> get props => [page, isForceRefresh];
}
