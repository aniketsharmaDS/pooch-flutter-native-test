import 'dart:developer';
import 'package:poochcare/core/pagination/pagination_bloc.dart';
import 'package:poochcare/core/pagination/pagination_result.dart';
import 'package:poochcare/features/community/data/models/pet_shelter_api_response.dart';
import 'package:poochcare/features/community/data/models/pet_shelter_model.dart';
import 'package:poochcare/features/community/repository/community_repository.dart';

enum PetShelterBlocType { allPetShelters }

class PetShelterBloc extends PaginationBloc<PetShelterModel> {
  final CommunityRepository repository;

  PetShelterBloc({required this.repository})
    : super(
        fetchPage:
            ({
              required int page,
              String? search,
              Map<String, dynamic>? filters,
            }) async {
              log('filters in EventsBloc fetchPage: $filters');

              final PetShelterApiResponse response;

              response = await repository.fetchAllShelters(
                page: page,
                search: search,
                latitude: filters?['latitude'] as double?,
                longitude: filters?['longitude'] as double?,
              );

              return PaginationResult<PetShelterModel>(
                items: response.shelters,
                currentPage: response.pagination.currentPage,
                hasMore: response.pagination.hasMore,
                totalPages: response.pagination.totalPages,
                totalItems: response.pagination.totalItems,
              );
            },
      );

  void fetchInitialEvents({
    required PetShelterBlocType type,
    double? lattitude,
    double? longitude,
  }) {
    final scope = buildScope(type: type);

    final filters = _buildFilters(type, lattitude, longitude);

    fetchInitial(
      search: '',
      filters: {
        ...?filters,
        'scope': scope, // 👈 ADD THIS
      },
    );
  }

  void loadMoreEvents() {
    fetchNextPage();
  }

  void refreshEvents() {
    refresh();
  }

  Map<String, dynamic>? _buildFilters(
    PetShelterBlocType type,
    double? lattitude,
    double? longitude,
  ) {
    final filters = <String, dynamic>{};

    if (lattitude != null && longitude != null) {
      filters['latitude'] = lattitude;
      filters['longitude'] = longitude;
    }

    return filters.isEmpty ? null : filters;
  }

  String buildScope({
    required PetShelterBlocType type,
    String? userId,
    String? categoryId,
    bool? upcoming,
    String? search,
  }) {
    return [
      type.name,
      if (userId != null) 'user:$userId',
      if (categoryId != null) 'cat:$categoryId',
      if (upcoming != null) 'upcoming:$upcoming',
      if (search != null && search.isNotEmpty) 'q:$search',
    ].join('|');
  }
}
