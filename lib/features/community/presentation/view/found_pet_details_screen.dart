import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/list_items/found_pooch_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/found_pet_model.dart';
import 'package:poochcare/features/community/presentation/bloc/found_pet/found_pet_bloc.dart';

@RoutePage()
class FoundPetDetailsScreen extends StatefulWidget implements AutoRouteWrapper {
  const FoundPetDetailsScreen({
    super.key,
    required this.reportId,
    this.isOwnPost = false,
    this.listType = 'default',
  });

  final String reportId;
  final String listType;
  final bool? isOwnPost;
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoundPetBloc>.value(value: getIt<FoundPetBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<FoundPetDetailsScreen> createState() => _FoundPetDetailsScreenState();
}

class _FoundPetDetailsScreenState extends State<FoundPetDetailsScreen> {
  // bool get _isOwnPost => widget.isOwnPost == true;
  bool isDeleting = false;
  FoundPetBloc get foundPetBlock => context.read<FoundPetBloc>();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    foundPetBlock.fetchDetails(widget.reportId);
  }

  Future<void> _onRefresh() async {
    await foundPetBlock.fetchDetails(widget.reportId, isRefresh: true);
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
                  // commneted as its not in the design
                  // AppCircleButton(
                  //   hitSlop: EdgeInsets.only(right: -AppSpacing.s3.w),
                  //   variant: AppCircleButtonVariant.secondary,
                  //   bgColor: AppColors.transparent,
                  //   iconSize: AppIconSize.is20,
                  //   showShadow: false,
                  //   icon: AppIcons.svg.generic.flag,
                  //   onTap: () async {
                  //     final scaffoldMessenger = ScaffoldMessenger.of(context);
                  //     final result = await CommunityReportDialog.show(
                  //       context: context,
                  //     );
                  //     if (result != null && mounted) {
                  //       scaffoldMessenger.showSnackBar(
                  //         SnackBar(
                  //           content: Text('Report submitted: ${result.reason}'),
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                  AppCircleButton(
                    hitSlop: EdgeInsets.only(right: -AppSpacing.s3.w),
                    variant: AppCircleButtonVariant.secondary,
                    bgColor: AppColors.transparent,
                    iconSize: AppIconSize.is20,
                    showShadow: false,
                    icon: AppIcons.svg.generic.share,
                    onTap: () => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share Event')),
                      ),
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<FoundPetBloc, PaginationState<FoundPetModel>>(
            builder: _build,
          ),
        ),
      ),
    );
  }

  Widget _build(BuildContext context, PaginationState<FoundPetModel> state) {
    final item = state.selectedItem;

    /// =============================
    /// LOADING
    /// =============================
    if (state.isDetailLoading && item == null) {
      return const Center(child: CircularProgressIndicator());
    }

    /// =============================
    /// ERROR
    /// =============================
    if (state.detailError != null && item == null) {
      return Center(child: Text(state.detailError!));
    }

    /// =============================
    /// EMPTY
    /// =============================
    if (item == null) {
      return const Center(child: Text('Pet not found'));
    }

    /// =============================
    /// UI
    /// =============================
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.s16.w,
          vertical: AppSpacing.s12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// =============================
            /// EVENT CARD (REUSED COMPONENT)
            /// =============================
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: AppSpacing.s25.h,
                horizontal: AppSpacing.s16.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.s16.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.h1('Happy Update!', color: AppColors.p1, maxLines: 1),
                  AppSpacing.s5.hBox,
                  AppText.h1(
                    '${item.missingReport?.pet.name} has been safely found by ${item.finder.name} and is now in loving care.',
                    maxLines: 3,
                    color: AppColors.p1_900,
                    fontSize: AppFontSize.fs14,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            AppSpacing.s18.hBox,

            FoundPoochListItemCard(isDetailView: true, item: item),
            SizedBox(height: AppSpacing.s16.h),

            /// =============================
            /// REFRESH LOADER
            /// =============================
            if (state.isDetailRefreshing)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
