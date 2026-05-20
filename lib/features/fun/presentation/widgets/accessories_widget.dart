import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/app_extensions/price_formatter_extension.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AccessoriesWidget extends StatelessWidget {
  final int? selectedIndex;
  final List<Accessory> accessories;
  final void Function(int selectedIndex) onChange;
  const AccessoriesWidget({
    required this.accessories,
    required this.selectedIndex,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: accessories.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        bool isSelected = index == selectedIndex;
        final accessory = accessories[index];
        return GestureDetector(
          onTap: () {
            onChange(index);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Badge(
                backgroundColor: AppColors.transparent,
                padding: const EdgeInsets.all(0),
                offset: const Offset(0, 0),
                label: isSelected
                    ? AppIcon(AppIcons.svg.generic.checkCircle, size: 16.h)
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.p1_50,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: AppColors.a1_400)
                        : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.s8),
                    child: AppIcon(
                      fit: BoxFit.cover,
                      accessory.imageUrl ?? '',

                      height: 46.h,
                      width: 46.h,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s8),
              Flexible(
                child: AppText.h1(accessory.name, fontSize: AppFontSize.fs14),
              ),

              Flexible(
                child: AppText.h4(
                  '${accessory.currency} ${accessory.price.formatPrice()}',
                  fontSize: AppFontSize.fs10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Accessory {
  final String name;
  final double price;
  final String? imageUrl;
  final String id;
  final String currency;

  Accessory({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.id,
    required this.currency,
  });
}
