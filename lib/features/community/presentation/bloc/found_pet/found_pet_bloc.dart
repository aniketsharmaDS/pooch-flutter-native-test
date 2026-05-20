import 'dart:async';
import 'dart:developer';

import 'package:poochcare/core/pagination/pagination_bloc.dart';
import 'package:poochcare/core/pagination/pagination_result.dart';
import 'package:poochcare/features/community/data/models/found_pet_api_response.dart';
import 'package:poochcare/features/community/data/models/found_pet_model.dart';
import 'package:poochcare/features/community/repository/found_pet_repository.dart';

class FoundPetActions {
  static const likePost = 'LiKE_POST';
  static const unLikePost = 'UNLIKE_POST';
}

enum FoundPetScopeType {
  allLatelyFoundPets,
  allFoundPets,
  allMyLatelyFoundPets,
  allMyFoundPets,
}

class FoundPetBloc extends PaginationBloc<FoundPetModel> {
  final FoundPetRepository repository;
  // late final GlobalUpdateBus<dynamic> _bus;
  // late final StreamSubscription _busSub;
  // static const String _source = 'FoundPetBloc';

  FoundPetBloc({required this.repository})
    : super(
        fetchPage:
            ({
              required int page,
              String? search,
              Map<String, dynamic>? filters,
            }) async {
              log('filters in FoundPetBloc fetchPage: $filters');

              final FoundPetApiResponse response;

              log(
                'FoundPetBloc filters in fetchPage before condition: ${filters?['scopeType']},\nFoundPetScopeType.allMyLatelyFoundPets.name: ${FoundPetScopeType.allMyLatelyFoundPets.name},\nFoundPetScopeType.allMyFoundPets.name: ${FoundPetScopeType.allMyFoundPets.name}',
              );

              final apiFilters = Map<String, dynamic>.from(filters ?? {})
                ..remove('scopeType')
                ..remove('scope');

              if (filters?['scopeType'] ==
                      FoundPetScopeType.allMyLatelyFoundPets.name ||
                  filters?['scopeType'] ==
                      FoundPetScopeType.allMyFoundPets.name) {
                response = await repository.getMyFoundPets(
                  page: page,
                  search: search,
                  filters: apiFilters,
                );
              } else {
                response = await repository.getAllFoundPets(
                  page: page,
                  search: search,
                  filters: apiFilters,
                );
              }

              return PaginationResult<FoundPetModel>(
                items: response.foundPets,
                currentPage: response.pagination.currentPage,
                hasMore: response.pagination.hasMore,
                totalPages: response.pagination.totalPages,
                totalItems: response.pagination.totalItems,
              );
            },
      ) {
    /// ✅ 👇 (constructor body)
    // _bus = getIt<GlobalUpdateBus<dynamic>>();
    // _busSub = _bus.stream.listen((event) {
    //   log('📡 Bus:- EventsBloc received for ${event.source}');
    //   if (event.source == _source) return;
    //   final updatedItem = event.data;
    //   log(
    //     '📡 Bus:- EventsBloc received for ${event.source}: ${updatedItem.id}',
    //   );
  }

  // /// ✅ VERY IMPORTANT (avoid memory leak)
  // @override
  // Future<void> close() {
  //   _busSub.cancel();
  //   return super.close();
  // }

  void fetchInitialFoundPets({
    required FoundPetScopeType scopeType,
    String? scopePetType,
    String? petType,
    String? petId,
    String search = '',
  }) {
    final scope = buildScope(scopeType: scopeType, type: scopePetType);
    log('fetchInitialFoundPets called with scope: $scope');
    final filters = _buildFilters(petType, scopeType, petId);

    fetchInitial(
      search: search,
      filters: {
        ...?filters,
        'scope': scope, // 👈 ADD THIS
      },
    );
  }

  void loadMoreFoundPets() {
    fetchNextPage();
  }

  void refreshFoundPets() {
    refresh();
  }

  Map<String, dynamic>? _buildFilters(
    String? petType,
    FoundPetScopeType scopeType,
    String? petId,
  ) {
    final filters = <String, dynamic>{};

    if (petType != null && petType.isNotEmpty) {
      filters['petType'] = petType;
    }

    if (petId != null && petId.isNotEmpty) {
      filters['petId'] = petId;
    }

    filters['scopeType'] = scopeType.name; // 'all' or 'myEvents'

    return filters.isEmpty ? null : filters;
  }

  String buildScope({
    required FoundPetScopeType scopeType,
    String? userId,
    String? categoryId,
    bool? upcoming,
    String? search,
    String? type,
  }) {
    return [
      scopeType.name,
      if (userId != null) 'user:$userId',
      if (categoryId != null) 'cat:$categoryId',
      if (upcoming != null) 'upcoming:$upcoming',
      if (search != null && search.isNotEmpty) 'q:$search',
      if (type != null && type.isNotEmpty) 'type:$type',
    ].join('|');
  }

  Future<void> fetchDetails(String eventId, {bool isRefresh = false}) async {
    try {
      /// 1. Get existing item (instant UI)
      final existingItem = state.items.any((e) => e.id == eventId)
          ? state.items.firstWhere((e) => e.id == eventId)
          : null;

      /// 2. Set loading state
      // ignore: invalid_use_of_visible_for_testing_member
      emit(
        state.copyWith(
          selectedItem: existingItem ?? state.selectedItem,
          isDetailLoading: !isRefresh && existingItem == null,
          isDetailRefreshing: isRefresh,
          clearDetailError: true,
        ),
      );

      // / 3. API call
      final report = await repository.getFoundReportDetails(reportId: eventId);
      log('Event details from API: $report');

      /// ✅ IMPORTANT: handle null properly
      if (report == null) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(isDetailLoading: false, isDetailRefreshing: false));
        return;
      }

      /// 4. Update BOTH list + detail (single source of truth)
      updateItemEverywhere(
        test: (e) => e.id == eventId,
        update: (_) => report,
        fallbackItem: report,
      );

      /// 5. Stop loaders
      // ignore: invalid_use_of_visible_for_testing_member
      emit(state.copyWith(isDetailLoading: false, isDetailRefreshing: false));
    } catch (e) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(
        state.copyWith(
          isDetailLoading: false,
          isDetailRefreshing: false,
          detailError: e.toString(),
        ),
      );
    }
  }
}
