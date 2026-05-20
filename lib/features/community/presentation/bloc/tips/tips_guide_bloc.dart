import 'dart:async';
import 'dart:developer';

import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/core/pagination/pagination_bloc.dart';
import 'package:poochcare/core/pagination/pagination_result.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/sync/global_update_bus.dart';
import 'package:poochcare/features/community/data/mappers/tips_guide_to_submitted_post_mapper.dart';
import 'package:poochcare/features/community/data/models/tips_api_response.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';
import 'package:poochcare/features/community/repository/tips_and_guide_repository.dart';

class TipsGuideActions {
  static const createTip = 'CREATE_TIPS_GUIDE';
  static const deleteTip = 'DELETE_TIPS_GUIDE';
  static const updateTip = 'UPDATE_TIPS_GUIDE';
  static const likeEvent = 'LIKE_TIPS_GUIDE';
  static const unLikeEvent = 'UNLIKE_TIPS_GUIDE';
}

enum TipsGuideType {
  allTipsGuides,
  allLatestTipsGuides,
  allMyTipsGuides,
  allMyUpcomingTipsGuides,
}

class TipsGuideBloc extends PaginationBloc<TipsInfoItemModel> {
  final TipsAndGuideRepository repository;
  late final GlobalUpdateBus<dynamic> _bus;
  late final StreamSubscription _busSub;
  static const String _source = 'TipsGuideBloc';
  TipsGuideBloc({required this.repository})
    : super(
        fetchPage:
            ({
              required int page,
              String? search,
              Map<String, dynamic>? filters,
            }) async {
              log('filters in TipsGuideBloc fetchPage: $filters');

              final TipsApiResponse response;
              log(
                'TipsGuideBloc filters in fetchPage before condition: ${filters?['type']},\nTipsGuideType.allMyTipsGuide.name: ${TipsGuideType.allMyTipsGuides.name},\nTipsGuideType.allMyUpcomingTipsGuide.name: ${TipsGuideType.allMyUpcomingTipsGuides.name}',
              );

              if (filters?['type'] == TipsGuideType.allMyTipsGuides.name ||
                  filters?['type'] ==
                      TipsGuideType.allMyUpcomingTipsGuides.name) {
                response = await repository.fetchMyTipsAndGuides(
                  page: page,
                  search: search,
                  categoryId: filters?['categoryId'] as String?,
                );
              } else {
                response = await repository.fetchAllTipsAndGuides(
                  page: page,
                  search: search,
                  categoryId: filters?['categoryId'] as String?,
                );
              }

              return PaginationResult<TipsInfoItemModel>(
                items: response.tips,
                currentPage: response.pagination.currentPage,
                hasMore: response.pagination.hasMore,
                totalPages: response.pagination.totalPages,
                totalItems: response.pagination.totalItems,
              );
            },
      ) {
    /// ✅ 👇 (constructor body)
    _bus = getIt<GlobalUpdateBus<dynamic>>();
    _busSub = _bus.stream.listen((event) {
      log('📡 Bus:- EventsBloc received for ${event.source}');
      if (event.source == _source) return;
      final updatedItem = event.data;
      log(
        '📡 Bus:- EventsBloc received for ${event.source}: ${updatedItem.id}',
      );

      // updateItemEverywhere(
      //   test: (item) => item.id == event.id,
      //   update: (_) => event,
      //   fallbackItem: event,
      // );
    });
  }

  /// ✅ VERY IMPORTANT (avoid memory leak)
  @override
  Future<void> close() {
    _busSub.cancel();
    return super.close();
  }

  void fetchInitialTips({
    required TipsGuideType type,
    String? userId, // 👈 A
    String search = '',
    String? categoryId,
  }) {
    log('filters in TipsGuideBloc type: $type');
    String scope;
    if (type == TipsGuideType.allTipsGuides) {
      scope = buildScope(type: type, categoryId: categoryId);
    } else {
      scope = buildScope(type: type);
    }
    log('filters in TipsGuideBloc scope: $scope');
    final filters = _buildFilters(categoryId, type);

    fetchInitial(
      search: search,
      filters: {
        ...?filters,
        'scope': scope, // 👈 ADD THIS
      },
    );
  }

  String buildScope({
    required TipsGuideType type,
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

  void loadMoreTips() {
    fetchNextPage();
  }

  void refreshTips() {
    refresh();
  }

  Map<String, dynamic>? _buildFilters(String? categoryId, TipsGuideType type) {
    final filters = <String, dynamic>{};

    if (categoryId != null && categoryId.isNotEmpty && categoryId != 'all') {
      filters['categoryId'] = categoryId;
    }

    // future conditions can be added like this
    // if (somethingElse != null) {
    //   filters['somethingElse'] = somethingElse;
    // }

    filters['type'] = type.name;

    return filters.isEmpty ? null : filters;
  }

  Future<void> toggleTipsLike({
    required String tipsId,
    required bool targetIsLiked,
  }) async {
    log('Toggling like for tipsId: $tipsId, targetIsLiked: $targetIsLiked');
    startProcessing(
      tipsId,
      targetIsLiked ? TipsGuideActions.likeEvent : TipsGuideActions.unLikeEvent,
    );

    final prevItems = state.items;
    final prevSelectedItem = state.selectedItem;

    /// 1. Optimistic update (instant UI using shared updater)
    updateItemEverywhere(
      test: (item) => item.id == tipsId,
      update: (item) {
        final nextCount = targetIsLiked
            ? item.likesCount + 1
            : (item.likesCount - 1).clamp(0, 1000000);

        return item.copyWith(isLiked: targetIsLiked, likesCount: nextCount);
      },
    );

    try {
      /// 2. API call
      final ApiResponse result = await repository.toggleTipsLike(
        tipsId: tipsId,
        isLiked: targetIsLiked,
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        rollbackFailedEverywhere(
          items: prevItems,
          selectedItem: prevSelectedItem,
        );
        return;
      } else {
        TipsInfoItemModel tipsInfoItemModel = TipsInfoItemModelMapper.fromMap(
          result.data['tip'] as Map<String, dynamic>,
        );
        log('Tips info from toggleEventLike API: ${tipsInfoItemModel.toMap()}');
        final bool isLikedFromApi = tipsInfoItemModel.isLiked;
        final int likesCountFromApi = tipsInfoItemModel.likesCount;
        updateItemEverywhere(
          test: (item) => item.id == tipsId,
          update: (item) => item.copyWith(
            isLiked: isLikedFromApi,
            likesCount: likesCountFromApi,
          ),
        );

        final post = tipsInfoItemModel.toSubmittedPost();

        _bus.emit(
          data: post,
          source: _source,
          destination: [
            'MyLivePostsBloc',
            'MyReviewPostsBloc',
          ], // 👈 OPTIONAL, can be used for targeted updates
        );

        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      log('Error toggling like for tipsId: $tipsId, error: $e');

      /// 4. Rollback if API fails
      rollbackFailedEverywhere(
        items: prevItems,
        selectedItem: prevSelectedItem,
      );
    } finally {
      // ✅ STOP LOADING
      stopProcessing(
        tipsId,
        targetIsLiked
            ? TipsGuideActions.likeEvent
            : TipsGuideActions.unLikeEvent,
      );
    }
  }

  Future<void> fetchTipsDetails(String tipsId, {bool isRefresh = false}) async {
    try {
      /// 1. Get existing item (instant UI)
      final existingItem = state.items.any((e) => e.id == tipsId)
          ? state.items.firstWhere((e) => e.id == tipsId)
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
      final tip = await repository.gettipsDetails(tipsId: tipsId);

      /// ✅ IMPORTANT: handle null properly
      if (tip == null) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(isDetailLoading: false, isDetailRefreshing: false));
        return;
      }

      /// 4. Update BOTH list + detail (single source of truth)
      updateItemEverywhere(
        test: (e) => e.id == tipsId,
        update: (_) => tip,
        fallbackItem: tip,
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

  Future<void> createTipGuide({
    required String categoryId,
    required String title,
    required String description,
    required bool isDraft,
    List<dynamic>? attachmentUrls,
  }) async {
    log('Creating tip/guide with categoryId: $categoryId');
    try {
      /// 2. API call
      final ApiResponse result = await repository.createTip(
        categoryId: categoryId,
        title: title,
        description: description,
        isDraft: isDraft,
        attachmentUrls: attachmentUrls,
      );
      log(
        'Create tip/guide API response: success=${result.success}, message=${result.message}, data=${result.data}',
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        if (result.data is Map<String, dynamic>) {
          // ignore: unused_local_variable
          final TipsInfoItemModel tipsInfoItemModel =
              TipsInfoItemModelMapper.fromMap(
                result.data as Map<String, dynamic>,
              );
          insertItem(
            item: tipsInfoItemModel,
            select: true, // 👈 makes it selected immediately
          );
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

  Future<void> updateTipGuide({
    required String tipId,
    required String categoryId,
    required String title,
    required String description,
    required bool isDraft,
    List<dynamic>? attachmentUrls,
  }) async {
    log('Updating tip/guide with categoryId: $categoryId');
    try {
      /// 2. API call
      final ApiResponse result = await repository.updateTip(
        tipId: tipId,
        categoryId: categoryId,
        title: title,
        description: description,
        isDraft: isDraft,
        attachmentUrls: attachmentUrls,
      );
      log(
        'Update tip/guide API response: success=${result.success}, message=${result.message}, data=${result.data}',
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        if (result.data is Map<String, dynamic>) {
          // ignore: unused_local_variable
          final TipsInfoItemModel tipsInfoItemModel =
              TipsInfoItemModelMapper.fromMap(
                result.data as Map<String, dynamic>,
              );

          updateItemEverywhere(
            test: (e) => e.id == tipId,
            update: (_) => tipsInfoItemModel,
          );

          final post = tipsInfoItemModel.toSubmittedPost();

          _bus.emit(
            data: post,
            source: _source,
            actionType: TipsGuideActions.deleteTip,
            destination: [
              'MyLivePostsBloc',
            ], // 👈 OPTIONAL, can be used for targeted updates
          );

          _bus.emit(
            data: post,
            source: _source,
            actionType: isDraft
                ? TipsGuideActions.deleteTip
                : TipsGuideActions.updateTip,
            destination: [
              'MyReviewPostsBloc',
            ], // 👈 OPTIONAL, can be used for targeted updates
          );

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

  Future<void> deleteTip({required String tipId}) async {
    log('Deleting tip with ID: $tipId');
    try {
      /// 2. API call
      final ApiResponse result = await repository.deleteTip(tipId: tipId);
      log(
        'Delete tip API response: success=${result.success}, message=${result.message}, data=${result.data}',
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        final TipsInfoItemModel tipsInfoItemModel = TipsInfoItemModel(
          id: tipId,
        );
        //  To Delete the tip from live and review and current block.
        final post = tipsInfoItemModel.toSubmittedPost();

        _bus.emit(
          data: post,
          source: _source,
          actionType: TipsGuideActions.deleteTip,
          destination: [
            'MyLivePostsBloc',
            'MyReviewPostsBloc',
          ], // 👈 OPTIONAL, can be used for targeted updates
        );
        deleteItem(test: (e) => e.id == tipId);
        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      // CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }

  Future<void> reportTips({
    required String tipId,
    required String reason,
  }) async {
    log('Reporting tip with ID: $tipId');
    try {
      /// 2. API call
      final ApiResponse result = await repository.reportTip(
        tipId: tipId,
        reason: reason,
      );
      log(
        'Report tip API response: success=${result.success}, message=${result.message}, data=${result.data}',
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      // CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }
}
