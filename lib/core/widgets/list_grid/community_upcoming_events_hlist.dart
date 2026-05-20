import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/list_items/event_hlist_item_card.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/presentation/view/my_event_form_screen.dart';
import 'package:poochcare/router/app_router.dart';

class CommunityUpcomingEventsHlist extends StatefulWidget {
  final void Function(String value)? onTap;
  final Future<void> Function() onViewAllTap;
  final List<EventInfoItemModel>? listItems;
  final String? title;
  final bool? isLoading;

  const CommunityUpcomingEventsHlist({
    super.key,
    this.onTap,
    required this.onViewAllTap,
    this.listItems,
    this.title,
    this.isLoading,
  });

  @override
  State<CommunityUpcomingEventsHlist> createState() =>
      _CommunityUpcomingEventsHlistState();
}

class _CommunityUpcomingEventsHlistState
    extends State<CommunityUpcomingEventsHlist> {
  // ignore: avoid_redundant_argument_values
  List<EventInfoItemModel> get _items => widget.listItems ?? [];

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        PrimaryWidgetHeader(
          title: widget.title ?? 'Upcoming Events',
          buttonTitle: 'View All',
          onButtonTap: () async {
            await widget.onViewAllTap();
          },
        ),
        _buildContent(isLoading),
        AppSpacing.s10.hBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
          child: AppButton(
            width: null,
            label: 'Add Your Event',
            onPressed: () {
              context.pushRoute(MyEventFormRoute(type: MyEventFormType.create));
            },
            size: AppButtonSize.xSmall,
            trailingSvgAsset: AppIcons.svg.generic.plusSign,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(bool isLoading) {
    /// Loading state (only if no data yet)
    if (isLoading) {
      return SizedBox(
        height: AppSize.cs100.csh,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_items.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: AppSize.cs320.csh,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        separatorBuilder: (_, _) => SizedBox(width: AppSpacing.s12.w),
        itemBuilder: (context, index) {
          final item = _items[index];
          return AspectRatio(
            aspectRatio: 230 / 310,
            child: EventHlistItemCard(
              item: item,
              onCardTap: () {
                bool isOwnPost = false; // 👈 Assume it's own post for now
                final userId = context.read<AuthStoreBloc>().state.user?.id;
                if (userId != null && userId == item.organizer?.id) {
                  isOwnPost = true;
                }
                context.pushRoute(
                  CommunityEventDetailsRoute(
                    eventId: item.id,
                    isOwnPost: isOwnPost,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
