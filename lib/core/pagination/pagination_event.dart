import 'package:equatable/equatable.dart';

sealed class PaginationEvent extends Equatable {
  const PaginationEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class PaginationInitialRequested extends PaginationEvent {
  const PaginationInitialRequested({this.search, this.filters});

  final String? search;
  final Map<String, dynamic>? filters;

  @override
  List<Object?> get props => <Object?>[search, filters];
}

class PaginationNextPageRequested extends PaginationEvent {
  const PaginationNextPageRequested();
}

class PaginationRefreshRequested extends PaginationEvent {
  const PaginationRefreshRequested();
}
