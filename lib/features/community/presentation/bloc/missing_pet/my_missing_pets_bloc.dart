import 'dart:developer';

import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/core/pagination/pagination_bloc.dart';
import 'package:poochcare/core/pagination/pagination_result.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/features/community/data/models/missing_pet_api_response.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/domain/models/missing_pet_report_payload_model.dart';
import 'package:poochcare/features/community/repository/missing_pet_repository.dart';

class MyEventActions {
  static const likeEvent = 'LiKE_EVENT';
  static const unLikeEvent = 'UNLIKE_EVENT';
  static const rsvp = 'RSVP';
  static const leaveEvent = 'LEAVE_EVENT';
}

class MyMissingPetsBloc extends PaginationBloc<MissingPetModel> {
  final MissingPetRepository repository;
  MyMissingPetsBloc({required this.repository})
    : super(
        fetchPage:
            ({
              required int page,
              String? search,
              Map<String, dynamic>? filters,
            }) async {
              log('filters 1 in My Missing PetBloc fetchPage: $filters');
              final MissingPetApiResponse response = await repository
                  .getMyMissingPets(
                    page: page,
                    search: search,
                    filters: filters,
                  );
              log(
                'filters 2 in My Missing PetBloc fetchPage: ${response.missingPets.length} items',
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
    String? petId,
    bool? upcoming,
  }) {
    fetchInitial(search: search, filters: _buildFilters(petId, upcoming));
  }

  void loadMoreMissingPets() {
    fetchNextPage();
  }

  void refreshMissingPets() {
    refresh();
  }

  Map<String, dynamic>? _buildFilters(String? petId, bool? upcoming) {
    final filters = <String, dynamic>{};

    if (petId != null && petId.isNotEmpty) {
      filters['petId'] = petId;
    }

    if (upcoming != null) {
      filters['upcoming'] = upcoming;
    }

    return filters.isEmpty ? null : filters;
  }

  Future<void> reprortMissingPet({
    required MissingPetReportPayloadModel payload,
  }) async {
    log('Creating tip/guide with petId: $payload.petId');
    try {
      /// 2. API call
      final ApiResponse result = await repository.reprortMissingPet(
        payload: payload,
      );
      log(
        'Create event API response: success=${result.success}, message=${result.message}, data=${result.data}',
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        if (result.data is Map<String, dynamic>) {
          // ignore: unused_local_variable
          // final EventInfoItemModel eventInfoItemModel =
          //     EventInfoItemModelMapper.fromMap(
          //       result.data as Map<String, dynamic>,
          //     );
          // insertItem(
          //   item: eventInfoItemModel,
          //   select: true, // 👈 makes it selected immediately
          // );
          CustomSnackbar.show(result.message, SnackbarType.success);
        } else {
          CustomSnackbar.show('Invalid response format', SnackbarType.error);
          throw Exception('Invalid response format');
        }
      }
    } catch (e) {
      // CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }

  Future<void> fetchMissingReportDetails(
    String reportId, {
    bool isRefresh = false,
  }) async {
    try {
      /// 1. Get existing item (instant UI)
      final existingItem = state.items.any((e) => e.id == reportId)
          ? state.items.firstWhere((e) => e.id == reportId)
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

      /// 3. API call
      final report = await repository.getMissingReportDetails(
        reportId: reportId,
      );
      log('missing report details from API: $report');

      /// ✅ IMPORTANT: handle null properly
      if (report == null) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(isDetailLoading: false, isDetailRefreshing: false));
        return;
      }

      /// 4. Update BOTH list + detail (single source of truth)
      updateItemEverywhere(
        test: (e) => e.id == reportId,
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

  Future<void> reportMissingPetFound({
    required Map<String, dynamic> payload,
  }) async {
    log('Creating tip/guide with petId: $payload.petId');
    try {
      /// 2. API call
      final ApiResponse result = await repository.reportMissingPetFound(
        payload: payload,
      );
      log(
        'Create event API response: success=${result.success}, message=${result.message}, data=${result.data}',
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        if (result.data is Map<String, dynamic>) {
          // ignore: unused_local_variable
          // final EventInfoItemModel eventInfoItemModel =
          //     EventInfoItemModelMapper.fromMap(
          //       result.data as Map<String, dynamic>,
          //     );
          // insertItem(
          //   item: eventInfoItemModel,
          //   select: true, // 👈 makes it selected immediately
          // );
          CustomSnackbar.show(result.message, SnackbarType.success);
        } else {
          CustomSnackbar.show('Invalid response format', SnackbarType.error);
          throw Exception('Invalid response format');
        }
      }
    } catch (e) {
      CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }
}
