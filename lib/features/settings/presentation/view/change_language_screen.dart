import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:poochcare/features/settings/presentation/bloc/settings_event.dart';
import 'package:poochcare/features/settings/presentation/bloc/settings_state.dart';
import 'package:poochcare/features/settings/presentation/widgets/language_tile.dart';

@RoutePage()
class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: BlocConsumer<SettingsBloc, SettingsState>(
            listenWhen: (previous, current) {
              return previous.currentLanguage != current.currentLanguage ||
                  previous.error != current.error;
            },
            listener: (context, state) async {
              if (state.error != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error!)));

                return;
              }

              await context.setLocale(Locale(state.currentLanguage));
            },
            builder: (context, state) {
              final selectedLanguage = state.currentLanguage;

              final languages = [
                {
                  'code': 'en',
                  'shortCode': 'EN',
                  'title': 'settings.english'.tr(),
                  'subtitle': 'English',
                },
                {
                  'code': 'ar',
                  'shortCode': 'أر',
                  'title': 'settings.arabic'.tr(),
                  'subtitle': 'العربية',
                },
              ];

              return Column(
                children: [
                  PoochScreenAppBar(title: 'settings.changeLanguage'.tr()),

                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: List.generate(languages.length, (index) {
                        final language = languages[index];
                        final languageCode = language['code']!;

                        final isSelected = selectedLanguage == languageCode;

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: LanguageTile(
                            title: language['title']!,
                            subtitle: language['subtitle']!,
                            shortCode: language['shortCode']!,
                            isSelected: isSelected,
                            onTap: () async {
                              if (isSelected) {
                                return;
                              }

                              _showLanguageChangeDialog(context, languageCode);
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  // if (state.isUpdatingLanguage)
                  //   Padding(
                  //     padding: EdgeInsets.only(bottom: 24.h),
                  //     child: const CircularProgressIndicator(),
                  //   ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showLanguageChangeDialog(
    BuildContext context,
    String languageCode,
  ) async {
    await AppDialog.show<bool>(
      context: context,
      title: 'settings.changeLanguage'.tr(),
      content: 'settings.changeLanguageConfirmation'.tr(),
      primaryLabel: 'common.confirm'.tr(),
      secondaryLabel: 'common.cancel'.tr(),
      icon: Lottie.asset(AppIcons.lottie.question, repeat: false),

      onPrimary: () async {
        final bloc = context.read<SettingsBloc>();

        bloc.add(ChangeLanguage(languageCode));

        return true;
      },
    );
  }
}
