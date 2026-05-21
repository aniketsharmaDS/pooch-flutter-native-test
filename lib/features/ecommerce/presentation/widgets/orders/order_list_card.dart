import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';

class StatusStyle {
  final Color bgColor;
  final Color textColor;

  const StatusStyle(this.bgColor, this.textColor);
}

class OrderListCard extends StatelessWidget {
  final OrderItemModel item;
  final String actionLabel;
  final VoidCallback onAction;
  final VoidCallback? onTap;

  const OrderListCard({
    super.key,
    required this.item,
    required this.actionLabel,
    required this.onAction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var headerHeight = 45.0.h;
    var overlapOffset = 20.0.h;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(top: 0, left: 0, right: 0, child: _buildHeader()),
            Padding(
              padding: EdgeInsets.only(top: headerHeight - overlapOffset),
              child: _buildContentCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 50.0.h,
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 8.h),
      decoration: const BoxDecoration(
        color: Color(0xFFFBDBB2),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: AppText.support(
        'Order Id: ${item.orderNumber}',
        color: const Color(0xFF2D2D2E),
      ),
    );
  }

  Widget _buildContentCard() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 117.h, maxWidth: double.maxFinite),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.h)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImageFrame(width: 98.w, height: 80.h, imageUrl: item.image),
            SizedBox(width: 12.w),
            Expanded(child: _buildContentSection()),
            SizedBox(width: 4.w),
            _buildRightColumn(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bodyM(
            item.title,
            maxLines: 2,
            color: AppColors.textSecondary,
            style: TextStyle(height: 1.2, fontSize: AppFontSize.fs14),
          ),
          const SizedBox(height: 4),
          ...[
            AppText.bodyS(
              item.subtitle,
              color: const Color(0xFFB3958B),
              style: const TextStyle(height: 1.2),
            ),
            const SizedBox(height: 4),
          ],
          AppText.bodyS(
            item.dateTime,
            color: const Color(0xFFB3958B),
            style: const TextStyle(height: 1.2),
          ),
          const SizedBox(height: 4),
          _buildPriceRow(),
        ],
      ),
    );
  }

  Widget _buildPriceRow() {
    final original = item.originalAmount?.round();
    return Row(
      children: [
        AppText.h1(
          'INR ${item.price}',
          color: AppColors.black,
          fontSize: AppFontSize.fs14,
          style: const TextStyle(height: 1.2),
        ),
        if (original != null && original > item.price) ...[
          const SizedBox(width: 6),
          AppText.support(
            'INR $original',
            color: const Color(0xFFA7A7A8),
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
        ],
      ],
    );
  }

  String normalizeStatus(String status) {
    return status.trim().toLowerCase();
  }

  StatusStyle getStatusStyle(String status) {
    switch (normalizeStatus(status)) {
      case 'delivered':
        return const StatusStyle(
          Color(0xFFE9F9EF), // light green
          Color(0xFF188C43), // dark green
        );
      case 'on time':
      case 'in transit':
        return const StatusStyle(AppColors.p1_50, AppColors.p1_800);
      case 'cancelled':
        return const StatusStyle(
          Color(0xFFFFEAEA), // light red
          Color(0xFFD32F2F), // red
        );
      case 'pending':
        return const StatusStyle(
          Color(0xFFFFF4E5), // light orange
          Color(0xFFE65100), // orange
        );
      default:
        return const StatusStyle(AppColors.p1_50, AppColors.p1_800);
    }
  }

  Widget _buildRightColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [_buildStatusBadge(), _builtActionButton()],
    );
  }

  String _formatStatus(String status) {
    if (status.isEmpty) return status;

    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  Widget _buildStatusBadge() {
    final statusStyle = getStatusStyle(item.status);
    return Container(
      height: 17.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: statusStyle.bgColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      alignment: Alignment.center,
      child: AppText.support(
        _formatStatus(item.status),
        color: statusStyle.textColor,
      ),
    );
  }

  Widget _builtActionButton() {
    return AppButton(
      padding: EdgeInsets.zero,
      removePadding: true,
      label: actionLabel,
      onPressed: onAction,
      variant: AppButtonVariant.outlined,
      size: AppButtonSize.extraSmall,
      width: AppSize.cs82,
      height: AppSize.cs36,
    );
  }
}
