import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/my_missing_pets_bloc.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class MissingBiometricPetNotFoundScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final String reportId;

  const MissingBiometricPetNotFoundScreen({super.key, required this.reportId});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyMissingPetsBloc>.value(
          value: getIt<MyMissingPetsBloc>(),
        ),
      ],
      child: this,
    );
  }

  @override
  State<MissingBiometricPetNotFoundScreen> createState() =>
      _MissingBiometricPetNotFoundScreenState();
}

class _MissingBiometricPetNotFoundScreenState
    extends State<MissingBiometricPetNotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope<bool>(
      // canPop: false,
      // onPopInvokedWithResult: (didPop, result) {
      //   // if (didPop) return;
      //   // _handleBack();
      // },
      child: AppPrimaryBgContainer(
        // onBack: _handleBack,
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          child:
              BlocBuilder<MyMissingPetsBloc, PaginationState<MissingPetModel>>(
                builder: (context, state) {
                  // final item = state.selectedItem;
                  return TransitionScreen(
                    variant: TransitionScreenVariant.noMatchFound,
                    onPrimaryPressed: () {
                      // Navigator.pop(context);
                      // context.router.replace(const OrdersListingRoute());
                      context.pushRoute<bool>(const PoochPetShelterListRoute());
                    },

                    onSecondaryPressed: () {
                      // Navigator.pop(context);
                      // context.router.replace(TrackOrderRoute(order: order));
                      context.pushRoute<bool>(
                        AllMissingPoochListRoute(
                          listType: 'biometric_not_found',
                        ),
                      );
                    },
                  );
                },
              ),
        ),
      ),
    );
  }
}
