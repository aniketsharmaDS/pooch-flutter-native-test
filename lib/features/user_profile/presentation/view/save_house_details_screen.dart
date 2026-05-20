import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/save_house_details_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/save_house_details_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/save_house_details_state.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class SaveHouseDetailsScreen extends StatefulWidget {
  const SaveHouseDetailsScreen({
    super.key,
    required this.isMultiplePet,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
  });

  final bool isMultiplePet;
  final String? initialPhoneNumber;
  final String? initialEmail;
  final String? initialCountryCode;

  @override
  State<SaveHouseDetailsScreen> createState() => _SaveHouseDetailsScreenState();
}

class _SaveHouseDetailsScreenState extends State<SaveHouseDetailsScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final ValueNotifier<bool> _isSubmitEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(_updateSubmitState);
    _houseNameController.addListener(_updateSubmitState);
    _updateSubmitState();
  }

  @override
  void dispose() {
    _nicknameController.removeListener(_updateSubmitState);
    _houseNameController.removeListener(_updateSubmitState);
    _nicknameController.dispose();
    _houseNameController.dispose();
    _isSubmitEnabled.dispose();
    super.dispose();
  }

  bool get _showHouseNameField => widget.isMultiplePet;

  void _submit(BuildContext context) {
    final nickname = _nicknameController.text.trim();
    final houseName = _houseNameController.text.trim();

    if (nickname.isEmpty) {
      ToastService.showError('Please enter a nickname.');
      return;
    }

    if (_showHouseNameField && houseName.isEmpty) {
      ToastService.showError('Please enter a parent group name.');
      return;
    }

    final parentName = nickname;
    final parentGroupName = _showHouseNameField ? houseName : '';

    context.read<SaveHouseDetailsBloc>().add(
      SaveHouseDetailsSubmitted(
        parentName: parentName,
        houseName: parentGroupName,
        relation: 'parent',
        isMultiplePets: widget.isMultiplePet,
      ),
    );
  }

  void _updateSubmitState() {
    final nickname = _nicknameController.text.trim();
    final houseName = _houseNameController.text.trim();
    final hasNickname = nickname.isNotEmpty;
    final hasHouseName = !_showHouseNameField || houseName.isNotEmpty;

    _isSubmitEnabled.value = hasNickname && hasHouseName;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<SaveHouseDetailsBloc>()..add(const SaveHouseDetailsStarted()),
      child: Builder(
        builder: (context) => Material(
          child: BlocListener<SaveHouseDetailsBloc, SaveHouseDetailsState>(
            listenWhen: (previous, current) =>
                previous.status != current.status ||
                previous.errorMessage != current.errorMessage,
            listener: (context, state) async {
              if (state.status == SaveHouseDetailsStatus.failure) {
                ToastService.showError(
                  state.errorMessage ?? 'Something went wrong',
                );
              }

              if (state.status == SaveHouseDetailsStatus.success) {
                final authStoreBloc = context.read<AuthStoreBloc>();
                authStoreBloc.add(
                  ParentNameUpdated(name: _nicknameController.text.trim()),
                );
                authStoreBloc.add(const PetOnboardingCompleted());
                await authStoreBloc.stream.firstWhere(
                  (element) => element.user?.isPetOnboarded == true,
                );
                if (!context.mounted) {
                  return;
                }
                context.router.replaceAll([CreateParentProfileRoute()]);
              }
            },
            child: AppPrimaryBgContainer(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppSpacing.s16.hBox,
                      AppText.h3(
                        'House Details',
                        fontSize: AppFontSize.fs16,
                        color: AppColors.p4_900,
                      ),
                      AppSpacing.s24.hBox,
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                preventSpecialCharacters: true,
                                label: 'Nickname',
                                controller: _nicknameController,
                                textInputAction: TextInputAction.done,
                              ),
                              AppSpacing.s16.hBox,
                              if (_showHouseNameField) ...[
                                AppTextField(
                                  label: 'Parent group name',
                                  controller: _houseNameController,
                                  textInputAction: TextInputAction.done,
                                ),
                                AppSpacing.s16.hBox,
                              ],
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<SaveHouseDetailsBloc, SaveHouseDetailsState>(
                        buildWhen: (previous, current) =>
                            previous.status != current.status,
                        builder: (context, state) {
                          final bool isLoading =
                              state.status == SaveHouseDetailsStatus.loading;

                          return ValueListenableBuilder<bool>(
                            valueListenable: _isSubmitEnabled,
                            builder: (context, isEnabled, _) {
                              return AppButton(
                                label: 'Save House Details',
                                isLoading: isLoading,
                                onPressed: isLoading || !isEnabled
                                    ? null
                                    : () => _submit(context),
                              );
                            },
                          );
                        },
                      ),
                      AppSpacing.s16.hBox,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
