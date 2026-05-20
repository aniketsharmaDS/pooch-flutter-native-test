import 'dart:async';
import 'dart:developer';

import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/network/api_response.dart';
import 'package:poochcare/core/pagination/pagination_bloc.dart';
import 'package:poochcare/core/pagination/pagination_result.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/sync/global_update_bus.dart';
import 'package:poochcare/features/community/data/models/tips_comment_api_response.dart';
import 'package:poochcare/features/community/data/models/tips_comment_info_model.dart';
import 'package:poochcare/features/community/repository/tips_and_guide_repository.dart';

class TipsCommentActions {
  static const createComment = 'CREATE_CoMMENT';
  static const deleteComment = 'DELETE_COMMENT';
}

enum TipsCommentScopeType { allComments }

enum MessageStatus { posting, posted, pending, failed, deleting }

class TipsCommentBloc extends PaginationBloc<TipsCommentInfoModel> {
  final TipsAndGuideRepository repository;
  late final GlobalUpdateBus<dynamic> _bus;
  late final StreamSubscription _busSub;
  static const String _source = 'TipsCommentBloc';
  TipsCommentBloc({required this.repository})
    : super(
        fetchPage:
            ({
              required int page,
              String? search,
              Map<String, dynamic>? filters,
            }) async {
              log('filters in TipsCommentBloc fetchPage: $filters');

              final TipsCommentApiResponse response;
              log(
                'TipsCommentBloc filters in fetchPage before condition: ${filters?['type']}, ${filters?['userId']}, ${filters?['categoryId']}',
              );

              response = await repository.fethAllTipComments(
                page: page,
                search: search,
                filter: filters,
              );

              return PaginationResult<TipsCommentInfoModel>(
                items: response.comments,
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
      log('📡 Bus:- TipsCommentBlock received for ${event.source}');
      // if (event.source == _source) return;
      // final updatedItem = event.data;
      // log(
      //   '📡 Bus:- EventsBloc received for ${event.source}: ${updatedItem.id}',
      // );
    });
  }

  void fetchInitialComments({
    required TipsCommentScopeType type,
    String? tipId,
    String? search,
  }) {
    log('filters in TipsCommentBloc tipdId-3->: $tipId');
    log('filters in TipsGuideBloc type: $type');
    String scope = buildScope(type: type);
    log('filters in TipsGuideBloc scope: $scope');
    final filters = _buildFilters(tipId);

    fetchInitial(
      search: search,
      filters: {
        ...?filters,
        'scope': scope, // 👈 ADD THIS
      },
    );
  }

  String buildScope({required TipsCommentScopeType type, String? id}) {
    return [type.name, if (id != null) 'id:$id'].join('|');
  }

  void loadMoreTips() {
    fetchNextPage();
  }

  void refreshTips() {
    refresh();
  }

  Map<String, dynamic>? _buildFilters(String? tipId) {
    final filters = <String, dynamic>{};

    if (tipId != null) {
      filters['tipId'] = tipId;
    }

    return filters.isEmpty ? null : filters;
  }

  Future<void> postComment(TipsCommentInfoModel payload) async {
    log('Creating tip/guide with categoryId: $payload.tipId');
    try {
      /// 2. API call

      // Inser new item instantly with 'posting' status
      // insertItem(
      //   item: payload,
      //   select: false, // 👈 makes it selected immediately
      // );

      insertItem(
        item: payload,
        select: false, // 👈 makes it selected immediately
        targetScopes: {buildScope(type: TipsCommentScopeType.allComments)},
      );

      final ApiResponse result = await repository.createTipComment(
        tipId: payload.tipId,
        message: payload.comment,
        parentCommentId: payload.parentCommentId,
      );
      log('Create Comment API response: success=${result.success}');
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        if (result.data is Map<String, dynamic>) {
          final map = result.data as Map<String, dynamic>;

          final commentMap = map['comment'] as Map<String, dynamic>;

          final TipsCommentInfoModel tipsInfoItemModel =
              TipsCommentInfoModelMapper.fromMap(commentMap);
          // log('Create Comment API response: success=${result.data.comment}');

          deleteItem(
            test: (e) => e.id == payload.id,
            targetScopes: {buildScope(type: TipsCommentScopeType.allComments)},
          );

          insertItem(
            item: tipsInfoItemModel,
            select: false, // 👈 makes it selected immediately
            targetScopes: {buildScope(type: TipsCommentScopeType.allComments)},
          );

          // final post = eventInfoItemModel.toSubmittedPost();

          _bus.emit(
            data: {
              'id': payload.tipId,
              'countStatus': 'INCRIMENT', // 👈 can be used for targeted updates
            },
            source: _source,
            destination: [
              'MyLivePostsBloc',
              'TipsGuideBloc',
            ], // 👈 OPTIONAL, can be used for targeted updates
          );

          CustomSnackbar.show(result.message, SnackbarType.success);
        } else {
          log(
            'Create Comment API response: CATHED ERROR: Invalid response format',
          );
          CustomSnackbar.show('Invalid response format', SnackbarType.error);
          throw Exception('Invalid response format');
        }
      }
    } catch (e) {
      log('Create Comment API response: CATHED ERROR: $e');
      CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }

  // List<TipsCommentInfoModel> addReplyToTree(
  //   List<TipsCommentInfoModel> comments,
  //   String parentId,
  //   TipsCommentInfoModel newReply,
  // ) {
  //   log('Adding reply to tree comments ${comments.length}');
  //   log('Adding reply Current tree: ${parentId}');
  //   log('Adding reply Current tree: ${newReply.comment}');
  //   return comments.map((c) {
  //     // 🎯 Found the parent → add reply here
  //     if (c.id == parentId) {
  //       log('Adding reply Current Found: ---------- parent ${c.comment}');
  //       return c.copyWith(
  //         replies: [...c.replies, newReply],
  //         replyCount: (c.replyCount ?? c.replies.length) + 1,
  //       );
  //     }else{
  //       log('Adding reply Current tree: 1111111 parent ${c.comment}');
  //     }

  //     // 🔁 Otherwise recurse deeper
  //     return c.copyWith(replies: addReplyToTree(c.replies, parentId, newReply));
  //   }).toList();
  // }

  List<TipsCommentInfoModel> addReplyToTree(
    List<TipsCommentInfoModel> comments,
    String parentId,
    TipsCommentInfoModel newReply,
  ) {
    return comments.map((c) {
      // 🎯 CASE 1: this comment IS the parent
      if (c.id == parentId) {
        return c.copyWith(
          replies: [...c.replies, newReply],
          replyCount: (c.replyCount ?? c.replies.length) + 1,
        );
      }

      // 🔁 CASE 2: maybe parent is deeper
      return c.copyWith(replies: addReplyToTree(c.replies, parentId, newReply));
    }).toList();
  }

  Future<void> postReply(TipsCommentInfoModel payload) async {
    log('Creating tip/guide with categoryId: $payload.tipId');
    try {
      /// 2. API call

      // updateItemEverywhere(
      //   test: (_) => true,
      //   update: (item) => item.copyWith(
      //     replies: addReplyToTree(
      //       item.replies,
      //       payload.parentCommentId!, // 👈 important
      //       payload,
      //     ),
      //   ),
      // );

      final ApiResponse result = await repository.createTipComment(
        tipId: payload.tipId,
        message: payload.comment,
        parentCommentId: payload.parentCommentId,
      );
      log('Create Comment API response: success=${result.success}');
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        throw Exception(result.message);
      } else {
        if (result.data is Map<String, dynamic>) {
          log('Create Comment API Netsted: 1');
          final map = result.data as Map<String, dynamic>;
          log('Create Comment API Netsted: 2');
          final commentMap = map['comment'] as Map<String, dynamic>;
          log('Create Comment API Netsted: 3');
          final TipsCommentInfoModel tipsInfoItemModel =
              TipsCommentInfoModelMapper.fromMap(commentMap);
          log('Create Comment API Netsted: 4');

          log(
            'Create Comment API response: success=${tipsInfoItemModel.comment}',
          );

          // updateItemEverywhere(
          //   test: (_) => true,
          //   update: (item) => item.copyWith(
          //     replies: addReplyToTree(
          //       item.replies,
          //       tipsInfoItemModel.parentCommentId!, // 👈 important
          //       tipsInfoItemModel,
          //     ),
          //   ),
          // );

          updateItemEverywhere(
            test: (_) => true,
            update: (item) {
              // 🎯 if THIS item is the parent
              if (item.id == tipsInfoItemModel.parentCommentId) {
                return item.copyWith(
                  replies: [...item.replies, tipsInfoItemModel],
                  replyCount: (item.replyCount ?? item.replies.length) + 1,
                );
              }

              // 🔁 otherwise recurse into its replies
              return item.copyWith(
                replies: addReplyToTree(
                  item.replies,
                  tipsInfoItemModel.parentCommentId!,
                  tipsInfoItemModel,
                ),
              );
            },
          );
          _bus.emit(
            data: {
              'id': payload.tipId,
              'countStatus': 'INCRIMENT', // 👈 can be used for targeted updates
            },
            source: _source,
            destination: [
              'MyLivePostsBloc',
              'TipsGuideBloc',
            ], // 👈 OPTIONAL, can be used for targeted updates
          );
          log('Create Comment API Netsted: updated');
          CustomSnackbar.show(result.message, SnackbarType.success);
        } else {
          log(
            'Create Comment Netsted API response: CATHED ERROR: Invalid response format',
          );
          CustomSnackbar.show('Invalid response format', SnackbarType.error);
          throw Exception('Invalid response format');
        }
      }
    } catch (e) {
      log('Create Comment Netsted API response: CATHED ERROR: $e');
      CustomSnackbar.show('some thing went wrong', SnackbarType.error);
      rethrow;
    }
  }

  Future<void> deleteComment({
    required String tipId,
    required String commentId,
  }) async {
    log('Deleting comment with ID: $commentId');
    try {
      updateItemEverywhere(
        test: (item) => item.id == commentId,
        update: (item) => item.copyWith(
          messageStatus: MessageStatus.deleting.name, // Mark as deleting
        ),
      );

      /// 2. API call
      final ApiResponse result = await repository.deleteTipComment(
        commentId: commentId,
      );
      log(
        'Delete comment API response: success=${result.success}, message=${result.message}, data=${result.data}',
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        updateItemEverywhere(
          test: (item) => item.id == commentId,
          update: (item) => item.copyWith(
            messageStatus: MessageStatus.posted.name, // Mark as deleting
          ),
        );
        throw Exception(result.message);
      } else {
        deleteItem(
          test: (e) => e.id == commentId,
          targetScopes: {buildScope(type: TipsCommentScopeType.allComments)},
        );

        _bus.emit(
          data: {
            'id': tipId,
            'countStatus': 'DECRIMENT', // 👈 can be used for targeted updates
          },
          source: _source,
          destination: [
            'MyLivePostsBloc',
            'TipsGuideBloc',
          ], // 👈 OPTIONAL, can be used for targeted updates
        );

        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      updateItemEverywhere(
        test: (item) => item.id == commentId,
        update: (item) => item.copyWith(
          messageStatus: MessageStatus.posted.name, // Mark as deleting
        ),
      );
      rethrow;
    }
  }

  List<TipsCommentInfoModel> removeCommentFromTree(
    List<TipsCommentInfoModel> comments,
    String commentId,
  ) {
    return comments
        .where((c) => c.id != commentId) // remove if it's THIS level
        .map(
          (c) =>
              c.copyWith(replies: removeCommentFromTree(c.replies, commentId)),
        )
        .toList();
  }

  Future<void> deleteChildComment({
    required String tipId,
    required String parentCommentId,
    required String commentId,
  }) async {
    log(
      'Deleting comment with ID: $commentId, parentCommentId: $parentCommentId',
    );
    try {
      updateItemEverywhere(
        test: (_) => true, // or scope-specific if needed
        update: (item) => item.copyWith(
          replies: removeCommentFromTree(item.replies, commentId),
        ),
      );

      /// 2. API call
      final ApiResponse result = await repository.deleteTipComment(
        commentId: commentId,
      );
      log(
        'Delete comment API response: success=${result.success}, message=${result.message}, data=${result.data}',
      );
      if (!result.success) {
        CustomSnackbar.show(result.message, SnackbarType.error);
        updateItemEverywhere(
          test: (item) => item.id == commentId,
          update: (item) => item.copyWith(
            messageStatus: MessageStatus.posted.name, // Mark as deleting
          ),
        );
        throw Exception(result.message);
      } else {
        _bus.emit(
          data: {
            'id': tipId,
            'countStatus': 'DECRIMENT', // 👈 can be used for targeted updates
          },
          source: _source,
          destination: [
            'MyLivePostsBloc',
            'TipsGuideBloc',
          ], // 👈 OPTIONAL, can be used for targeted updates
        );
        deleteItem(
          test: (e) => e.id == commentId,
          targetScopes: {buildScope(type: TipsCommentScopeType.allComments)},
        );
        CustomSnackbar.show(result.message, SnackbarType.success);
      }
    } catch (e) {
      updateItemEverywhere(
        test: (item) => item.id == commentId,
        update: (item) => item.copyWith(
          messageStatus: MessageStatus.posted.name, // Mark as deleting
        ),
      );
      rethrow;
    }
  }

  Future<void> fetchReplies({
    required String commentId,
    required int page,
  }) async {
    try {
      final TipsRepliesApiResponse response;
      response = await repository.fetchCommentReplies(
        commentId: commentId,
        page: page,
      );

      updateItemEverywhere(
        test: (item) => item.id == commentId,
        update: (item) => item.copyWith(
          replyCount: response.pagination.totalItems, // Update reply count
          replies: response.replies, // Mark as deleting
        ),
      );
    } catch (e) {
      log('Error fetching replies for comment $commentId: $e');
      // Handle error, e.g., show a snackbar
    }
  }

  @override
  Future<void> close() {
    _busSub.cancel();
    return super.close();
  }
}
