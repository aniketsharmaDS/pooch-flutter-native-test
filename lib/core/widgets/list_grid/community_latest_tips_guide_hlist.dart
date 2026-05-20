import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/list_items/tips_info_hlist_item_card.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';
import 'package:poochcare/features/community/presentation/view/my_tip_guide_form_screen.dart';
import 'package:poochcare/router/app_router.dart';

class CommunityLatestTipsGuideHlist extends StatefulWidget {
  final void Function(String value)? onTap;
  final Future<void> Function() onViewAllTap;
  final List<TipsInfoItemModel>? listItems;
  final String? title;
  final bool? isLoading;

  const CommunityLatestTipsGuideHlist({
    super.key,
    this.onTap,
    required this.onViewAllTap,
    this.listItems,
    this.isLoading,
    this.title,
  });

  @override
  State<CommunityLatestTipsGuideHlist> createState() =>
      _CommunityLatestTipsGuideHlistState();
}

class _CommunityLatestTipsGuideHlistState
    extends State<CommunityLatestTipsGuideHlist> {
  List<TipsInfoItemModel> get _items => widget.listItems ?? [];

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        PrimaryWidgetHeader(
          title: widget.title ?? 'Latest Tips and Guide',
          buttonTitle: 'View All',
          onButtonTap: () async {
            await widget.onViewAllTap();
          },
        ),

        /// CONTENT
        _buildContent(isLoading),

        /// ADD BUTTON
        AppSpacing.s10.hBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
          child: AppButton(
            width: null,
            label: 'Add tips & Guide',
            onPressed: () {
              context.pushRoute(
                MyTipGuideFormRoute(type: MyTipFormType.create),
              );
            },
            size: AppButtonSize.xSmall,
            trailingSvgAsset: AppIcons.svg.generic.plusSign,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(bool isLoading) {
    if (isLoading) {
      return SizedBox(
        height: AppSize.cs100.csh,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    /// Empty state
    if (_items.isEmpty) {
      return const SizedBox.shrink();
    }

    /// List
    return SizedBox(
      height: AppSize.cs100.csh,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        separatorBuilder: (_, _) => SizedBox(width: AppSpacing.s12.w),
        itemBuilder: (context, index) {
          final item = _items[index];

          return TipsInfoHlistItemCard(
            item: item,
            onTap: () {
              bool isOwnPost = false; // 👈 Assume it's own post for now
              final userId = context.read<AuthStoreBloc>().state.user?.id;
              if (userId != null && userId == item.userId) {
                isOwnPost = true;
              }
              context.pushRoute(
                CommunityTipsGuideDetailsRoute(
                  tipId: item.id,
                  isOwnPost: isOwnPost,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
