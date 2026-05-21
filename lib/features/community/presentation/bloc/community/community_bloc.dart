import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/community/community_event.dart';
import 'package:poochcare/features/community/presentation/bloc/community/community_state.dart';
import 'package:poochcare/features/community/repository/community_repository.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityDetailsState> {
  final CommunityRepository repository;

  CommunityBloc(this.repository) : super(const CommunityDetailsState()) {
    on<FetchShareLinkEvent>(_onFetchShareLink);
  }
  Future<void> _onFetchShareLink(
    FetchShareLinkEvent event,
    Emitter<CommunityDetailsState> emit,
  ) async {
    emit(state.copyWith(recordsStatus: CommunityState.loading));

    try {
      final data = await repository.getShareLink(
        contentId: event.contentId,
        contentType: event.contentType,
      );
      emit(
        state.copyWith(
          recordsStatus: CommunityState.success,
          shareLinkResponseData: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          recordsStatus: CommunityState.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
