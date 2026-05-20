import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_state.dart';

class CartIconWithBadge extends StatelessWidget {
  final VoidCallback? onTap;

  const CartIconWithBadge({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, int>(
      selector: (state) => state.cartCount,
      builder: (context, count) {
        return GestureDetector(
          onTap: onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: AppSpacing.s42.w,
                height: AppSpacing.s42.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFEFD),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.activeColor,
                  size: AppIconSize.is20,
                ),
              ),
              if (count > 0)
                Positioned(
                  right: 0,
                  top: -4,
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.s4.w),
                    decoration: const BoxDecoration(
                      color: AppColors.activeColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: AppText.support(
                        count > 9 ? '9+' : '$count',
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
