import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/enums/medical_history_record_type_filter.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
// import 'package:poochcare/core/widgets/list_items/product_list_item_card.dart';
import 'package:poochcare/core/widgets/others/image_crop_screen.dart';
import 'package:poochcare/features/appointments/data/models/appointments_response_model.dart';
import 'package:poochcare/features/appointments/presentation/view/appointments_tab_screen.dart';
import 'package:poochcare/features/auth/presentation/view/intro_screen.dart';
import 'package:poochcare/features/auth/presentation/view/login_screen.dart';
import 'package:poochcare/features/auth/presentation/view/otp_screen.dart';
import 'package:poochcare/features/auth/presentation/view/register_screen.dart';
import 'package:poochcare/features/auth/presentation/view/splash_screen.dart';
import 'package:poochcare/features/community/presentation/view/add_pet_found_screen.dart';
import 'package:poochcare/features/community/presentation/view/all_community_events_list_screen.dart';
import 'package:poochcare/features/community/presentation/view/all_community_tips_guide_list_screen.dart';
import 'package:poochcare/features/community/presentation/view/all_found_pooch_list_screen.dart';
import 'package:poochcare/features/community/presentation/view/all_missing_pooch_list_screen.dart';
import 'package:poochcare/features/community/presentation/view/community_event_details_screen.dart';
import 'package:poochcare/features/community/presentation/view/community_tab_screen.dart';
import 'package:poochcare/features/community/presentation/view/community_tips_guide_details_screen.dart';
import 'package:poochcare/features/community/presentation/view/found_pet_details_screen.dart';
import 'package:poochcare/features/community/presentation/view/missing_biometric_pet_found_screen.dart';
import 'package:poochcare/features/community/presentation/view/missing_biometric_pet_not_found_screen.dart';
import 'package:poochcare/features/community/presentation/view/missing_pet_details_screen.dart';
import 'package:poochcare/features/community/presentation/view/missing_verify_biometric_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_community_home_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_event_form_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_post_live_tab_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_post_review_tab_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_post_tab_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_posted_all_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_posted_events_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_posted_found_pets_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_posted_missing_pets_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_posted_tips_guide_screen.dart';
import 'package:poochcare/features/community/presentation/view/my_tip_guide_form_screen.dart';
import 'package:poochcare/features/community/presentation/view/pooch_parent_chat_list_screen.dart';
import 'package:poochcare/features/community/presentation/view/pooch_parent_chat_screen.dart';
import 'package:poochcare/features/community/presentation/view/pooch_pet_shelter_list_screen.dart';
import 'package:poochcare/features/community/presentation/view/report_missing_pet_form_screen.dart';
import 'package:poochcare/features/community/presentation/view/transitions/report_missing_pet_transition_screen.dart';
import 'package:poochcare/features/coupons/presentation/view/coupons_screen.dart';
import 'package:poochcare/features/ecommerce/data/models/address/address_model.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/buy_pet_detail_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/buy_pet_landing_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/buy_pet_listing_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/common_pet_listing_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/wishlist_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/add_new_address_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/cart/cart_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/get_help/get_help_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/orders/order_action_request_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/orders/order_details_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/orders/orders_listing_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/orders/request_cancellation_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/orders/track_order_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/products_tab_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/serve_tab_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/transitions/cancel_order_transition_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/transitions/delivery_complete_transition_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/view/transitions/ecommerce_transition_screen.dart';
import 'package:poochcare/features/expense_tracker/presentation/view/expense_tracker_details_screen.dart';
import 'package:poochcare/features/expense_tracker/presentation/view/expense_tracker_screen.dart';
import 'package:poochcare/features/fun/presentation/view/accessories/accessories_screen.dart';
import 'package:poochcare/features/fun/presentation/view/accessories/leaderboard_screen.dart';
import 'package:poochcare/features/fun/presentation/view/accessories/your_accessories_screen.dart';
import 'package:poochcare/features/fun/presentation/view/virtual_pet_gaming_screen.dart';
import 'package:poochcare/features/fun/presentation/widgets/accessory_order_summary_screen.dart';
// import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/product_grid_item_card.dart' hide ProductItem;
import 'package:poochcare/features/home/presentation/view/home_screen.dart';
import 'package:poochcare/features/home/presentation/view/home_tab_screen.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/view/appointments/appointment_booking_summary_screen.dart';
import 'package:poochcare/features/insight/presentation/view/appointments/appointment_payment_summary_screen.dart';
import 'package:poochcare/features/insight/presentation/view/appointments/clinic_plan_selection_screen.dart';
import 'package:poochcare/features/insight/presentation/view/appointments/clinic_slot_selection_screen.dart';
import 'package:poochcare/features/insight/presentation/view/chats/parent_vet_chat_screen.dart';
import 'package:poochcare/features/insight/presentation/view/insight_care_screen.dart';
import 'package:poochcare/features/insight/presentation/view/insight_gut_screen.dart';
import 'package:poochcare/features/insight/presentation/view/insight_pain_screen.dart';
import 'package:poochcare/features/insight/presentation/view/insight_symptoms_screen.dart';
import 'package:poochcare/features/insight/presentation/view/insight_tab_screen.dart';
import 'package:poochcare/features/insight/presentation/view/pet_appointments_history_screen.dart';
import 'package:poochcare/features/insight/presentation/view/pet_medical_history_screen.dart';
import 'package:poochcare/features/insight/presentation/view/transitions/subs_payment_failed_transition_screen.dart';
import 'package:poochcare/features/insight/presentation/view/vets/all_subscribed_clinic_screen.dart';
import 'package:poochcare/features/insight/presentation/view/vets/clinic_details_screen.dart';
import 'package:poochcare/features/insight/presentation/view/vets/clinics_listing_screen.dart';
import 'package:poochcare/features/insight/presentation/view/vets/find_vet_clinics_screen.dart';
import 'package:poochcare/features/insight/presentation/view/vets/insight_vets_screen.dart';
import 'package:poochcare/features/intro_transition/presentation/view/intro_transition_screen.dart';
import 'package:poochcare/features/invites/view/invites_screen.dart';
import 'package:poochcare/features/invites/view/my_invites/all_invites_screen.dart';
import 'package:poochcare/features/invites/view/my_invites/my_invites_screen.dart';
import 'package:poochcare/features/invites/view/my_invites/received_invites_screen.dart';
import 'package:poochcare/features/invites/view/my_invites/sent_invites_screen.dart';
import 'package:poochcare/features/invites/view/network_invites/network_all_invites_screen.dart';
import 'package:poochcare/features/invites/view/network_invites/network_invites_screen.dart';
import 'package:poochcare/features/invites/view/network_invites/network_received_invites_screen.dart';
import 'package:poochcare/features/invites/view/network_invites/network_sent_invites_screen.dart';
import 'package:poochcare/features/medical_history/presentation/view/add_pet_medical_records_tab_screen.dart';
import 'package:poochcare/features/medical_history/presentation/view/file_viewer_screen.dart';
import 'package:poochcare/features/medical_history/presentation/view/pet_medical_all_list_screen.dart';
import 'package:poochcare/features/medical_history/presentation/view/pet_medical_consultation_list_screen.dart';
import 'package:poochcare/features/medical_history/presentation/view/pet_medical_details_screen.dart';
import 'package:poochcare/features/medical_history/presentation/view/pet_medical_health_records_list_screen.dart';
import 'package:poochcare/features/medical_history/presentation/view/pet_medical_lab_report_list_screen.dart';
import 'package:poochcare/features/medical_history/presentation/view/pet_medical_other_documents_list_screen.dart';
import 'package:poochcare/features/medical_history/presentation/view/pet_medical_vaccination_list_screen.dart';
import 'package:poochcare/features/pets/presentation/view/add_pet_profile_screen.dart';
import 'package:poochcare/features/pets/presentation/view/create_pet_profile_screen.dart';
import 'package:poochcare/features/pets/presentation/view/edit_pet_profile_screen.dart';
import 'package:poochcare/features/pets/presentation/view/onboarding_successful_transition_screen.dart';
import 'package:poochcare/features/pets/presentation/view/pet_added_successful_transition_screen.dart';
// import 'package:poochcare/features/pets/presentation/view/pets_tab_screen.dart';
import 'package:poochcare/features/pets/presentation/view/select_pet_option_screen.dart';
import 'package:poochcare/features/scheduler/domain/ui_models/schedule_item_ui_model.dart';
import 'package:poochcare/features/scheduler/presentation/view/add_schedule_screen.dart';
import 'package:poochcare/features/scheduler/presentation/view/schedule_screen.dart';
import 'package:poochcare/features/settings/presentation/view/change_language_screen.dart';
import 'package:poochcare/features/settings/presentation/view/settings_screen.dart';
import 'package:poochcare/features/test_screen/app_button_screen.dart';
import 'package:poochcare/features/test_screen/app_design_screen.dart';
import 'package:poochcare/features/test_screen/app_display_screen.dart';
import 'package:poochcare/features/test_screen/app_form_screen.dart';
import 'package:poochcare/features/test_screen/app_grid_screen.dart';
import 'package:poochcare/features/test_screen/app_list_item_screen.dart';
import 'package:poochcare/features/test_screen/app_list_screen.dart';
import 'package:poochcare/features/test_screen/app_nudges_screen.dart';
import 'package:poochcare/features/test_screen/app_text_input_screen.dart';
import 'package:poochcare/features/test_screen/app_top_chip_tab_bar_screen.dart';
import 'package:poochcare/features/test_screen/app_top_tab_bar_screen.dart';
import 'package:poochcare/features/test_screen/community/events_list_screen.dart';
import 'package:poochcare/features/test_screen/community/found_pooch_list_screen.dart';
import 'package:poochcare/features/test_screen/community/missing_pooch_list_screen.dart';
import 'package:poochcare/features/test_screen/community/tips_info_list_screen.dart';
import 'package:poochcare/features/test_screen/test_design_screen.dart';
import 'package:poochcare/features/test_screen/transition_screen/transition_screen.dart';
import 'package:poochcare/features/transitions/presentation/view/appointment_transition_screen.dart';
import 'package:poochcare/features/transitions/presentation/view/configure_pooch_transition_screen.dart';
import 'package:poochcare/features/transitions/presentation/view/onboarding_transition_screen.dart';
import 'package:poochcare/features/transitions/presentation/view/order_success_transition_screen.dart';
import 'package:poochcare/features/transitions/presentation/view/purchase_success_screen.dart';
import 'package:poochcare/features/transitions/presentation/view/transition_demo_screen.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/view/fun_screen.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/view/tips/tip_details_screen.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/view/tips/tips_listing_screen.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/view/trainings/training_details_screen.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/view/trainings/trainings_listing_screen.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/view/tricks_and_training_search_screen.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/view/tricks_and_trainings_landing_screen.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/view/videos/video_details_screen.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/view/videos/videos_listing_screen.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';
import 'package:poochcare/features/user_profile/presentation/view/create_parent_profile_screen.dart';
import 'package:poochcare/features/user_profile/presentation/view/edit_parent_profile_screen.dart';
import 'package:poochcare/features/user_profile/presentation/view/save_house_details_screen.dart';
import 'package:poochcare/features/user_profile/presentation/view/user_profile_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({AuthStoreBloc? authStoreBloc})
    : _appFlowGuard = AppFlowGuard(authStoreBloc ?? getIt<AuthStoreBloc>());

  final AppFlowGuard _appFlowGuard;

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(
      page: HomeRoute.page,
      guards: <AutoRouteGuard>[_appFlowGuard],
      // path: '/',
      children: [
        AutoRoute(
          page: InsightTabRoute.page,
          path: 'insights',
          children: [
            AutoRoute(path: 'care', page: InsightCareRoute.page, initial: true),
            AutoRoute(path: 'gut', page: InsightGutRoute.page),
            AutoRoute(path: 'pain', page: InsightPainRoute.page),
            AutoRoute(path: 'symptoms', page: InsightSymptomsRoute.page),
            AutoRoute(path: 'vets', page: InsightVetsRoute.page),
          ],
        ),
        AutoRoute(page: AppointmentsTabRoute.page, path: 'appointments'),
        AutoRoute(
          page: HomeTabRoute.page,
          path: 'home',
          initial: true,
        ), // 3rd tab as default
        AutoRoute(page: ProductsTabRoute.page, path: 'products'),
        AutoRoute(
          page: ServeTabRoute.page,
          path: 'serve',
          children: [
            AutoRoute(page: BuyPetLandingRoute.page, initial: true),
            AutoRoute(page: ScheduleRoute.page),
            AutoRoute(page: ExpenseTrackerRoute.page),
            AutoRoute(page: FunRoute.page),
          ],
        ),
        AutoRoute(page: CommunityTabRoute.page, path: 'community'),
      ],
    ),
    AutoRoute(
      page: PetMedicalHistoryRoute.page,
      path: '/medical_history',
      children: [
        AutoRoute(
          path: 'all',
          page: PetMedicalAllListRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: 'consultation',
          page: PetMedicalConsultationListRoute.page,
        ),
        AutoRoute(
          path: 'vaccination',
          page: PetMedicalVaccinationListRoute.page,
        ),
        AutoRoute(path: 'lab-report', page: PetMedicalLabReportListRoute.page),
        AutoRoute(
          path: 'health-records',
          page: PetMedicalHealthRecordsListRoute.page,
        ),
        AutoRoute(
          path: 'other-documents',
          page: PetMedicalOtherDocumentsListRoute.page,
        ),
      ],
    ),
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(
      page: InvitesRoute.page,
      children: [
        AutoRoute(
          page: MyInvitesRoute.page,
          initial: true,
          children: [
            AutoRoute(page: AllInvitesRoute.page, initial: true),

            AutoRoute(page: SentInvitesRoute.page),

            AutoRoute(page: ReceivedInvitesRoute.page),
          ],
        ),
        AutoRoute(
          page: NetworkInvitesRoute.page,
          children: [
            AutoRoute(page: NetworkAllInvitesRoute.page, initial: true),

            AutoRoute(page: NetworkSentInvitesRoute.page),

            AutoRoute(page: NetworkReceivedInvitesRoute.page),
          ],
        ),
      ],
    ),
    AutoRoute(page: VirtualPetGamingRoute.page),
    AutoRoute(page: PurchaseSuccessRoute.page),
    AutoRoute(page: AccessoryOrderSummaryRoute.page),

    AutoRoute(page: LeaderboardRoute.page),
    AutoRoute(page: YourAccessoriesRoute.page),
    AutoRoute(page: AccessoriesRoute.page),
    AutoRoute(page: CouponsRoute.page),
    AutoRoute(page: CartRoute.page),
    AutoRoute(page: TransitionRoute.page),
    AutoRoute(page: AddNewAddressRoute.page),
    AutoRoute(page: IntroRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: TestDesignRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: AppButtonRoute.page), // Standalone settings screen
    AutoRoute(page: AppTextInputRoute.page), // Standalone settings screen
    AutoRoute(page: AppDisplayRoute.page), // Standalone settings screen
    AutoRoute(page: AppDesignRoute.page), // Standalone settings screen
    AutoRoute(page: AppNudgesRoute.page), // Standalone settings screen
    AutoRoute(page: AppListRoute.page), // Standalone settings screen
    AutoRoute(page: AppListItemRoute.page),
    AutoRoute(page: AllCommunityEventsListRoute.page),
    AutoRoute(page: AllCommunityTipsGuideListRoute.page),
    AutoRoute(page: AppGridRoute.page),
    AutoRoute(page: AppFormRoute.page), // Standalone settings screen
    AutoRoute(page: ImageCropRoute.page), // Standalone settings screen
    AutoRoute(page: AppTopTabBarRoute.page), //
    AutoRoute(page: AppTopChipTabBarRoute.page), //
    AutoRoute(page: IntroTransitionRoute.page),
    AutoRoute(page: TransitionDemoRoute.page),
    AutoRoute(page: OnboardingTransitionRoute.page),
    AutoRoute(page: ConfigurePoochTransitionRoute.page),
    AutoRoute(page: EcommerceTransitionRoute.page),
    AutoRoute(page: OrderSuccessTransitionRoute.page),
    AutoRoute(page: DelieveryCompleteTransitionRoute.page),
    AutoRoute(page: AppointmentTransitionRoute.page),
    AutoRoute(page: SelectPetOptionRoute.page),
    AutoRoute(page: CreatePetProfileRoute.page),
    AutoRoute(page: AddPetProfileRoute.page),
    AutoRoute(page: EditPetProfileRoute.page),
    AutoRoute(page: OnboardingSuccessfulTransitionRoute.page),
    AutoRoute(page: PetAddedSuccessfulTransitionRoute.page),
    AutoRoute(page: SaveHouseDetailsRoute.page),
    AutoRoute(page: CreateParentProfileRoute.page),
    AutoRoute(page: EditParentProfileRoute.page),
    AutoRoute(page: UserProfileRoute.page),
    AutoRoute(page: AddPetMedicalRecordsTabRoute.page),
    AutoRoute(page: BuyPetLandingRoute.page),
    AutoRoute(page: BuyPetListingRoute.page),
    AutoRoute(page: BuyPetDetailRoute.page),
    AutoRoute(page: CommonPetListingRoute.page),
    AutoRoute(page: CommunityEventDetailsRoute.page),
    AutoRoute(page: CommunityTipsGuideDetailsRoute.page),
    AutoRoute(page: FindVetClinicsRoute.page),
    AutoRoute(page: ClinicsListingRoute.page),
    AutoRoute(page: ClinicDetailsRoute.page),
    AutoRoute(page: AllSubscribedClinicsRoute.page),
    AutoRoute(page: AddScheduleRoute.page),

    AutoRoute(
      page: MyCommunityHomeRoute.page,
      path: '/my_community',
      children: [
        /// 🔹 My Posts (with nested tabs)
        AutoRoute(
          path: 'my-posts',
          page: MyPostTabRoute.page,
          children: [
            AutoRoute(path: 'all', page: MyPostedAllRoute.page, initial: true),
            AutoRoute(path: 'tips-guide', page: MyPostedTipsGuideRoute.page),
            AutoRoute(path: 'events', page: MyPostedEventsRoute.page),
            AutoRoute(
              path: 'missing-pets',
              page: MyPostedMissingPetsRoute.page,
            ),
            AutoRoute(path: 'found-pets', page: MyPostedFoundPetsRoute.page),
          ],
          initial: true,
        ),

        /// 🔹 Under Review
        AutoRoute(page: MyPostReviewTabRoute.page),

        /// 🔹 Live
        AutoRoute(page: MyPostLiveTabRoute.page),
      ],
    ),
    AutoRoute(page: MyTipGuideFormRoute.page),
    AutoRoute(page: MyEventFormRoute.page),
    AutoRoute(page: ReportMissingPetFormRoute.page),
    AutoRoute(page: MissingPetDetailsRoute.page),
    AutoRoute(page: FoundPetDetailsRoute.page),
    AutoRoute(page: AllMissingPoochListRoute.page),
    AutoRoute(page: AllFoundPoochListRoute.page),
    AutoRoute(page: ReportMissingPetTransitionRoute.page),
    AutoRoute(page: MissingVerifyBiometricRoute.page),
    AutoRoute(page: MissingBiometricPetFoundRoute.page),
    AutoRoute(page: MissingBiometricPetNotFoundRoute.page),
    AutoRoute(page: PoochPetShelterListRoute.page),
    AutoRoute(page: PoochParentChatListRoute.page),
    AutoRoute(page: PoochParentChatRoute.page),
    AutoRoute(page: AddPetFoundRoute.page),
    AutoRoute(page: ClinicSlotSelectionRoute.page),
    AutoRoute(page: AppointmentBookingSummaryRoute.page),
    AutoRoute(page: PetAppointmentsHistoryRoute.page),
    AutoRoute(page: ClinicPlanSelectionRoute.page),
    AutoRoute(page: AppointmentPaymentSummaryRoute.page),
    AutoRoute(page: SubsPaymentFailedTransitionRoute.page),
    AutoRoute(page: ParentVetChatRoute.page),
    AutoRoute(page: PetMedicalDetailsRoute.page),
    AutoRoute(page: FileViewerRoute.page),
    // AutoRoute(page: MyPostTabRoute.page),
    // AutoRoute(page: MyPostLiveTabRoute.page),
    // AutoRoute(page: MyPostReviewTabRoute.page),
    AutoRoute(page: WishlistRoute.page),
    AutoRoute(page: OrdersListingRoute.page),
    AutoRoute(page: OrderDetailsRoute.page),
    AutoRoute(page: RequestCancellationRoute.page),
    AutoRoute(page: TrackOrderRoute.page),
    AutoRoute(page: OrderActionRequestRoute.page),
    AutoRoute(page: CancelOrderTransitionRoute.page),
    AutoRoute(page: GetHelpRoute.page),
    AutoRoute(page: TricksAndTrainingsLandingRoute.page),
    AutoRoute(page: TricksAndTrainingSearchRoute.page),
    AutoRoute(page: TipsListingRoute.page),
    AutoRoute(page: TipDetailsRoute.page),
    AutoRoute(page: TrainingsListingRoute.page),
    AutoRoute(page: TrainingDetailsRoute.page),
    AutoRoute(page: VideosListingRoute.page),
    AutoRoute(page: VideoDetailsRoute.page),
    AutoRoute(page: ExpenseTrackerDetailsRoute.page),
    AutoRoute(page: ChangeLanguageRoute.page),
  ];
}

class AppFlowGuard extends AutoRouteGuard {
  final AuthStoreBloc _authStoreBloc;
  AppFlowGuard(this._authStoreBloc);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final state = _authStoreBloc.state;
    final user = state.user;

    // 1. If not authenticated, they must go to Login
    if (!state.isAuthenticated) {
      // Only redirect if they aren't already going to Login
      if (resolver.routeName == LoginRoute.name) {
        resolver.next();
      } else {
        router.push(const IntroTransitionRoute());
        resolver.next(false);
      }
      return;
    }

    if (user != null) {
      final int petCount = state.onboardingPetCount;
      final primaryIden = user.primaryIdentifier;
      final phone = user.phone;
      final countryCode = user.countryCode;
      final email = user.email;
      final isEmail = primaryIden == 'email';
      final bool isPetOnboarded = user.isPetOnboarded;
      final bool isOnboarded = user.isOnboarded;
      log('isPetOnboarded - $isPetOnboarded and isOnboarded - $isOnboarded');

      if (!isPetOnboarded) {
        if (petCount > 0) {
          router.replaceAll([
            OnboardingSuccessfulTransitionRoute(
              isMultiplePet: petCount > 1,
              initialEmail: isEmail ? email : null,
              initialPhoneNumber: isEmail ? null : phone,
              initialCountryCode: isEmail ? null : countryCode,
            ),
          ]);
        } else {
          router.replaceAll([
            OnboardingTransitionRoute(
              initialEmail: isEmail ? email : null,
              initialPhoneNumber: isEmail ? null : phone,
              initialCountryCode: isEmail ? null : countryCode,
            ),
          ]);
        }
        resolver.next(false);
        return;
      }

      if (!isOnboarded) {
        router.replaceAll([CreateParentProfileRoute()]);
        resolver.next(false);
        return;
      }

      resolver.next();
      return;
    }

    // Default: Stop navigation if state is ambiguous
    resolver.next(false);
  }
}
