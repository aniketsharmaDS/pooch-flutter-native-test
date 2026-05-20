import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/list_items/missing_pooch_hlist_item_card.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/presentation/view/report_missing_pet_form_screen.dart';
import 'package:poochcare/router/app_router.dart';

class CommunityPetMissingHlist extends StatefulWidget {
  final void Function(String reportId, bool isAuthor)? onTap;
  final void Function(String reportId)? onViewAllTap;
  final List<MissingPetModel>? missingPets;
  final bool isLoading;

  const CommunityPetMissingHlist({
    super.key,
    this.onTap,
    this.onViewAllTap,
    this.missingPets,
    this.isLoading = false,
  });

  @override
  State<CommunityPetMissingHlist> createState() =>
      _CommunityPetMissingHlistState();
}

class _CommunityPetMissingHlistState extends State<CommunityPetMissingHlist> {
  List<MissingPetModel> get _items => widget.missingPets ?? [];

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        PrimaryWidgetHeader(
          title: 'Missing Pets Posted Lately',
          buttonTitle: 'View All',
          onButtonTap: () {
            widget.onViewAllTap?.call('Missing Pets');
          },
        ),

        _buildContent(isLoading),

        AppSpacing.s10.hBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
          child: AppButton(
            width: null,
            label: 'Add Missing Report',
            onPressed: () {
              context.pushRoute(
                ReportMissingPetFormRoute(
                  type: ReportMissingPetFormType.create,
                ),
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
    /// Loading state (only if no data yet)
    log(
      'Building item card for: location: $isLoading items length: ${_items.length}',
    );
    if (isLoading && _items.isEmpty) {
      return SizedBox(
        height: AppSize.cs320.csh,
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
          return MissingPoochHlistItemCard(
            item: item,
            onCardTap: () {
              widget.onTap?.call(item.id, item.isAuthor ?? false);
            },
          );
        },
      ),
    );
  }
}
