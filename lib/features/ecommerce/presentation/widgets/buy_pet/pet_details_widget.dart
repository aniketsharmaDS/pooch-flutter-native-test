import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_wishlist_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_slider.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class PetDetailsModel {
  final String tagText;
  final List<String> imageUrls;
  final String title;
  final String gender;
  final String location;
  final String price;
  final String? oldPrice;
  final String? discountLabel;
  final String description;
  final int descriptionMaxLines;
  final List<PetInfoItem> infoItems;
  bool inWishlist;
  final double? imageHeight;
  final String age;
  PetDetailsModel({
    required this.tagText,
    required this.imageUrls,
    required this.inWishlist,
    required this.title,
    required this.gender,
    required this.location,
    required this.price,
    required this.oldPrice,
    required this.discountLabel,
    required this.description,
    required this.descriptionMaxLines,
    required this.infoItems,
    this.imageHeight = 320,
    required this.age,
  });
}

class PetDetailsWidget extends StatefulWidget {
  final PetDetailsModel petDetailsData;
  final VoidCallback onWishlistTap;
  final bool isFromGetHelp;

  const PetDetailsWidget({
    super.key,
    required this.onWishlistTap,
    required this.petDetailsData,
    this.isFromGetHelp = false,
  });

  @override
  State<PetDetailsWidget> createState() => _PetDetailsWidgetState();
}

class _PetDetailsWidgetState extends State<PetDetailsWidget> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didUpdateWidget(covariant PetDetailsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final imageCount = widget.petDetailsData.imageUrls.length;
    if (_currentPage >= imageCount && imageCount > 0) {
      setState(() => _currentPage = imageCount - 1);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTopRow(onWishlistTap: widget.onWishlistTap),
          SizedBox(height: 17.h),
          _buildImageSection(),
          SizedBox(height: 17.h),
          _buildTitlePriceRow(),
          SizedBox(height: 16.h),
          _buildInfoRow(),
          SizedBox(height: 17.h),
          AppText.bodyS(
            widget.petDetailsData.description,
            color: const Color(0xFF404041),
            maxLines: widget.petDetailsData.descriptionMaxLines,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow({required VoidCallback onWishlistTap}) {
    return Row(
      children: [
        if (widget.isFromGetHelp)
          SizedBox(
            height: 34.h,
            width: 78.w,
            child: AppButton(
              label: 'Back',
              variant: AppButtonVariant.outlined,
              onPressed: () => context.router.maybePop(),
              // keep it compact
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              leadingIcon: AppIcon(
                AppIcons.svg.generic.chevronLeft,
                size: 12.w,
                color: const Color(0xFF1B1B1B),
              ),
            ),
          )
        else if (widget.petDetailsData.tagText.isNotEmpty)
          Container(
            alignment: Alignment.center,
            height: 34.h,
            width: 78.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFEFD),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: const Color(0xFF1B1B1B)),
            ),
            child: AppText.displayS(
              widget.petDetailsData.tagText,
              color: const Color(0xFF1B1B1B),
              maxLines: 1,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
          ),
        const Spacer(),
        // AppLikeCounter(
        //   isLiked: widget.petDetailsData.inWishlist,
        //   iconSize: 32,
        //   onTap: onWishlistTap,
        // ),
        AppWishlistButton(
          isSelected: widget.petDetailsData.inWishlist,
          onTap: onWishlistTap,
          size: 28,
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return AppImageSlider(
      pageController: _pageController,
      imageUrls: widget.petDetailsData.imageUrls,
      currentPage: _currentPage,
      onPageChanged: (index) {
        setState(() => _currentPage = index);
      },
      height: widget.petDetailsData.imageHeight ?? 240.h,
      borderRadius: BorderRadius.circular(18.r),
    );
  }

  String _capitalize(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  Widget _buildTitlePriceRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText.h4(
                    '${_capitalize(widget.petDetailsData.gender)}, ',
                    color: const Color(0xFFF28A07),
                    maxLines: 1,
                    fontSize: 18.sp,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                  AppText.h4(
                    widget.petDetailsData.age,
                    color: const Color(0xFFEA7A00),
                    maxLines: 1,
                    fontSize: 14.sp,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),

              SizedBox(height: 4.h),
              Row(
                children: [
                  AppIcon(
                    AppIcons.svg.generic.location,
                    size: 12.w,
                    color: const Color(0xFFAC6205),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: AppText.bodyS(
                      widget.petDetailsData.location,
                      color: const Color(0xFFAC6205),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppText.h1(
              widget.petDetailsData.price,
              color: AppColors.textSecondary,
              maxLines: 1,
              fontSize: 18.sp,
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.petDetailsData.discountLabel != null &&
                    widget.petDetailsData.discountLabel!.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE39B),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: AppText.support(
                      widget.petDetailsData.discountLabel!,
                      color: const Color(0xFF3A3A3B),
                      maxLines: 1,
                    ),
                  ),
                if (widget.petDetailsData.oldPrice != null &&
                    widget.petDetailsData.oldPrice!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: AppText.support(
                      widget.petDetailsData.oldPrice ?? 'INR 0',
                      color: const Color(0xFF2D2D2E),
                      maxLines: 1,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Color(0xFF2D2D2E),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow() {
    final items = widget.petDetailsData.infoItems;

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<int> flexValues = switch (items.length) {
      1 => [1],
      2 => [4, 4],
      3 => [4, 4, 3],
      _ => [4, 4, 3, 2],
    };

    return Row(
      children: List.generate(items.length, (index) {
        return _buildFlexibleItem(
          item: items[index],
          flex: flexValues[index],
          showDivider: index != items.length - 1,
        );
      }),
    );
  }

  Widget _buildFlexibleItem({
    required PetInfoItem item,
    required int flex,
    required bool showDivider,
  }) {
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _PetInfoItemView(item: item)),

          if (showDivider)
            Container(
              width: 1.w,
              height: 12.h,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              color: const Color(0xFFE5E5E5),
            ),
        ],
      ),
    );
  }
}

class PetInfoItem {
  final String label;
  final String? iconPath;
  final IconData? iconData;
  final Color? iconColor;

  const PetInfoItem({
    required this.label,
    this.iconPath,
    this.iconData,
    this.iconColor,
  }) : assert(iconPath != null || iconData != null);
}

class _PetInfoItemView extends StatelessWidget {
  final PetInfoItem item;

  const _PetInfoItemView({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (item.iconPath != null)
          AppIcon(item.iconPath!, size: 13.w, color: item.iconColor)
        else
          Icon(item.iconData, size: 13.w, color: item.iconColor),

        SizedBox(width: 4.w),

        Expanded(
          child: AppText.support(
            item.label,
            color: item.iconColor ?? const Color(0xFF6B6B6B),
            maxLines: 1,
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
