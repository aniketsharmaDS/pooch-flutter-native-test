import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poochcare/core/config/app_config.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/core/services/session_reset_service.dart';
import 'package:poochcare/core/services/token_storage.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/features/auth/domain/models/otp_verification_result.dart';
import 'package:poochcare/features/auth/domain/models/register_result.dart';
import 'package:poochcare/features/auth/domain/models/social_login_result.dart';
import 'package:poochcare/features/auth/domain/models/user.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_event.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_state.dart';
import 'package:poochcare/features/auth/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository repository,
    required AuthStoreBloc authStore,
    required TokenStorage tokenStorage,
    required SessionResetService sessionResetService,
  }) : _repository = repository,
       _authStore = authStore,
       _tokenStorage = tokenStorage,
       _sessionResetService = sessionResetService,
       super(const AuthState()) {
    on<AuthStarted>(_onAuthStarted);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
    on<FacebookLoginRequested>(_onFacebookLoginRequested);
    on<LoginWithOtpRequested>(_onLoginWithOtpRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<SendOtpCodeRequested>(_onSendOtpCodeRequested);
    on<VerifyOtpCodeRequested>(_onVerifyOtpCodeRequested);
    on<FetchUserSplashRequested>(_onFetchUserSplashRequested);
    _googleInitFuture = _initGoogleSignIn(); // Initialize Google Sign-In
  }

  late final Future<void> _googleInitFuture;

  Future<void> _initGoogleSignIn() async {
    await GoogleSignIn.instance.initialize(
      serverClientId: AppConfig.serverClientId,
    );
  }

  final AuthRepository _repository;
  final AuthStoreBloc _authStore;
  final TokenStorage _tokenStorage;
  final SessionResetService _sessionResetService;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> _onFetchUserSplashRequested(
    FetchUserSplashRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        requestType: AuthRequestType.userSplash,
        clearError: true,
      ),
    );

    try {
      final Map<String, dynamic> splashData = await _repository
          .fetchUserSplash();
      emit(
        state.copyWith(
          status: AuthStatus.success,
          requestType: AuthRequestType.userSplash,
          userSplashData: splashData,
          clearError: true,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          requestType: AuthRequestType.userSplash,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          requestType: AuthRequestType.userSplash,
          errorMessage: 'Failed to load splash content. Please try again.',
        ),
      );
    }
  }

  void _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        status: AuthStatus.initial,
        clearError: true,
        clearData: true,
      ),
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        requestType: AuthRequestType.register,
        clearError: true,
      ),
    );

    try {
      final RegisterResult result = await _repository.register(
        emailOrPhone: event.emailOrPhone,
        countryCode: event.countryCode,
      );
      emit(
        state.copyWith(
          status: AuthStatus.success,
          requestType: AuthRequestType.none,
          registerResult: result,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: error.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Registration failed. Please try again.',
        ),
      );
    }
  }

  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        requestType: AuthRequestType.googleLogin,
        clearError: true,
      ),
    );

    try {
      await _googleInitFuture; // 🔥 IMPORTANT

      GoogleSignInAccount? account = await _googleSignIn
          .attemptLightweightAuthentication();
      // account = await _googleSignIn.authenticate();
      if (account == null) {
        emit(
          state.copyWith(
            status: AuthStatus.initial,
            requestType: AuthRequestType.none,
            clearError: true,
          ),
        );
        return;
      }
      account = await _googleSignIn.authenticate();
      final auth = account.authentication;
      final idToken = auth.idToken;

      final SocialLoginResult result = await _repository.googleLogin(
        uid: account.id,
        fullName: account.displayName ?? '',
        email: account.email,
        phone: '',
        photoUrl: account.photoUrl ?? '',
        googleIdToken: idToken ?? '',
      );

      await _tokenStorage.saveTokens(result.tokens);

      final User user = User(
        id: result.user.id,
        name: result.user.name,
        email: result.user.email,
        isProfileCompleted: result.user.isProfileCompleted,
        isPetOnboarded: result.user.isPetOnboarded,
        isOnboarded: result.user.isOnboarded,
        primaryIdentifier: result.user.primaryIdentifier,
      );
      _authStore.add(const SplashCompleted());
      _authStore.add(const IntroCompleted());
      _authStore.add(UserSignedIn(user));
      emit(
        state.copyWith(
          status: AuthStatus.success,
          requestType: AuthRequestType.none,
          googleLoginResult: result,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: error.message),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Google login failed. Please try again.',
        ),
      );
    }
  }

  Future<void> _onLoginWithOtpRequested(
    LoginWithOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        requestType: AuthRequestType.loginWithOtp,
        clearError: true,
      ),
    );

    try {
      final result = await _repository.loginWithOtp(
        emailOrPhone: event.emailOrPhone,
        countryCode: event.countryCode,
      );
      emit(
        state.copyWith(
          status: AuthStatus.success,
          requestType: AuthRequestType.none,
          loginOtpResult: result,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: error.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Login failed. Please try again.',
        ),
      );
    }
  }

  Future<void> _onFacebookLoginRequested(
    FacebookLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        requestType: AuthRequestType.googleLogin,
        clearError: true,
      ),
    );

    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: <String>['email', 'public_profile'],
      );

      if (result.status != LoginStatus.success || result.accessToken == null) {
        emit(
          state.copyWith(
            status: AuthStatus.initial,
            requestType: AuthRequestType.none,
            clearError: true,
          ),
        );
        return;
      }

      // Firebase User: zblC2JTKnpMDq7xRSpFhppZPUm12
      // Name: Suryakant Yadav
      // Email: surya.15.08.86@gmail.com
      // Facebook login: Suryakant Yadav
      // Facebook login: surya.15.08.86@gmail.com

      final fb_auth.OAuthCredential credential = fb_auth
          .FacebookAuthProvider.credential(result.accessToken!.tokenString);
      final fb_auth.UserCredential userCredential = await fb_auth
          .FirebaseAuth
          .instance
          .signInWithCredential(credential);

      final fb_auth.User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw const ApiException('Facebook login failed. Please try again.');
      }

      // 🔥 Firebase ID token (for backend verification)
      final String firebaseIdToken = await firebaseUser.getIdToken() ?? '';

      // 🔥 Facebook Graph API data (important for missing email cases)
      final fbData = await FacebookAuth.instance.getUserData(
        fields: 'id,name,email,picture.width(200)',
      );

      String photoUrl =
          (fbData['picture']?['data']?['url'] ?? firebaseUser.photoURL ?? '')
              .toString();

      final SocialLoginResult loginResult = await _repository.facebookLogin(
        uid: firebaseUser.uid,
        fullName: firebaseUser.displayName ?? '',
        email: firebaseUser.email ?? '',
        phone: firebaseUser.phoneNumber ?? '',
        photoUrl: photoUrl,
        facebookIdToken: firebaseIdToken,
      );

      await _tokenStorage.saveTokens(loginResult.tokens);

      final User user = User(
        id: loginResult.user.id,
        name: loginResult.user.name,
        email: loginResult.user.email,
        isProfileCompleted: loginResult.user.isProfileCompleted,
        isPetOnboarded: loginResult.user.isPetOnboarded,
        isOnboarded: loginResult.user.isOnboarded,
        primaryIdentifier: loginResult.user.primaryIdentifier,
      );
      _authStore.add(const SplashCompleted());
      _authStore.add(const IntroCompleted());
      _authStore.add(UserSignedIn(user));

      emit(
        state.copyWith(
          status: AuthStatus.success,
          requestType: AuthRequestType.none,
          googleLoginResult: loginResult,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: error.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Facebook login failed. Please try again.',
        ),
      );
    }
  }

  Future<void> _onSendOtpCodeRequested(
    SendOtpCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        requestType: AuthRequestType.sendOtp,
        clearError: true,
      ),
    );

    try {
      final result = await _repository.sendOtpCode(
        emailOrPhone: event.emailOrPhone,
      );
      emit(
        state.copyWith(
          status: AuthStatus.success,
          requestType: AuthRequestType.none,
          otpSendResult: result,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: error.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Failed to resend OTP. Please try again.',
        ),
      );
    }
  }

  Future<void> _onVerifyOtpCodeRequested(
    VerifyOtpCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        requestType: AuthRequestType.verifyOtp,
        clearError: true,
      ),
    );

    try {
      final OtpVerificationResult result = await _repository.verifyOtpCode(
        emailOrPhone: event.emailOrPhone,
        otpCode: event.otpCode,
        type: event.type,
        deviceId: event.deviceId ?? '',
        fcmToken: event.fcmToken ?? '',
        deviceType: event.deviceType ?? '',
      );
      if (result.tokens.accessToken.isNotEmpty) {
        await _tokenStorage.saveTokens(result.tokens);
      }
      final User user = User(
        id: result.user.id,
        name: result.user.name,
        email: result.user.email,
        phone: result.user.phone,
        isProfileCompleted: result.user.isProfileCompleted,
        isPetOnboarded: result.user.isPetOnboarded,
        isOnboarded: result.user.isOnboarded,
        countryCode: result.user.countryCode,
        primaryIdentifier: result.user.primaryIdentifier,
      );

      _authStore.add(const SplashCompleted());
      _authStore.add(const IntroCompleted());
      _authStore.add(UserSignedIn(user));

      emit(state.copyWith(status: AuthStatus.success, otpResult: result));
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: error.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'OTP verification failed. Please try again.',
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        requestType: AuthRequestType.none,
        clearError: true,
      ),
    );
    try {
      // 1. Best-effort server logout (never block UI)
      try {
        await _repository.logout();
      } catch (e) {
        // ignore API failure intentionally
        // optionally log to crashlytics
      }
      // 2. ALWAYS clear local session (critical path)
      await _sessionResetService.clearSessionData();

      // 3. Hard reset auth state
      emit(
        state.copyWith(
          status: AuthStatus.initial,
          requestType: AuthRequestType.none,
          clearError: true,
          clearData: true,
        ),
      );
    } catch (e) {
      // Even if something unexpected fails, still force logout state
      await _sessionResetService.clearSessionData();
      emit(
        state.copyWith(
          status: AuthStatus.initial,
          requestType: AuthRequestType.none,
          clearError: true,
          clearData: true,
        ),
      );
    }
  }
}
