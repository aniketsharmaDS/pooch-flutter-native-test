import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/app_extensions/price_formatter_extension.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_bloc.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_state.dart';

enum AccessoryType { buy, my }

class AccessoriesWidget extends StatelessWidget {
  final List<Accessory> accessories;
  final AccessoriesState state;
  final AccessoryType accessoryType;
  final void Function(Accessory? selectedAccessory) onChange;

  const AccessoriesWidget({
    required this.accessories,
    required this.state,
    required this.onChange,
    this.accessoryType = AccessoryType.buy,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int actualItemsCount = accessories.length;
    int columnCount = (actualItemsCount / 2).ceil();
    final int displayColumnCount =
        (accessoryType == AccessoryType.buy
            ? state.hasReachedMax
            : state.yourAccessoriesHasReachedMax)
        ? columnCount
        : columnCount + 1;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: displayColumnCount,
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   childAspectRatio: 0.7,
      //   mainAxisSpacing: 10,
      //   crossAxisSpacing: 5,
      // ),
      itemBuilder: (context, index) {
        // Case A: Show loading spinner column slot at the end of the list
        if (index >= columnCount) {
          return const Center(child: CircularProgressIndicator());
        }
        // Map column indexes back to flat list data indexes
        final int topItemIndex = index * 2;
        final int bottomItemIndex = topItemIndex + 1;
        return Container(
          margin: const EdgeInsets.only(right: AppSpacing.s25),
          child: Column(
            children: [
              if (topItemIndex < actualItemsCount) ...[
                (() {
                  final item = accessoryType == AccessoryType.buy
                      ? state.accessories[topItemIndex]
                      : state.myAccessories[topItemIndex];
                  final isSelected = item.id == state.selectedAccessoryId;
                  return GestureDetector(
                    onTap: () {
                      context.read<AccessoriesBloc>().add(
                        SelectAccessoriesItemEvent(accessoryId: item.id),
                      );
                      onChange(item);
                    },
                    child: AccessoryItemWidget(
                      isSelected: isSelected,
                      accessory: item,
                    ),
                  );
                }()),
              ],

              const Spacer(),

              if (bottomItemIndex < actualItemsCount) ...[
                (() {
                  final item = accessoryType == AccessoryType.buy
                      ? state.accessories[bottomItemIndex]
                      : state.myAccessories[bottomItemIndex];
                  final isSelected = item.id == state.selectedAccessoryId;
                  return GestureDetector(
                    onTap: () {
                      context.read<AccessoriesBloc>().add(
                        SelectAccessoriesItemEvent(accessoryId: item.id),
                      );
                      onChange(item);
                    },
                    child: AccessoryItemWidget(
                      isSelected: isSelected,
                      accessory: item,
                    ),
                  );
                }()),
              ] else
                // Invisible placeholder layout balancer for odd-numbered endings
                const SizedBox(height: 100, width: 50),
            ],
          ),
        );
      },
    );
  }
}

class AccessoryItemWidget extends StatelessWidget {
  const AccessoryItemWidget({
    super.key,
    required this.isSelected,
    required this.accessory,
  });

  final bool isSelected;
  final Accessory accessory;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            decoration: BoxDecoration(
              color: AppColors.p1_50,
              shape: BoxShape.circle,
              border: isSelected ? Border.all(color: AppColors.a1_400) : null,
            ),
            child: ClipOval(
              child: AppIcon(
                fit: BoxFit.cover,
                accessory.imageUrl ?? '',
                height: 60.h,
                width: 60.h,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Flexible(child: AppText.h1(accessory.name, fontSize: AppFontSize.fs14)),

        Flexible(
          child: AppText.h4(
            '${accessory.currency} ${accessory.price.formatPrice()}',
            fontSize: AppFontSize.fs10,
          ),
        ),
      ],
    );
  }
}

class Accessory extends Equatable {
  final String name;
  final double price;
  final String? imageUrl;
  final String id;
  final String currency;

  const Accessory({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.id,
    required this.currency,
  });

  @override
  List<Object?> get props => [name, price, imageUrl, id, currency];
}
