import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:poochcare/core/config/app_config.dart';
import 'package:poochcare/core/network/dio_client.dart';
import 'package:poochcare/core/services/document_upload_service.dart';
import 'package:poochcare/core/services/image_upload_service.dart';
import 'package:poochcare/core/services/localization_service.dart';
import 'package:poochcare/core/services/location_permission_service.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';
import 'package:poochcare/core/services/session_reset_service.dart';
import 'package:poochcare/core/services/token_storage.dart';
import 'package:poochcare/core/store/appointments/appointments_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/cart/cart_store_bloc.dart';
import 'package:poochcare/core/store/community/community_store_bloc.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_bloc.dart';
import 'package:poochcare/core/store/pets/pets_store_bloc.dart';
import 'package:poochcare/core/store/products/products_store_bloc.dart';
import 'package:poochcare/core/store/theme/theme_store_bloc.dart';
import 'package:poochcare/core/store/videos/videos_store_bloc.dart';
import 'package:poochcare/core/sync/global_update_bus.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_bloc.dart';
import 'package:poochcare/features/auth/data/api/auth_api_service.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poochcare/features/auth/repository/auth_repository.dart';
import 'package:poochcare/features/auth/services/auth_token_manager.dart';
import 'package:poochcare/features/community/data/api/community_api_service.dart';
import 'package:poochcare/features/community/data/api/event_api_service.dart';
import 'package:poochcare/features/community/data/api/found_pet_api_service.dart';
import 'package:poochcare/features/community/data/api/missing_pet_api_service.dart';
import 'package:poochcare/features/community/data/api/tips_and_guide_api_service.dart';
import 'package:poochcare/features/community/presentation/bloc/categories/categories_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/community/community_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/events/my_live_posts_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/events/my_review_posts_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/found_pet/found_pet_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/all_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/my_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/pet_shelter/pet_shelter_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_comment_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/features/community/repository/community_repository.dart';
import 'package:poochcare/features/community/repository/event_repository.dart';
import 'package:poochcare/features/community/repository/found_pet_repository.dart';
import 'package:poochcare/features/community/repository/missing_pet_repository.dart';
import 'package:poochcare/features/community/repository/tips_and_guide_repository.dart';
import 'package:poochcare/features/ecommerce/data/api/buy_pet_api_service.dart';
import 'package:poochcare/features/ecommerce/data/api/cart_api_service.dart';
import 'package:poochcare/features/ecommerce/data/api/get_help_api_service.dart';
import 'package:poochcare/features/ecommerce/data/api/orders_api_service.dart';
import 'package:poochcare/features/ecommerce/data/api/product_api_service.dart';
import 'package:poochcare/features/ecommerce/domain/repository/buy_pet_repository.dart';
import 'package:poochcare/features/ecommerce/domain/repository/cart_repository.dart';
import 'package:poochcare/features/ecommerce/domain/repository/get_help_repository.dart';
import 'package:poochcare/features/ecommerce/domain/repository/orders_repository.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet/buy_pet_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_detail/buy_pet_detail_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/get_help/get_help_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_support/order_support_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/products_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:poochcare/features/ecommerce/repository/buy_pet_repository_impl.dart';
import 'package:poochcare/features/ecommerce/repository/cart_repository_impl.dart';
import 'package:poochcare/features/ecommerce/repository/get_help_repository_impl.dart';
import 'package:poochcare/features/ecommerce/repository/orders_repository_impl.dart';
import 'package:poochcare/features/ecommerce/repository/products_repository.dart';
import 'package:poochcare/features/expense_tracker/data/api/expense_tracker_api_service.dart';
import 'package:poochcare/features/expense_tracker/domain/repository/expense_tracker_repository.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_bloc.dart';
import 'package:poochcare/features/expense_tracker/repository/expense_tracker_repository_impl.dart';
import 'package:poochcare/features/fun/data/api/accessories_api_service.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_bloc.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_order_summary_bloc/accessories_order_summary_bloc.dart';
import 'package:poochcare/features/fun/repository/accessories_repository.dart';
import 'package:poochcare/features/home/data/api/home_api_service.dart';
import 'package:poochcare/features/home/data/api/notifications_api_service.dart';
import 'package:poochcare/features/home/data/repositories/notifications_repository.dart';
import 'package:poochcare/features/home/presentation/bloc/home_bloc.dart';
import 'package:poochcare/features/home/presentation/bloc/notifications_bloc.dart';
import 'package:poochcare/features/home/repository/home_repository.dart';
import 'package:poochcare/features/insight/data/api/clinics_api_service.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/report_symptoms_bloc/report_symptoms_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_bloc.dart';
import 'package:poochcare/features/insight/repository/clinics_repository.dart';
import 'package:poochcare/features/invites/data/api/invite_api_service.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_bloc.dart';
import 'package:poochcare/features/invites/repository/invite_repository.dart';
import 'package:poochcare/features/medical_history/data/api/medical_details_api_service.dart';
import 'package:poochcare/features/medical_history/data/api/medical_history_api_service.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_details/medical_details_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_sync_bloc.dart';
import 'package:poochcare/features/medical_history/repository/medical_details_repository.dart';
import 'package:poochcare/features/medical_history/repository/medical_history_repository.dart';
import 'package:poochcare/features/pets/data/api/pets_api_service.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_bloc.dart';
import 'package:poochcare/features/pets/repository/pets_repository.dart';
import 'package:poochcare/features/scheduler/data/api/scheduler_api_service.dart';
import 'package:poochcare/features/scheduler/domain/repository/schedule_repository.dart';
import 'package:poochcare/features/scheduler/presentation/bloc/schedule_bloc.dart';
import 'package:poochcare/features/scheduler/repository/schedule_repository_impl.dart';
import 'package:poochcare/features/settings/data/api/settings_api_service.dart';
import 'package:poochcare/features/settings/domain/repository/settings_repository.dart';
import 'package:poochcare/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:poochcare/features/settings/presentation/bloc/settings_event.dart';
import 'package:poochcare/features/settings/repository/settings_repository_impl.dart';
import 'package:poochcare/features/tricks_and_trainings/data/api/tricks_and_trainings_api_service.dart';
import 'package:poochcare/features/tricks_and_trainings/domain/repository/tricks_and_trainings_repository.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_bloc.dart';
import 'package:poochcare/features/tricks_and_trainings/repository/tricks_and_trainings_repository_impl.dart';
import 'package:poochcare/features/user_profile/data/api/user_profile_api_service.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/save_house_details_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_identifier_bloc.dart';
import 'package:poochcare/features/user_profile/repository/user_profile_repository.dart';
import 'package:poochcare/features/videos/data/api/video_api_service.dart';
import 'package:poochcare/features/videos/presentation/bloc/videos_bloc.dart';
import 'package:poochcare/features/videos/repository/videos_repository.dart';

final GetIt getIt = GetIt.instance;

void setupDI() {
  if (getIt.isRegistered<AuthStoreBloc>()) {
    return;
  }

  getIt.registerLazySingleton<GlobalUpdateBus<dynamic>>(
    () => GlobalUpdateBus<dynamic>(),
  );
  // Secure storage
  getIt.registerLazySingleton<TokenStorage>(TokenStorage.new);

  // Network - use AppConfig for base URL and timeout
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      baseUrl: AppConfig.apiBaseUrl,
      tokenProvider: () => getIt<AuthTokenManager>().getValidAccessToken(),
    ),
  );

  getIt.registerLazySingleton<Dio>(() => getIt<DioClient>().dio);

  // Store Blocs — registerLazySingleton (single source of truth)
  getIt.registerLazySingleton<AuthStoreBloc>(AuthStoreBloc.new);
  getIt.registerLazySingleton<OnboardingJourneyStoreBloc>(
    OnboardingJourneyStoreBloc.new,
  );
  getIt.registerLazySingleton<PetsStoreBloc>(PetsStoreBloc.new);
  getIt.registerLazySingleton<AppointmentsStoreBloc>(AppointmentsStoreBloc.new);
  getIt.registerLazySingleton<AppointmentCubit>(AppointmentCubit.new);
  getIt.registerLazySingleton<CartStoreBloc>(CartStoreBloc.new);
  getIt.registerLazySingleton<ThemeStoreBloc>(ThemeStoreBloc.new);
  getIt.registerLazySingleton<ProductsStoreBloc>(ProductsStoreBloc.new);
  getIt.registerLazySingleton<CommunityStoreBloc>(CommunityStoreBloc.new);
  getIt.registerLazySingleton<VideosStoreBloc>(VideosStoreBloc.new);

  // Core Services — registerLazySingleton
  getIt.registerLazySingleton<ImageUploadService>(
    () => ImageUploadService(dio: getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<DocumentUploadService>(
    () => DocumentUploadService(getIt<ImageUploadService>()),
  );

  // API Services — registerLazySingleton
  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(getIt<DioClient>().dio),
  );

  // Auth token manager
  getIt.registerLazySingleton<AuthTokenManager>(
    () => AuthTokenManager(
      api: getIt<AuthApiService>(),
      storage: getIt<TokenStorage>(),
      sessionResetService: getIt<SessionResetService>(),
    ),
  );
  getIt.registerLazySingleton<HomeApiService>(
    () => HomeApiService(getIt<DioClient>().dio),
  );

  getIt.registerLazySingleton<ProductApiService>(
    () => ProductApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<BuyPetApiService>(
    () => BuyPetApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<CartApiService>(
    () => CartApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<WishlistBloc>(
    () => WishlistBloc(getIt<BuyPetRepository>()),
  );
  getIt.registerLazySingleton<OrdersApiService>(
    () => OrdersApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<GetHelpApiService>(
    () => GetHelpApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<TricksAndTrainingsApiService>(
    () => TricksAndTrainingsApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<ExpenseTrackerApiService>(
    () => ExpenseTrackerApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<ScheduleApiService>(
    () => ScheduleApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<LocalizationService>(
    () => LocalizationService(getIt<SecureStorageService>()),
  );
  getIt.registerLazySingleton<SettingsApiService>(
    () => SettingsApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<CommunityApiService>(
    () => CommunityApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<EventApiService>(
    () => EventApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<TipsAndGuideApiService>(
    () => TipsAndGuideApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<MissingPetApiService>(
    () => MissingPetApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<FoundPetApiService>(
    () => FoundPetApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<VideoApiService>(
    () => VideoApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<ClinicsApiService>(
    () => ClinicsApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<MedicalDetailsApiService>(
    () => MedicalDetailsApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<UserProfileApiService>(
    () => UserProfileApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<PetsApiService>(
    () => PetsApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<InviteApiService>(
    () => InviteApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<MedicalHistoryApiService>(
    () => MedicalHistoryApiService(getIt<DioClient>().dio),
  );
  getIt.registerLazySingleton<AccessoriesApiService>(
    () => AccessoriesApiService(getIt<DioClient>().dio),
  );

  // Repositories — registerLazySingleton
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AuthApiService>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepository(getIt<HomeApiService>()),
  );
  getIt.registerLazySingleton<PetsRepository>(
    () => PetsRepository(
      api: getIt<PetsApiService>(),
      imageUploadService: getIt<ImageUploadService>(),
      authStore: getIt<AuthStoreBloc>(),
    ),
  );
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepository(getIt<ProductApiService>()),
  );
  // getIt.registerLazySingleton<BuyPetRepository>(
  //   () => BuyPetRepositoryImpl(api: getIt<BuyPetApiService>()),
  // );
  getIt.registerLazySingleton<BuyPetRepository>(
    () => BuyPetRepositoryImpl(
      api: getIt<BuyPetApiService>(),
      petsApi: getIt<PetsApiService>(),
    ),
  );
  getIt.registerLazySingleton<GetHelpRepository>(
    () => GetHelpRepositoryImpl(getIt<GetHelpApiService>()),
  );
  getIt.registerLazySingleton<TricksAndTrainingsRepository>(
    () =>
        TricksAndTrainingsRepositoryImpl(getIt<TricksAndTrainingsApiService>()),
  );
  getIt.registerLazySingleton<ExpenseTrackerRepository>(
    () => ExpenseTrackerRepositoryImpl(getIt<ExpenseTrackerApiService>()),
  );
  getIt.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(getIt<ScheduleApiService>()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsApiService>()),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      getIt<OrdersApiService>(),
      getIt<ImageUploadService>(),
      getIt<AuthStoreBloc>(),
    ),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt<CartApiService>()),
  );
  getIt.registerLazySingleton<VideosRepository>(
    () => VideosRepository(getIt<VideoApiService>()),
  );
  getIt.registerLazySingleton<ClinicsRepository>(
    () => ClinicsRepository(getIt<ClinicsApiService>()),
  );
  getIt.registerLazySingleton<MedicalDetailsRepository>(
    () => MedicalDetailsRepository(getIt<MedicalDetailsApiService>()),
  );
  getIt.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepository(
      api: getIt<UserProfileApiService>(),
      imageUploadService: getIt<ImageUploadService>(),
    ),
  );
  getIt.registerLazySingleton<InviteRepository>(
    () => InviteRepository(getIt<InviteApiService>()),
  );
  getIt.registerLazySingleton<MedicalHistoryRepository>(
    () => MedicalHistoryRepository(getIt<MedicalHistoryApiService>()),
  );
  getIt.registerLazySingleton<AccessoriesRepository>(
    () => AccessoriesRepository(getIt<AccessoriesApiService>()),
  );

  getIt.registerLazySingleton<AccessoriesBloc>(
    () => AccessoriesBloc(getIt<AccessoriesRepository>()),
  );
  getIt.registerLazySingleton<AccessoriesOrderSummaryBloc>(
    () => AccessoriesOrderSummaryBloc(getIt<AccessoriesRepository>()),
  );

  getIt.registerLazySingleton<SettingsBloc>(
    () => SettingsBloc(
      repository: getIt<SettingsRepository>(),
      localizationService: getIt<LocalizationService>(),
    )..add(LoadSavedLanguage()),
  );

  // Feature Blocs — registerFactory (screen-scoped)
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      repository: getIt<AuthRepository>(),
      authStore: getIt<AuthStoreBloc>(),
      tokenStorage: getIt<TokenStorage>(),
      sessionResetService: getIt<SessionResetService>(),
    ),
  );
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      authStore: getIt<AuthStoreBloc>(),
      petsStore: getIt<PetsStoreBloc>(),
      appointmentsStore: getIt<AppointmentsStoreBloc>(),
      cartStore: getIt<CartStoreBloc>(),
      themeStore: getIt<ThemeStoreBloc>(),
      sessionResetService: getIt<SessionResetService>(),
      repository: getIt<HomeRepository>(),
    ),
  );
  getIt.registerFactory<ProductsBloc>(
    () => ProductsBloc(
      repository: getIt<ProductsRepository>(),
      productsStore: getIt<ProductsStoreBloc>(),
    ),
  );
  getIt.registerFactory<BuyPetBloc>(
    () => BuyPetBloc(repository: getIt<BuyPetRepository>()),
  );
  getIt.registerFactory<BuyPetDetailBloc>(
    () => BuyPetDetailBloc(repository: getIt<BuyPetRepository>()),
  );
  getIt.registerFactory<BuyPetLandingBloc>(
    () => BuyPetLandingBloc(repository: getIt<BuyPetRepository>()),
  );
  getIt.registerFactory<OrderBloc>(
    () => OrderBloc(getIt<OrderRepository>(), getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<OrderDetailBloc>(
    () => OrderDetailBloc(getIt<OrderRepository>()),
  );
  getIt.registerFactory<OrderSupportBloc>(
    () => OrderSupportBloc(getIt<OrderRepository>()),
  );
  getIt.registerFactory<GetHelpBloc>(
    () => GetHelpBloc(getIt<GetHelpRepository>()),
  );
  getIt.registerFactory<TricksAndTrainingsBloc>(
    () => TricksAndTrainingsBloc(getIt<TricksAndTrainingsRepository>()),
  );
  getIt.registerFactory<ExpenseTrackerBloc>(
    () => ExpenseTrackerBloc(getIt<ExpenseTrackerRepository>()),
  );
  getIt.registerFactory<ScheduleBloc>(
    () => ScheduleBloc(getIt<ScheduleRepository>()),
  );

  getIt.registerFactory<ClinicBloc>(
    () => ClinicBloc(getIt<ClinicsRepository>()),
  );
  getIt.registerFactory<MedicalDetailsBloc>(
    () => MedicalDetailsBloc(getIt<MedicalDetailsRepository>()),
  );
  getIt.registerFactory<SubscribedClinicsBloc>(
    () => SubscribedClinicsBloc(getIt<ClinicsRepository>()),
  );
  getIt.registerFactory<CommunityBloc>(
    () => CommunityBloc(getIt<CommunityRepository>()),
  );
  // getIt.registerFactory<EventsBloc>(
  //   () => EventsBloc(
  //     repository: getIt<EventsRepository>(),
  //     eventsStore: getIt<EventsStoreBloc>(),
  //   ),
  // );
  getIt.registerLazySingleton<CartBloc>(
    () => CartBloc(getIt<CartRepository>(), getIt<OrderRepository>()),
  );
  getIt.registerFactory<AddressBloc>(
    () => AddressBloc(getIt<CartRepository>()),
  );
  getIt.registerFactory<CouponsBloc>(
    () => CouponsBloc(getIt<CartRepository>(), getIt<AccessoriesRepository>()),
  );
  getIt.registerFactory<VideosBloc>(
    () => VideosBloc(
      repository: getIt<VideosRepository>(),
      videosStore: getIt<VideosStoreBloc>(),
    ),
  );
  getIt.registerLazySingleton<UserProfileBloc>(
    () => UserProfileBloc(
      repository: getIt<UserProfileRepository>(),
      authStore: getIt<AuthStoreBloc>(),
    ),
  );
  getIt.registerFactory<UserProfileIdentifierBloc>(
    () => UserProfileIdentifierBloc(repository: getIt<UserProfileRepository>()),
  );
  getIt.registerFactory<SaveHouseDetailsBloc>(
    () => SaveHouseDetailsBloc(repository: getIt<UserProfileRepository>()),
  );
  getIt.registerFactory<PetsBloc>(
    () => PetsBloc(getIt<PetsRepository>(), getIt<UserProfileRepository>()),
  );
  getIt.registerFactory<InviteBloc>(
    () => InviteBloc(
      repository: getIt<InviteRepository>(),
      userProfileRepository: getIt<UserProfileRepository>(),
    ),
  );
  getIt.registerFactory<MedicalHistoryFormBloc>(
    () => MedicalHistoryFormBloc(getIt<MedicalHistoryRepository>()),
  );
  getIt.registerFactory<MedicalHistoryBloc>(
    () => MedicalHistoryBloc(getIt<MedicalHistoryRepository>()),
  );
  getIt.registerLazySingleton<MedicalHistorySyncBloc>(
    MedicalHistorySyncBloc.new,
  );

  // Add git for community section here only -- Start
  getIt.registerLazySingleton<TipsAndGuideRepository>(
    () => TipsAndGuideRepository(getIt<TipsAndGuideApiService>()),
  );

  getIt.registerLazySingleton<EventRepository>(
    () => EventRepository(getIt<EventApiService>()),
  );

  getIt.registerLazySingleton<MissingPetRepository>(
    () => MissingPetRepository(getIt<MissingPetApiService>()),
  );

  getIt.registerLazySingleton<FoundPetRepository>(
    () => FoundPetRepository(getIt<FoundPetApiService>()),
  );

  getIt.registerLazySingleton<CommunityRepository>(
    () => CommunityRepository(getIt<CommunityApiService>()),
  );

  getIt.registerLazySingleton<TipsGuideBloc>(
    () => TipsGuideBloc(repository: getIt<TipsAndGuideRepository>()),
  );
  getIt.registerFactory<TipsCommentBloc>(
    () => TipsCommentBloc(repository: getIt<TipsAndGuideRepository>()),
  );
  getIt.registerLazySingleton<EventsBloc>(
    () => EventsBloc(repository: getIt<EventRepository>()),
  );

  getIt.registerLazySingleton<MyLivePostsBloc>(
    () => MyLivePostsBloc(communityRepository: getIt<CommunityRepository>()),
  );

  getIt.registerLazySingleton<MyReviewPostsBloc>(
    () => MyReviewPostsBloc(communityRepository: getIt<CommunityRepository>()),
  );

  getIt.registerLazySingleton<MyMissingPetsBloc>(
    () => MyMissingPetsBloc(repository: getIt<MissingPetRepository>()),
  );

  getIt.registerLazySingleton<AllMissingPetsBloc>(
    () => AllMissingPetsBloc(repository: getIt<MissingPetRepository>()),
  );

  getIt.registerLazySingleton<FoundPetBloc>(
    () => FoundPetBloc(repository: getIt<FoundPetRepository>()),
  );

  getIt.registerLazySingleton<PetShelterBloc>(
    () => PetShelterBloc(repository: getIt<CommunityRepository>()),
  );

  getIt.registerFactory<CategoriesBloc>(
    () => CategoriesBloc(
      repository: getIt<CommunityRepository>(),
      store: getIt<CommunityStoreBloc>(),
    ),
  );

  getIt.registerSingleton<SecureStorageService>(SecureStorageService());
  getIt.registerLazySingleton<AppointmentBloc>(
    () => AppointmentBloc(getIt<ClinicsRepository>()),
  );

  getIt.registerLazySingleton<LocationPermissionService>(
    () => LocationPermissionService(getIt<SecureStorageService>()),
  );

  getIt.registerLazySingleton<ReportSymptomsBloc>(
    () => ReportSymptomsBloc(getIt<ClinicsRepository>()),
  );

  getIt.registerLazySingleton<NotificationApiService>(
    () => NotificationApiService(getIt<DioClient>().dio),
  );

  getIt.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepository(getIt<NotificationApiService>()),
  );
  getIt.registerLazySingleton<NotificationBloc>(
    () => NotificationBloc(getIt<NotificationsRepository>()),
  );

  getIt.registerLazySingleton<SessionResetService>(
    () => SessionResetService(
      tokenStorage: getIt<TokenStorage>(),
      authStore: getIt<AuthStoreBloc>(),
      userProfileBloc: getIt<UserProfileBloc>(),
      petsStore: getIt<PetsStoreBloc>(),
      appointmentsStore: getIt<AppointmentsStoreBloc>(),
      cartStore: getIt<CartStoreBloc>(),
      productsStore: getIt<ProductsStoreBloc>(),
      communityStore: getIt<CommunityStoreBloc>(),
      videosStore: getIt<VideosStoreBloc>(),
      medicalHistorySyncBloc: getIt<MedicalHistorySyncBloc>(),
      localizationService: getIt<LocalizationService>(),
    ),
  );
}
