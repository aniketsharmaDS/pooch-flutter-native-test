import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/list_grid/app_paginated_list_view.dart';
import 'package:poochcare/core/widgets/others/community/profile_avatar.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/community/data/models/tips_comment_info_model.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_comment_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';

class CommentsBottomSheet extends StatefulWidget {
  final String tipId;

  const CommentsBottomSheet({super.key, required this.tipId});

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();

  static void show({required BuildContext context, required String tipId}) {
    log('filters in TipsCommentBloc tipdId-2->: $tipId');
    AppBottomSheet.show<void>(
      context: context,
      backgroundColor: const Color(0xffFEF3E6),
      title: 'Comments',
      content: BlocProvider(
        create: (_) => getIt<TipsCommentBloc>()
          ..fetchInitialComments(
            type: TipsCommentScopeType.allComments,
            tipId: tipId,
          ),
        child: CommentsBottomSheet(
          tipId: tipId, // ✅ pass inside
        ),
      ),
      actions: null,
    );
  }
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  String? _expandedCommentId;
  bool isFetchingReplies = false;
  TipsCommentInfoModel? _replyingToComment;
  bool _isSubmitting = false;
  final Set<String> _expandedCommentText = {};
  static const int _commentTextLimit = 200;
  late final String _currentUserId;
  late final String _currentUserName;
  late final String? _currentUserProfilePicture;
  // Inside your Comment Widget's build method
  Offset _tapPosition = Offset.zero;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadInitalData();
    });
    final userProfile = context.read<UserProfileBloc>().state.profile;
    _currentUserId = userProfile?.id ?? '';
    _currentUserName = userProfile?.name ?? 'Unknown User';
    _currentUserProfilePicture = _sanitizeProfilePicture(
      userProfile?.profilePicture,
    );
  }

  void loadInitalData() {
    context.read<TipsCommentBloc>().fetchInitialComments(
      type: TipsCommentScopeType.allComments,
      tipId: widget.tipId,
    );
  }

  Future<void> _onRefresh() async {
    context.read<TipsCommentBloc>().refreshTips();
  }

  void _onLoadMore() {
    context.read<TipsCommentBloc>().loadMoreTips();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight <= 320 ? screenHeight * 0.7 : screenHeight * 0.8,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Expanded(
            child:
                BlocBuilder<
                  TipsCommentBloc,
                  PaginationState<TipsCommentInfoModel>
                >(
                  builder: (context, state) {
                    return AppPaginatedListView<TipsCommentInfoModel>(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      items: state.items,
                      isLoading: state.isLoading,
                      isLoadingMore: state.isFetchingMore,
                      hasMore: state.hasMore,
                      hasError: state.errorMessage != null,
                      error:
                          state.errorMessage ??
                          'An error occurred while loading data.',
                      onLoadMore: _onLoadMore,
                      onRefresh: _onRefresh,
                      onRetry: () {
                        loadInitalData();
                      },
                      itemBuilder: (item, index) {
                        return _buildCommentItem(item, index, textTheme);
                      },
                    );
                  },
                ),
          ),
          // Reply Preview (when replying to a comment)
          if (_replyingToComment != null) _buildReplyPreview(textTheme),

          // Comment Input Field
          _buildCommentInputField(textTheme),
        ],
      ),
    );
  }

  void _handleReplyTap(TipsCommentInfoModel comment) {
    setState(() {
      _replyingToComment = comment;
    });
    // _commentFocusNode.requestFocus();
  }

  void _cancelReply() {
    setState(() {
      _replyingToComment = null;
    });
    _commentController.clear();
  }

  bool _isExpanded(TipsCommentInfoModel comment) =>
      _expandedCommentId == comment.id;

  bool _isCommentTextExpanded(String commentId) =>
      _expandedCommentText.contains(commentId);

  void _toggleCommentText(String commentId) {
    setState(() {
      if (_expandedCommentText.contains(commentId)) {
        _expandedCommentText.remove(commentId);
      } else {
        _expandedCommentText.add(commentId);
      }
    });
  }

  bool _shouldTruncateComment(String commentText) =>
      commentText.length > _commentTextLimit;

  List<TipsCommentInfoModel> _repliesFor(TipsCommentInfoModel comment) {
    log('comment.replies: ${comment.replies.length}');
    return comment.replies;
  }

  void _toggleReplies(TipsCommentInfoModel comment) async {
    if (_isExpanded(comment)) {
      setState(() => _expandedCommentId = null);
      return;
    }

    setState(() => isFetchingReplies = true);

    try {
      await context.read<TipsCommentBloc>().fetchReplies(
        commentId: comment.id,
        page: 1,
      );

      setState(() {
        _expandedCommentId = comment.id;
      });
    } catch (e) {
      // optional: handle error
    } finally {
      setState(() => isFetchingReplies = false);
    }

    setState(() => _expandedCommentId = comment.id);
  }

  Widget _buildCommentItem(
    TipsCommentInfoModel comment,
    int commentIndex,
    TextTheme textTheme, {
    bool isReply = false,
  }) {
    final repliesList = _repliesFor(comment);
    final hasReplies = comment.hasReplies ?? false;
    final isExpanded = _isExpanded(comment);
    final displayReplyCount = comment.replyCount ?? 0;
    final replyLabel = displayReplyCount == 1 ? 'reply' : 'replies';
    final isPosting = comment.messageStatus == MessageStatus.posting.name;
    final isDeleting = comment.messageStatus == MessageStatus.deleting.name;
    String? profilePic = comment.user?.profile?.profilePicture ?? '';
    if (profilePic.trim().isEmpty && comment.isCurrentUser) {
      profilePic = _currentUserProfilePicture ?? '';
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, left: isReply ? 40.w : 0),
      child: InkWell(
        onTapDown: _getTapPosition,
        onLongPress: comment.userId == _currentUserId
            ? () => _showContextMenu(
                context,
                comment.id,
                isReply ? comment.parentCommentId : null,
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileAvatar(
                  networkImage: profilePic,
                  initials: comment.user?.name.isNotEmpty == true
                      ? comment.user!.name[0].toUpperCase()
                      : 'U',
                  size: 35,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: AppText.bodyM(
                              (comment.isCurrentUser)
                                  ? 'You . '
                                  : '${comment.user?.name} . ',
                              fontSize: 12,
                              color: const Color(0xff1B1B1B),
                            ),
                          ),

                          AppText.bodyM(
                            fontSize: 12,
                            formatTimeAgo(
                              comment.createdAt.toString(),
                              isFullDate: false,
                            ),
                            color: const Color(0xff1B1B1B),
                          ),
                          if (comment.isCurrentUser)
                            AppText.bodyM(
                              fontSize: 12,
                              ' (Author)',
                              color: const Color(0xff1B1B1B),
                            ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      _buildCommentText(comment, textTheme),
                      // SizedBox(height: 5.h),
                      if (!isPosting && !isDeleting && !isReply) ...[
                        AppButton(
                          disableRippleEffect: true,
                          variant: AppButtonVariant.text,
                          onPressed: () => _handleReplyTap(comment),
                          removePadding: true,
                          size: AppButtonSize.xSmall,
                          width: null,
                          label: 'Reply',
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            // View Replies Button
            if (hasReplies && !isExpanded) ...[
              Padding(
                padding: EdgeInsets.only(left: 52.w, top: 8.h),
                child: AppButton(
                  disableRippleEffect: true,
                  isLoading: isFetchingReplies,
                  isDisabled: isFetchingReplies,
                  width: null,
                  size: AppButtonSize.xSmall,
                  variant: AppButtonVariant.text,
                  onPressed: () => _toggleReplies(comment),
                  label: displayReplyCount > 0
                      ? 'View $displayReplyCount $replyLabel'
                      : 'View replies',
                  leadingIcon: Icon(
                    Icons.subdirectory_arrow_right,
                    size: 16.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],

            // Nested Replies
            if (hasReplies && isExpanded) ...[
              SizedBox(height: 12.h),
              ...repliesList.map(
                (reply) => _buildCommentItem(
                  reply,
                  commentIndex,
                  textTheme,
                  isReply: true,
                ),
              ),
              // Hide Replies Button
              Padding(
                padding: EdgeInsets.only(left: 52.w, top: 8.h),
                child: AppButton(
                  disableRippleEffect: true,
                  size: AppButtonSize.xSmall,
                  width: null,
                  onPressed: () => _toggleReplies(comment),
                  label: 'Hide replies',
                  leadingIcon: Icon(
                    Icons.expand_less,
                    size: 16.sp,
                    color: AppColors.white_50,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReplyPreview(TextTheme textTheme) {
    if (_replyingToComment == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.background.withAlpha(128),
        border: const Border(top: BorderSide(color: AppColors.primaryBorder)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.subdirectory_arrow_right,
            size: 16.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: AppText.bodyS(
              'Replying to ${(_replyingToComment?.userId == _currentUserId) ? 'Yourself' : (_replyingToComment?.user?.name ?? 'Unknown')}',
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 18.sp,
              color: AppColors.textSecondary,
            ),
            onPressed: _cancelReply,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInputField(TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        top: 12.h,
        bottom: 12.h + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.surface,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            const ProfileAvatar(networkImage: '', initials: 'U', size: 35),
            const SizedBox(width: 10),
            Expanded(
              child: AppTextField(
                suffixWidget: InkWell(
                  onTap: () {},
                  child: AppIcon(AppIcons.svg.commentIcons.smile),
                ),
                label: 'Add comment',
                controller: _commentController,
                focusNode: _commentFocusNode,
                textInputAction: TextInputAction.newline,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: 8.w),
            IconButton(
              style: ButtonStyle(
                fixedSize: const WidgetStatePropertyAll(Size(48, 48)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16.r),
                  ),
                ),
                backgroundColor: const WidgetStatePropertyAll(AppColors.black),
              ),
              icon: _isSubmitting
                  ? SizedBox(
                      width: 20.sp,
                      height: 20.sp,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : AppIcon(AppIcons.svg.commentIcons.paperPlane),
              onPressed:
                  (_commentController.text.trim().isEmpty || _isSubmitting)
                  ? null
                  : _submitComment,
            ),
          ],
        ),
      ),
    );
  }

  void _submitComment() async {
    final commentText = _commentController.text.trim();
    if (commentText.isEmpty) return;

    setState(() => _isSubmitting = true);

    try {
      if (_replyingToComment != null) {
        final parentId = _replyingToComment!.id;
        final newComment = TipsCommentInfoModel(
          id: _newId(),
          comment: commentText,
          tipId: widget.tipId,
          parentCommentId: parentId,
          userId: _currentUserId,
          user: TipsCommentUserInfo(
            id: _currentUserId,
            name: _currentUserName,
            profile: TipsCommentUserProfile(
              profilePicture: _currentUserProfilePicture,
            ),
          ),
          hasReplies: false,
          replyCount: 0,
          isCurrentUser: true,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          messageStatus: MessageStatus.posting.name,
        );
        await context.read<TipsCommentBloc>().postReply(newComment);
      } else {
        final newComment = TipsCommentInfoModel(
          id: _newId(),
          comment: commentText,
          tipId: widget.tipId,
          // parentCommentId: null,
          userId: _currentUserId,
          user: TipsCommentUserInfo(
            id: _currentUserId,
            name: _currentUserName,
            profile: TipsCommentUserProfile(
              profilePicture: _currentUserProfilePicture,
            ),
          ),
          hasReplies: false,
          replyCount: 0,
          isCurrentUser: true,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          messageStatus: MessageStatus.posting.name,
        );
        await context.read<TipsCommentBloc>().postComment(newComment);
      }

      _commentController.clear();
      _cancelReply();
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  void _getTapPosition(TapDownDetails details) {
    final data = Offset(
      details.globalPosition.dx,
      details.globalPosition.dy + 10,
    );
    _tapPosition = data;
  }

  void _showContextMenu(
    BuildContext context,
    String commentId,
    String? parentCommentId,
  ) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      popUpAnimationStyle: const AnimationStyle(
        curve: Curves.easeIn,
        reverseDuration: Duration(milliseconds: 300),
        reverseCurve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
      ),
      // Use the captured position to show the menu exactly there
      position: RelativeRect.fromRect(
        _tapPosition &
            const Size(40, 40), // small rectangular area at tap point
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            onTap: () {
              if (parentCommentId != null) {
                context.read<TipsCommentBloc>().deleteChildComment(
                  tipId: widget.tipId,
                  commentId: commentId,
                  parentCommentId: parentCommentId,
                );
              } else {
                context.read<TipsCommentBloc>().deleteComment(
                  tipId: widget.tipId,
                  commentId: commentId,
                );
              }
              Navigator.pop(context);
            },
            leading: const Icon(Icons.delete_outline),
            title: AppText.bodyS('Delete'),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {});
  }

  /// Sanitize profile picture: treat empty string as null
  String? _sanitizeProfilePicture(String? picture) {
    if (picture == null || picture.trim().isEmpty) {
      return null;
    }
    return picture;
  }

  Widget _buildCommentText(TipsCommentInfoModel comment, TextTheme textTheme) {
    final isTextExpanded = _isCommentTextExpanded(comment.id);
    final shouldTruncate = _shouldTruncateComment(comment.comment);
    final displayText = !shouldTruncate || isTextExpanded
        ? comment.comment
        : '${comment.comment.substring(0, _commentTextLimit)}...';
    final isPosting = comment.messageStatus == MessageStatus.posting.name;
    final isDeleting = comment.messageStatus == MessageStatus.deleting.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.bodyS(
          isPosting
              ? '$displayText (Posting...)'
              : isDeleting
              ? '$displayText (Deleting...)'
              : displayText,
          variant: AppTextVariant.noEllipsis,
        ),
        if (shouldTruncate) ...[
          SizedBox(height: 4.h),
          AppButton(
            width: null,
            variant: AppButtonVariant.text,
            size: AppButtonSize.xSmall,
            onPressed: () => _toggleCommentText(comment.id),
            label: isTextExpanded ? 'Show less' : 'Show more',
          ),
        ],
      ],
    );
  }

  String _newId() => DateTime.now().microsecondsSinceEpoch.toString();

  String buildScope({required TipsCommentScopeType type, String? id}) {
    return [type.name, if (id != null) 'id:$id'].join('|');
  }
}
