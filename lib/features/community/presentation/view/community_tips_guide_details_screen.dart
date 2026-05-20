import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/services/notification_service.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/bottom_sheet/comment_bottom_sheet/comment_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/community_report_dialog.dart';
import 'package:poochcare/core/widgets/list_items/tips_info_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/features/community/presentation/view/my_tip_guide_form_screen.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class CommunityTipsGuideDetailsScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const CommunityTipsGuideDetailsScreen({
    super.key,
    required this.tipId,
    this.isOwnPost = false,
  });

  final String tipId;
  final bool? isOwnPost;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TipsGuideBloc>.value(value: getIt<TipsGuideBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<CommunityTipsGuideDetailsScreen> createState() =>
      _CommunityTipsGuideDetailsScreenState();
}

class _CommunityTipsGuideDetailsScreenState
    extends State<CommunityTipsGuideDetailsScreen> {
  bool get _isOwnPost => widget.isOwnPost == true;
  bool isApiExecuting = false;
  TipsGuideBloc get _tipsBloc => context.read<TipsGuideBloc>();

  @override
  void initState() {
    super.initState();
    NotificationService.currentTipId = widget.tipId;
    _load();
  }

  void _load() {
    _isOwnPost
        ? _tipsBloc.fetchTipsDetails(widget.tipId)
        : _tipsBloc.fetchTipsDetails(widget.tipId);
  }

  Future<void> _onRefresh() async {
    _isOwnPost
        ? await _tipsBloc.fetchTipsDetails(widget.tipId, isRefresh: true)
        : await _tipsBloc.fetchTipsDetails(widget.tipId, isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return AppPrimaryBgContainer(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: PoochScreenAppBar(
          title: '',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSpacing.s8.w),
              child: Row(
                children: [
                  if (!_isOwnPost) ...[
                    AppCircleButton(
                      hitSlop: EdgeInsets.only(right: -AppSpacing.s3.w),
                      variant: AppCircleButtonVariant.secondary,
                      bgColor: AppColors.transparent,
                      iconSize: AppIconSize.is20,
                      showShadow: false,
                      icon: AppIcons.svg.generic.flag,
                      onTap: () async {
                        final result = await CommunityReportDialog.show(
                          context: context,
                        );
                        if (result != null && mounted) {
                          reportTip(widget.tipId, result.reason);
                        }
                      },
                    ),
                  ],
                  AppCircleButton(
                    hitSlop: EdgeInsets.only(right: -AppSpacing.s3.w),
                    variant: AppCircleButtonVariant.secondary,
                    bgColor: AppColors.transparent,
                    iconSize: AppIconSize.is20,
                    showShadow: false,
                    icon: AppIcons.svg.generic.share,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share Tip')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: _isOwnPost
              ? BlocBuilder<TipsGuideBloc, PaginationState<TipsInfoItemModel>>(
                  builder: _build,
                )
              : BlocBuilder<TipsGuideBloc, PaginationState<TipsInfoItemModel>>(
                  builder: _build,
                ),
        ),

        bottomNavigationBar: _isOwnPost
            ? SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16.w,
                    vertical: AppSpacing.s16.h,
                  ),
                  child: Row(
                    children: [
                      /// Button 1
                      Expanded(
                        child: AppButton(
                          isLoading: isApiExecuting,
                          variant: AppButtonVariant.outlined,
                          label: 'Delete Post',
                          onPressed: () {
                            AppDialog.show(
                              icon: Lottie.asset(
                                AppIcons.lottie.delete,
                                repeat: false,
                              ),
                              context: context,
                              title: 'Delete Post?',
                              content:
                                  'This action cannot be undone. Are you sure you want to delete this post?',
                              primaryLabel: 'Cancel',
                              secondaryLabel: 'Delete',
                              onPrimary: () async {
                                return true;
                              },
                              onSecondary: () async {
                                deleteTip(widget.tipId);
                                return true;
                              },
                            );
                          },
                          size: AppButtonSize.medium,
                        ),
                      ),

                      SizedBox(width: AppSpacing.s10.w),

                      /// Button 2
                      Expanded(
                        child: AppButton(
                          isLoading: isApiExecuting,
                          label: 'Edit Post',
                          onPressed: () {
                            context.pushRoute(
                              MyTipGuideFormRoute(
                                type: MyTipFormType.edit,
                                tipId: widget.tipId,
                              ),
                            );
                          },
                          size: AppButtonSize.medium,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _build(
    BuildContext context,
    PaginationState<TipsInfoItemModel> state,
  ) {
    final item = state.selectedItem;

    if (state.isDetailLoading && (item == null || item.id != widget.tipId)) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.detailError != null && item == null) {
      return Center(child: Text(state.detailError!));
    }

    if (item == null) {
      return const Center(child: Text('Tip not found'));
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s16.w,
          vertical: AppSpacing.s12.h,
        ),
        child: Column(
          children: [
            TipsInfoListItemCard(
              isDetailView: true,
              item: item,
              onLikeChanged: (bool isLiked) {
                _isOwnPost
                    ? _tipsBloc.toggleTipsLike(
                        tipsId: item.id,
                        targetIsLiked: isLiked,
                      )
                    : _tipsBloc.toggleTipsLike(
                        tipsId: item.id,
                        targetIsLiked: isLiked,
                      );
              },
              onCommentTap: () {
                log('filters in TipsCommentBloc tipdId-1->: ${item.id}');
                CommentsBottomSheet.show(context: context, tipId: item.id);
              },
            ),
            if (state.isDetailRefreshing)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(child: CircularProgressIndicator()),
              ),
            AppSpacing.s16.hBox,
          ],
        ),
      ),
    );
  }

  Future<void> deleteTip(String tipId) async {
    setState(() {
      isApiExecuting = true;
    });

    try {
      await context.read<TipsGuideBloc>().deleteTip(tipId: tipId);
      // ignore: use_build_context_synchronously
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        isApiExecuting = false;
      });
    } finally {
      setState(() {
        isApiExecuting = false;
      });
    }
  }

  Future<void> reportTip(String tipId, String reason) async {
    setState(() {
      isApiExecuting = true;
    });

    try {
      await context.read<TipsGuideBloc>().reportTips(
        tipId: tipId,
        reason: reason,
      );
      // ignore: use_build_context_synchronously
      if (!mounted) return;
    } catch (e) {
      setState(() {
        isApiExecuting = false;
      });
    } finally {
      setState(() {
        isApiExecuting = false;
      });
    }
  }
}
