import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/domain/models/user.dart';
import 'package:poochcare/core/services/session_reset_service.dart';
import 'package:poochcare/core/store/appointments/appointments_store_bloc.dart';
import 'package:poochcare/core/store/appointments/appointments_store_event.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/store/cart/cart_store_bloc.dart';
import 'package:poochcare/core/store/cart/cart_store_event.dart';
import 'package:poochcare/core/store/pets/pets_store_bloc.dart';
import 'package:poochcare/core/store/pets/pets_store_event.dart';
import 'package:poochcare/core/store/theme/theme_store_bloc.dart';
import 'package:poochcare/core/store/theme/theme_store_event.dart';
import 'package:poochcare/features/home/presentation/bloc/home_event.dart';
import 'package:poochcare/features/home/presentation/bloc/home_state.dart';
import 'package:poochcare/features/home/repository/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AuthStoreBloc authStore,
    required PetsStoreBloc petsStore,
    required AppointmentsStoreBloc appointmentsStore,
    required CartStoreBloc cartStore,
    required ThemeStoreBloc themeStore,
    required SessionResetService sessionResetService,
    required HomeRepository repository,
  }) : _authStore = authStore,
       _petsStore = petsStore,
       _appointmentsStore = appointmentsStore,
       _cartStore = cartStore,
       _themeStore = themeStore,
       _sessionResetService = sessionResetService,
       _repository = repository,
       super(const HomeState()) {
    on<HomeDataRequested>(_onHomeDataRequested);
    on<ThemeToggleRequested>(_onThemeToggleRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final AuthStoreBloc _authStore;
  final PetsStoreBloc _petsStore;
  final AppointmentsStoreBloc _appointmentsStore;
  final CartStoreBloc _cartStore;
  final ThemeStoreBloc _themeStore;
  final SessionResetService _sessionResetService;
  final HomeRepository _repository;

  Future<void> _onHomeDataRequested(
    HomeDataRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading, clearError: true));

    try {
      final data = await _repository.fetchDashboardData();
      final existingUser = _authStore.state.user;
      User? nextUser;
      if (existingUser == null) {
        nextUser = data.user;
      } else if (existingUser.id == data.user.id) {
        // Merge dashboard profile fields without clobbering auth state.
        nextUser = existingUser.copyWith(
          name: data.user.name,
          email: data.user.email,
        );
      }
      if (nextUser != null) {
        _authStore.add(UserSignedIn(nextUser));
      }
      _cartStore.add(CartUpdated(data.cart));
      _petsStore.add(PetsRefreshed(data.pets));
      _appointmentsStore.add(AppointmentsRefreshed(data.appointments));
      emit(state.copyWith(status: HomeStatus.success));
    } catch (_) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Unable to load dashboard data.',
        ),
      );
    }
  }

  void _onThemeToggleRequested(
    ThemeToggleRequested event,
    Emitter<HomeState> emit,
  ) {
    _themeStore.add(const ThemeToggled());
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<HomeState> emit,
  ) async {
    await _sessionResetService.clearSessionData();
  }
}
