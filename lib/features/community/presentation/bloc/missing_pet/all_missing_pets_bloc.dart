import 'dart:developer';

import 'package:poochcare/core/pagination/pagination_bloc.dart';
import 'package:poochcare/core/pagination/pagination_result.dart';
import 'package:poochcare/features/community/data/models/missing_pet_api_response.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/repository/missing_pet_repository.dart';

class MyEventActions {
  static const likeEvent = 'LiKE_EVENT';
  static const unLikeEvent = 'UNLIKE_EVENT';
  static const rsvp = 'RSVP';
  static const leaveEvent = 'LEAVE_EVENT';
}

class AllMissingPetsBloc extends PaginationBloc<MissingPetModel> {
  final MissingPetRepository repository;
  AllMissingPetsBloc({required this.repository})
    : super(
        fetchPage:
            ({
              required int page,
              String? search,
              Map<String, dynamic>? filters,
            }) async {
              log('filters 1 in All Missing PetsBloc fetchPage: $filters');
              final MissingPetApiResponse response = await repository
                  .getAllMissingPets(
                    page: page,
                    search: search,
                    filters: filters,
                  );
              log(
                'filters 2 in All Missing PetsBloc fetchPage: ${response.missingPets.length} items',
              );
              return PaginationResult<MissingPetModel>(
                items: response.missingPets,
                currentPage: response.pagination.currentPage,
                hasMore: response.pagination.hasMore,
                totalPages: response.pagination.totalPages,
                totalItems: response.pagination.totalItems,
              );
            },
      );

  void fetchInitialMissingPets({
    String search = '',
    String? petType,
    String? petGender,
  }) {
    fetchInitial(search: search, filters: _buildFilters(petType, petGender));
  }

  void loadMoreMissingPets() {
    fetchNextPage();
  }

  void refreshMissingPets() {
    refresh();
  }

  Map<String, dynamic>? _buildFilters(String? petType, String? petGender) {
    final filters = <String, dynamic>{};

    if (petType != null && petType.isNotEmpty) {
      filters['petType'] = petType;
    }

    if (petGender != null && petGender.isNotEmpty) {
      filters['petGender'] = petGender;
    }

    return filters.isEmpty ? null : filters;
  }
}
