import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/list_items/found_pooch_hlist_item_card.dart';
import 'package:poochcare/features/community/data/models/found_pet_model.dart';
import 'package:poochcare/router/app_router.dart';

class CommunityPetFoundHlist extends StatefulWidget {
  final void Function(String reportId)? onTap;
  final void Function(String symptom)? onViewAllTap;
  final List<FoundPetModel>? listItems;
  final bool isLoading;

  const CommunityPetFoundHlist({
    super.key,
    this.onTap,
    this.onViewAllTap,
    this.listItems,
    this.isLoading = false,
  });

  @override
  State<CommunityPetFoundHlist> createState() => _CommunityPetFoundHlistState();
}

class _CommunityPetFoundHlistState extends State<CommunityPetFoundHlist> {
  List<FoundPetModel> get _items => widget.listItems ?? [];

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        PrimaryWidgetHeader(
          title: 'Pets Found on Pooch Lately',
          buttonTitle: 'View All',
          onButtonTap: () {
            widget.onViewAllTap?.call('Pets Found on Pooch Lately');
          },
        ),

        _buildContent(isLoading),

        AppSpacing.s10.hBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
          child: AppButton(
            width: null,
            label: 'Add Found Report',
            onPressed: () {
              final secureStorage = getIt<SecureStorageService>();
              secureStorage.writeChatJourney(
                ChatReturnType.allMissingPetsTab.name,
              );
              context.pushRoute<bool>(const AddPetFoundRoute());
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
      'Building CFPHL card for: location: $isLoading items length: ${_items.length}',
    );
    if (isLoading) {
      return SizedBox(
        height: AppSize.cs320.csh,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_items.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: AppSize.cs300.csh,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        separatorBuilder: (_, _) => SizedBox(width: AppSpacing.s12.w),
        itemBuilder: (context, index) {
          final item = _items[index];
          log(
            'Building CFPHL card for item: ${item.id}, items length: ${_items.length}',
          );
          return AspectRatio(
            aspectRatio: 180 / 300,
            child: FoundPoochHlistItemCard(
              item: item,
              onCardTap: () => widget.onTap?.call(item.id),
            ),
          );
        },
      ),
    );
  }
}
