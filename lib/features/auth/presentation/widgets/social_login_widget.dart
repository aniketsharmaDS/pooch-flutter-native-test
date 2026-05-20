import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_event.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppCircleButton(
          shadowColor: AppColors.transparent,
          icon: AppIcons.svg.social.loginGoogle,
          variant: AppCircleButtonVariant.secondary,
          size: AppCircleButtonSize.xlarge,
          bgColor: const Color(0xFFF6ECE6),
          onTap: () =>
              context.read<AuthBloc>().add(const GoogleLoginRequested()),
          iconSize: 26.h,
          preserveSvgColor: true,
        ),
        // AppSpacing.s10.wBox,
        AppCircleButton(
          shadowColor: AppColors.transparent,
          icon: AppIcons.svg.social.loginApple,
          variant: AppCircleButtonVariant.secondary,
          size: AppCircleButtonSize.xlarge,
          bgColor: const Color(0xFFF6ECE6),
          onTap: () {},
          iconSize: 26.h,
          preserveSvgColor: true,
        ),
        // AppSpacing.s10.wBox,
        AppCircleButton(
          shadowColor: AppColors.transparent,
          icon: AppIcons.svg.social.loginFacebook,
          variant: AppCircleButtonVariant.secondary,
          size: AppCircleButtonSize.xlarge,
          bgColor: const Color(0xFFF6ECE6),
          onTap: () =>
              context.read<AuthBloc>().add(const FacebookLoginRequested()),
          iconSize: 26.h,
          preserveSvgColor: true,
        ),
      ],
    );
  }
}
