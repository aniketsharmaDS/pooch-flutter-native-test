import 'package:flutter/painting.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/localization_service.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';
import 'package:poochcare/core/services/token_storage.dart';
import 'package:poochcare/core/store/appointments/appointments_store_bloc.dart';
import 'package:poochcare/core/store/appointments/appointments_store_event.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/store/cart/cart_store_bloc.dart';
import 'package:poochcare/core/store/cart/cart_store_event.dart';
import 'package:poochcare/core/store/community/community_store_bloc.dart';
import 'package:poochcare/core/store/community/community_store_event.dart';
// import 'package:poochcare/core/store/community/community_store_bloc.dart';
// import 'package:poochcare/core/store/community/community_store_event.dart';
import 'package:poochcare/core/store/pets/pets_store_bloc.dart';
import 'package:poochcare/core/store/pets/pets_store_event.dart';
import 'package:poochcare/core/store/products/products_store_bloc.dart';
import 'package:poochcare/core/store/products/products_store_event.dart';
import 'package:poochcare/core/store/videos/videos_store_bloc.dart';
import 'package:poochcare/core/store/videos/videos_store_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_sync_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';

class SessionResetService {
  SessionResetService({
    required TokenStorage tokenStorage,
    required AuthStoreBloc authStore,
    required UserProfileBloc userProfileBloc,
    required PetsStoreBloc petsStore,
    required AppointmentsStoreBloc appointmentsStore,
    required CartStoreBloc cartStore,
    required ProductsStoreBloc productsStore,
    required CommunityStoreBloc communityStore,
    required VideosStoreBloc videosStore,
    required MedicalHistorySyncBloc medicalHistorySyncBloc,
    required LocalizationService localizationService,
  }) : _tokenStorage = tokenStorage,
       _authStore = authStore,
       _userProfileBloc = userProfileBloc,
       _petsStore = petsStore,
       _appointmentsStore = appointmentsStore,
       _cartStore = cartStore,
       _productsStore = productsStore,
       _communityStore = communityStore,
       _videosStore = videosStore,
       _medicalHistorySyncBloc = medicalHistorySyncBloc,
       _localizationService = localizationService;

  final TokenStorage _tokenStorage;
  final AuthStoreBloc _authStore;
  final UserProfileBloc _userProfileBloc;
  final PetsStoreBloc _petsStore;
  final AppointmentsStoreBloc _appointmentsStore;
  final CartStoreBloc _cartStore;
  final ProductsStoreBloc _productsStore;
  final CommunityStoreBloc _communityStore;
  final VideosStoreBloc _videosStore;
  final MedicalHistorySyncBloc _medicalHistorySyncBloc;
  final LocalizationService _localizationService;

  Future<void> clearSessionData() async {
    await HydratedBloc.storage.clear();
    await _tokenStorage.clear();
    await _clearImageCache();

    _authStore.add(const UserSignedOut());
    _userProfileBloc.add(const UserProfileCleared());
    _petsStore.add(const PetsCleared());
    _appointmentsStore.add(const AppointmentsCleared());
    _cartStore.add(const CartCleared());
    _productsStore.add(const ProductsCleared());
    _communityStore.add(const CommunityCleared());
    _videosStore.add(const VideosCleared());
    _medicalHistorySyncBloc.add(const MedicalHistorySyncCleared());

    // remove all the data from the storeage
    final storage = getIt<SecureStorageService>();
    await _localizationService.setLanguage('en');
    await storage.clearAll();
  }

  Future<void> _clearImageCache() async {
    imageCache.clear();
    imageCache.clearLiveImages();
  }
}
