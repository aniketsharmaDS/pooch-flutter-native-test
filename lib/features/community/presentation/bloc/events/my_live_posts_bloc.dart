import 'dart:async';
import 'dart:developer';

import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_bloc.dart';
import 'package:poochcare/core/pagination/pagination_result.dart';
import 'package:poochcare/core/sync/global_update_bus.dart';
import 'package:poochcare/features/community/data/models/my_posts_api_response.dart';
import 'package:poochcare/features/community/data/models/my_submitted_posts_model.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/features/community/repository/community_repository.dart';

class MyLivePostsBlocActions {
  static const likeEvent = 'LiKE_EVENT';
  static const unLikeEvent = 'UNLIKE_EVENT';
}

class MyLivePostsBloc extends PaginationBloc<MySubmittedPostsModel> {
  final CommunityRepository communityRepository;
  late final GlobalUpdateBus<dynamic> _bus;
  // ignore: cancel_subscriptions
  late final StreamSubscription _busSub;
  static const String _source = 'MyLivePostsBloc';
  MyLivePostsBloc({required this.communityRepository})
    : super(
        fetchPage:
            ({
              required int page,
              String? search,
              Map<String, dynamic>? filters,
            }) async {
              log('MyLivePostsBloc filters in EventsBloc fetchPage: $filters');
              final MyPostsApiResponse response = await communityRepository
                  .myAllPosts(page: page, search: search, type: 'live');

              return PaginationResult<MySubmittedPostsModel>(
                items: response.posts,
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
      log(
        '📡 Bus:- MyLivePostsBloc 123 received for ${event.source} event.destination: ${event.destination}',
      );
      if (event.source == _source &&
          !(event.destination?.contains(_source) ?? false)) {
        log('📡 Bus:- MyLivePostsBloc Nothing to update');
        return;
      }
      if (event.data is! MySubmittedPostsModel) return;
      final updatedItem = event.data as MySubmittedPostsModel;
      log(
        '✅ Bus:- MyLivePostsBloc Updating item: ${updatedItem.id} ${updatedItem.title}',
      );
      log(
        '📡 Bus:- MyLivePostsBloc received for ${event.source}: ${updatedItem.id} ${updatedItem.title}',
      );

      if (event.actionType == TipsGuideActions.deleteTip) {
        log(
          '📡 Bus:- MyLivePostsBloc Delete the item as its delete from the live posts: ${updatedItem.id}',
        );
        deleteItem(test: (item) => item.id == updatedItem.id);
        return;
      }

      updateItemEverywhere(
        test: (item) => item.id == updatedItem.id,
        update: (_) => updatedItem,
      );
    });
  }

  /// ✅ VERY IMPORTANT (avoid memory leak)
  @override
  Future<void> close() {
    _busSub.cancel();
    return super.close();
  }

  void fetchInitialPosts({
    String search = '',
    String? categoryId,
    bool? upcoming,
  }) {
    fetchInitial(search: search, filters: _buildFilters(categoryId, upcoming));
  }

  void loadMorePosts() {
    fetchNextPage();
  }

  void refreshPosts() {
    refresh();
  }

  Map<String, dynamic>? _buildFilters(String? categoryId, bool? upcoming) {
    final filters = <String, dynamic>{};

    if (categoryId != null && categoryId.isNotEmpty) {
      filters['categoryId'] = categoryId;
    }

    if (upcoming != null) {
      filters['upcoming'] = upcoming;
    }

    return filters.isEmpty ? null : filters;
  }
}
