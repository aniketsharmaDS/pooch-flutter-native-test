# 🔐 Login Flow Documentation

## Overview

This document explains the complete flow when a user clicks the login button in PoochPetCare app - from UI action to API response.

---

## 1️⃣ **LOGIN FLOW DIAGRAM**

```
┌─────────────────────────────────────────────────────────────────┐
│ USER CLICKS LOGIN BUTTON                                        │
└────────────────────┬────────────────────────────────────────────┘
                     │
                     ▼
     ┌────────────────────────────────────┐
     │  LoginScreen._submit()              │
     │  (lib/features/auth/presentation/  │
     │   view/login_screen.dart)          │
     └────────────┬───────────────────────┘
                  │ 1. Validates form
                  │ 2. Gets email & password
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  AuthBloc.add(LoginRequested)       │
     │  (lib/features/auth/presentation/  │
     │   bloc/auth_bloc.dart)             │
     └────────────┬───────────────────────┘
                  │ 3. Emits status:loading
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  _onLoginRequested() handles event  │
     │  in AuthBloc                        │
     └────────────┬───────────────────────┘
                  │ 4. Calls repository
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  AuthRepository.login()             │
     │  (lib/features/auth/repository/    │
     │   auth_repository.dart)            │
     └────────────┬───────────────────────┘
                  │ 5. Calls API service
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  AuthApiService.login()             │
     │  (lib/features/auth/data/api/      │
     │   auth_api_service.dart)           │
     └────────────┬───────────────────────┘
                  │ 6. Makes HTTP request
                  │    using Dio
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  DioClient (Network Layer)          │
     │  - AuthInterceptor (adds token)     │
     │  - LoggingInterceptor (logs)        │
     │  - ErrorInterceptor (handles err)   │
     │                                     │
     │  (lib/core/network/dio_client.dart)│
     └────────────┬───────────────────────┘
                  │ 7. HTTP GET/POST
                  │    to API endpoint
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  API SERVER                        │
     │  https://dev-api.pooch.app/login   │
     └────────────┬───────────────────────┘
                  │ 8. Returns response
                  │    {
                  │     "success": true,
                  │     "data": {...},
                  │     "message": "..."
                  │    }
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  ErrorInterceptor processes        │
     │  response                          │
     └────────────┬───────────────────────┘
                  │ 9. Returns UserResponse
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  UserMapper.toDomain()              │
     │  (lib/features/auth/data/          │
     │   mappers/user_mapper.dart)        │
     │                                     │
     │  Converts:                         │
     │   UserResponse → User (domain)     │
     └────────────┬───────────────────────┘
                  │ 10. Returns User object
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  AuthRepository returns User       │
     └────────────┬───────────────────────┘
                  │ 11. Back to AuthBloc
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  AuthStoreBloc.add(UserSignedIn)   │
     │  (lib/core/store/auth/            │
     │   auth_store_bloc.dart)           │
     │                                     │
     │  Stores user in global state       │
     └────────────┬───────────────────────┘
                  │ 12. Store bloc updates
                  │     global user state
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  AuthBloc emits                    │
     │  status: AuthStatus.success        │
     └────────────┬───────────────────────┘
                  │ 13. UI rebuilds
                  │
                  ▼
     ┌────────────────────────────────────┐
     │  LoginScreen listens to AuthBloc   │
     │  - Detects status.success          │
     │  - BlocListener triggers navigation│
     │  - Navigate to HomeScreen          │
     └────────────────────────────────────┘
                  │
                  ▼
            🎉 USER LOGGED IN
            App navigates to Home
```

---

## 2️⃣ **DETAILED STEP-BY-STEP BREAKDOWN**

### **Step 1: User Action (UI Layer)**
**File:** [lib/features/auth/presentation/view/login_screen.dart](lib/features/auth/presentation/view/login_screen.dart)

```dart
void _submit() {
  if (!(_formKey.currentState?.validate() ?? false)) {
    return;  // Form validation failed
  }

  // Read AuthBloc and trigger login event
  context.read<AuthBloc>().add(
    LoginRequested(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    ),
  );
}
```

**What happens:**
- Form validates email & password
- Creates `LoginRequested` event
- Adds event to `AuthBloc`

---

### **Step 2: Bloc Receives Event (Presentation Layer)**
**File:** [lib/features/auth/presentation/bloc/auth_bloc.dart](lib/features/auth/presentation/bloc/auth_bloc.dart)

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository repository,
    required AuthStoreBloc authStore,
  }) : _repository = repository,
       _authStore = authStore,
       super(const AuthState()) {
    on<LoginRequested>(_onLoginRequested);  // ← Register handler
  }
```

**Constructor registers event handler:**
- `on<LoginRequested>(_onLoginRequested)` = When LoginRequested event comes, call `_onLoginRequested()`

---

### **Step 3: Event Handler Processes Request**
**File:** [lib/features/auth/presentation/bloc/auth_bloc.dart](lib/features/auth/presentation/bloc/auth_bloc.dart#L29)

```dart
Future<void> _onLoginRequested(
  LoginRequested event,
  Emitter<AuthState> emit,
) async {
  // Step A: Emit loading state
  emit(state.copyWith(status: AuthStatus.loading, clearError: true));

  try {
    // Step B: Call repository
    final User user = await _repository.login(
      email: event.email,
      password: event.password,
    );
    
    // Step C: Update global state
    _authStore.add(UserSignedIn(user));
    
    // Step D: Emit success state
    emit(state.copyWith(status: AuthStatus.success));
    
  } on ApiException catch (error) {
    // Step E: Handle API errors
    emit(state.copyWith(
      status: AuthStatus.failure,
      errorMessage: error.message,
    ));
  } catch (_) {
    // Step F: Handle unexpected errors
    emit(state.copyWith(
      status: AuthStatus.failure,
      errorMessage: 'Login failed. Please try again.',
    ));
  }
}
```

**Flow:**
1. Emit `loading` state → UI shows loading spinner
2. Call Repository to get user
3. Update AuthStoreBloc (global state)
4. Emit `success` state → UI navigates away
5. On error, emit `failure` state with message → UI shows error

---

### **Step 4: Repository Calls API (Data Layer)**
**File:** [lib/features/auth/repository/auth_repository.dart](lib/features/auth/repository/auth_repository.dart)

```dart
class AuthRepository {
  const AuthRepository(this._api);
  final AuthApiService _api;

  Future<User> login({
    required String email,
    required String password,
  }) async {
    // Call API service
    final response = await _api.login(email: email, password: password);
    
    // Map response to domain model
    return UserMapper.toDomain(response);
  }
}
```

**Responsibility:**
- Bridge between business logic (Bloc) and network (API)
- Calls API Service
- Maps response to domain model

---

### **Step 5: API Service Makes HTTP Request**
**File:** [lib/features/auth/data/api/auth_api_service.dart](lib/features/auth/data/api/auth_api_service.dart)

```dart
class AuthApiService {
  const AuthApiService(this._dio);
  final Dio _dio;

  Future<UserResponse> login({
    required String email,
    required String password,
  }) async {
    // Currently using mock data (development)
    final Map<String, dynamic> raw = <String, dynamic>{
      'success': true,
      'message': 'Login successful',
      'status': 200,
      'data': <String, dynamic>{
        'id': 'u_1',
        'name': 'Pooch User',
        'email': email.trim(),
      },
    };
    
    // Parse into ApiResponse wrapper
    final ApiResponse<UserResponse> envelope = ApiResponse.fromJson(
      raw,
      (data) => UserResponse.fromJson(data as Map<String, dynamic>),
    );
    
    return envelope.data;
  }
}
```

**When real API is connected:**
```dart
Future<UserResponse> login({
  required String email,
  required String password,
}) async {
  final response = await _dio.post(
    '/auth/login',
    data: {
      'email': email,
      'password': password,
    },
  );
  
  final ApiResponse<UserResponse> envelope = ApiResponse.fromJson(
    response.data,
    (data) => UserResponse.fromJson(data),
  );
  
  return envelope.data;
}
```

---

### **Step 6: Dio Client with Interceptors**
**File:** [lib/core/network/dio_client.dart](lib/core/network/dio_client.dart)

```dart
class DioClient {
  DioClient({required String baseUrl, required String? Function() tokenProvider})
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
            headers: const <String, String>{
              'Content-Type': 'application/json',
            },
          ),
        ) {
    // Add interceptors in order
    dio.interceptors.addAll(<Interceptor>[
      AuthInterceptor(tokenProvider: tokenProvider),     // 1. Add auth token
      LoggingInterceptor(),                              // 2. Log requests
      ErrorInterceptor(),                                // 3. Handle errors
    ]);
  }
}
```

**Interceptor Order & Purpose:**

| # | Interceptor | Purpose | Example |
|---|-------------|---------|---------|
| 1 | **AuthInterceptor** | Adds `Authorization: Bearer <token>` header | Authenticates protected endpoints |
| 2 | **LoggingInterceptor** | Logs all requests/responses (debug only) | `[REQ] GET /users` |
| 3 | **ErrorInterceptor** | Handles 401, 500, timeouts, etc. | Triggers re-login on 401 |

---

### **Step 7: Mapper Converts Response to Domain Model**
**File:** [lib/features/auth/data/mappers/user_mapper.dart](lib/features/auth/data/mappers/user_mapper.dart)

```dart
class UserMapper {
  static User toDomain(UserResponse response) => User(
    id: response.id,
    name: response.name,
    email: response.email,
  );
}
```

**Why Mapper?**
- API Response (`UserResponse`) contains all fields from server
- Domain Model (`User`) contains only app-relevant fields
- Mapper transforms: `UserResponse` → `User`

---

### **Step 8: Store Bloc Updates Global State**
**File:** [lib/core/store/auth/auth_store_bloc.dart](lib/core/store/auth/auth_store_bloc.dart)

```dart
class AuthStoreBloc extends Bloc<AuthStoreEvent, AuthStoreState> {
  AuthStoreBloc() : super(const AuthStoreState()) {
    on<UserSignedIn>(_onUserSignedIn);
  }

  void _onUserSignedIn(UserSignedIn event, Emitter<AuthStoreState> emit) {
    emit(state.copyWith(user: event.user, isAuthenticated: true));
  }
}
```

**Effect:**
- Global app state updated with logged-in user
- All widgets can access user via `BlocSelector<AuthStoreBloc, ...>`
- User persists across app lifetime

---

### **Step 9: UI Rebuilds and Navigates**
**File:** [lib/features/auth/presentation/view/login_screen.dart](lib/features/auth/presentation/view/login_screen.dart)

The LoginScreen is wrapped with `BlocListener` to detect success:

```dart
BlocListener<AuthBloc, AuthState>(
  listener: (BuildContext context, AuthState state) {
    if (state.status == AuthStatus.success) {
      // Navigate to home
      context.router.replaceAll([const HomeRoute()]);
    }
  },
  child: // ... form UI
)
```

---

## 3️⃣ **DATA STRUCTURES**

### **LoginRequested Event**
```dart
class LoginRequested extends AuthEvent {
  const LoginRequested({
    required this.email,
    required this.password,
  });
  
  final String email;
  final String password;
}
```

### **UserResponse (API Model)**
```dart
class UserResponse {
  final String id;
  final String name;
  final String email;
}
```

### **User (Domain Model)**
```dart
class User {
  final String id;
  final String name;
  final String email;
}
```

### **AuthState**
```dart
class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
  });
  
  final AuthStatus status;  // initial, loading, success, failure
  final String? errorMessage;
}
```

---

## 4️⃣ **ERROR HANDLING FLOW**

```
API Request
    ↓
Error occurs (e.g., invalid credentials)
    ↓
ErrorInterceptor catches DioException
    ↓
AuthApiService throws ApiException('Invalid credentials')
    ↓
AuthRepository doesn't catch (re-throws)
    ↓
AuthBloc._onLoginRequested() catches
    ↓
Emits AuthState.failure with errorMessage
    ↓
LoginScreen displays error in SnackBar
```

**Example:** Invalid credentials

```dart
// In AuthApiService
if (email.trim().toLowerCase() == 'fail@pooch.app') {
  throw const ApiException('Invalid credentials');
}

// In AuthBloc (catches it)
} on ApiException catch (error) {
  emit(state.copyWith(
    status: AuthStatus.failure,
    errorMessage: error.message,  // 'Invalid credentials'
  ));
}

// In LoginScreen (shows error)
ListenWhen: (previous, current) => previous.errorMessage != current.errorMessage,
listener: (context, state) {
  if (state.errorMessage != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.errorMessage!)),
    );
  }
}
```

---

## 5️⃣ **SUMMARY TABLE**

| Component | File | Responsibility |
|-----------|------|-----------------|
| **UI** | `login_screen.dart` | Display form, collect input, show errors |
| **Event** | `auth_event.dart` | `LoginRequested` triggers flow |
| **Bloc** | `auth_bloc.dart` | Handle event, manage UI state (loading/error), call repo |
| **Store** | `auth_store_bloc.dart` | Store user in global state, single source of truth |
| **Repository** | `auth_repository.dart` | Abstract API, map response to domain |
| **API Service** | `auth_api_service.dart` | HTTP requests only, no business logic |
| **Mapper** | `user_mapper.dart` | Convert API model → Domain model |
| **Network** | `dio_client.dart` | Configure Dio + interceptors |
| **Interceptors** | `auth_interceptor.dart` | Add token, log, handle errors |

---

## 6️⃣ **KEY PRINCIPLES**

✅ **Unidirectional Data Flow:**
```
UI → Event → Bloc → Repository → API → Mapper → Bloc → Store → UI
```

✅ **Separation of Concerns:**
- UI only renders and triggers events
- Bloc orchestrates business logic
- Repository abstracts network calls
- API Service only makes HTTP requests

✅ **Global State in Store:**
- User is stored once in AuthStoreBloc
- All screens access via BlocSelector
- Prevents data duplication

✅ **Error Handling:**
- API exceptions caught by Bloc
- User-friendly errors shown to UI
- Validation at each layer

---

This flow ensures a **scalable, maintainable, testable** architecture! 🚀
