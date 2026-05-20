Flutter Architecture Guidelines (Feature-First + Bloc + Repository + API Service + Domain Store)

This project follows a Feature-First + Bloc + Repository + API Service + Domain Store architecture.

Goal: Build scalable, maintainable, testable Flutter apps with predictable unidirectional data flow.

This architecture is designed for medium to large Flutter applications built with Flutter using flutter_bloc.

All developers and AI tools must follow these rules.

1. Architecture Overview

The application follows strict unidirectional data flow:

UI
↓
Feature Bloc (Action Bloc)
↓
Repository
↓
API Service
↓
Mapper → Domain Model
↓
Feature Bloc
↓
Store Bloc (Domain Store)
↓
UI
Layer Responsibilities
Layer	Responsibility
UI	Render widgets, dispatch user actions
Feature Bloc	Executes feature logic, manages UI state (loading/error), calls Repository
Repository	Abstracts API calls, caching, data merging, offline support
API Service	HTTP requests, endpoints, headers, query parsing
Mapper	Converts API response models → Domain models
Store Bloc	Stores normalized global entities, acts as single source of truth
2. Core Architecture Principles
Feature-First Structure

All code is organized by feature domain, not technical layers:

features/
  auth/
  pets/
  events/
  products/
  appointments/

Rules:

Each feature must be modular, independent, self-contained.

Features must not import other feature domain models directly.

Shared domain models go in core/domain/models.

Feature Bloc vs Store Bloc
Type	Purpose
Feature Bloc	Executes feature logic, calls Repository, handles UI state (loading/error/pagination)
Store Bloc	Stores normalized domain entities, acts as global single source of truth

Example:

PetsBloc → fetch pets from Repository
PetsStoreBloc → stores pets in normalized state

Feature Blocs: perform operations, manage UI state.

Store Blocs: store domain entities only, immutable state updates.

Single Source of Truth

All domain entities must exist only in Store Blocs.

UI must never store domain entities locally.

Examples:

AuthStoreBloc → user
PetsStoreBloc → pets
EventsStoreBloc → events
CartStoreBloc → cart
3. Project Structure
lib/

core/
  constants/
  di/                 # Dependency injection (get_it)
  errors/
  extensions/
  network/            # Dio setup, interceptors, ApiResponse
  router/             # AutoRoute configuration
  services/           # shared services
  store/              # global Store Blocs
  theme/
  utils/
  widgets/            # reusable widgets

features/
  auth/
  home/
  pets/
  appointments/
  products/
  community/
  events/
  telemedicine/
4. Feature Folder Structure

Each feature must follow:

features/feature_name/
  data/
    api/              # API services
    models/           # Response models
    mappers/          # API → Domain mappers
  domain/
    models/           # Domain entities
  repository/
    feature_repository.dart
  presentation/
    bloc/
    view/
    widgets/

Example: Pets Feature

features/pets/
  data/
    api/pet_api_service.dart
    models/pet_response.dart
    mappers/pet_mapper.dart
  domain/models/pet.dart
  repository/pets_repository.dart
  presentation/
    bloc/pets_bloc.dart
    view/pets_screen.dart
    widgets/pet_tile.dart
5. Data Flow Rules

Data must always flow in one direction:

UI
↓
Feature Bloc
↓
Repository
↓
API Service
↓
Mapper → Domain Model
↓
Feature Bloc
↓
Store Bloc
↓
UI

Steps:

UI triggers event.

Feature Bloc executes logic, manages UI state.

Repository handles API calls, caching, and data preparation.

API Service fetches raw data.

Mapper converts API responses → domain models.

Store Bloc updates global normalized entities.

UI listens to Store Bloc for updated state.

6. Forbidden Patterns
UI → API Service
UI → HTTP requests
Widgets calling APIs
Business logic inside widgets
Feature Bloc calling another Feature API
UI modifying Store Bloc state
Feature → Feature direct communication

All inter-feature communication must happen via Store Blocs.

7. Repository Layer

Feature Blocs must call Repository, not API Service directly.

Responsibilities

Abstract API calls.

Handle caching and offline support.

Combine multiple API responses.

Convert API models to domain models.

Prepare clean data for Feature Bloc.

Example:

class PetsRepository {
  final PetApiService api;

  PetsRepository(this.api);

  Future<List<Pet>> fetchPets() async {
    final response = await api.getPets();
    return response.map(PetMapper.fromResponse).toList();
  }
}
8. API Service Rules

Location: features/feature/data/api/

Responsibilities:

HTTP requests, endpoints, headers, query params

Response parsing

Must NOT:

Contain business logic

Manage state

Contain UI logic

Convert API models → domain models (done in Repository/Mapper)

Example:

class PetApiService {
  final Dio _dio;
  PetApiService(this._dio);

  Future<List<PetResponse>> getPets() async {
    final response = await _dio.get('/pets');
    return (response.data as List)
        .map((e) => PetResponse.fromJson(e))
        .toList();
  }
}
8.1 Standard API Response

All API responses follow:

{
  "success": true,
  "message": "Human-readable status message",
  "status": 200,
  "data": { ... }
}
class ApiResponse<T> {
  final bool success;
  final String message;
  final int status;
  final T data;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromData,
  );
}
9. Domain Models

Location: features/feature/domain/models/

Feature-local entities: features/feature/domain/models/

Shared entities: core/domain/models/

Must not depend on API models

Example:

class Pet {
  final String id;
  final String name;
  final int age;

  const Pet({
    required this.id,
    required this.name,
    required this.age,
  });
}
10. Mappers

Convert API response → Domain Model.

Flow:

API → Response Model → Mapper → Domain Model

Example:

class PetMapper {
  static Pet fromResponse(PetResponse response) {
    return Pet(
      id: response.id,
      name: response.name,
      age: response.age ?? 0,
    );
  }
}

Important: API models must never leave the data layer.

11. Feature Bloc Responsibilities

Call Repository (not API directly)

Manage loading/success/error states

Convert API responses → domain models (via Repository/Mapper)

Update Store Blocs via events

Must NOT:

Store global entities

Depend on other Feature Blocs

Contain UI logic

Lifecycle: Feature Blocs are screen-scoped, Store Blocs are app-wide.

12. Store Blocs (Domain Stores)

Own and mutate global normalized domain state

Location: core/store/

Expose global state

Act as single source of truth

Must NOT:

Call APIs

Contain business logic

Depend on Feature Blocs

Example update:

petsStoreBloc.add(PetsUpserted(pets));
13. UI State vs Domain State

Domain State (Store Bloc):
User, Pets, Events, Products, Cart

UI State (Feature Bloc):
loading, error messages, pagination, selected tab, form validation, dialogs

Domain entities must never live in Feature Bloc state.

14. Entity Store Pattern

Normalized storage:

Map<String, Pet> petsById
List<String> petIds

O(1) lookup

Prevent duplicates

Efficient updates

Pagination-friendly

Always use UPSERT operations:

petsById[pet.id] = pet;
15. UI Data Access

BlocSelector → read specific data from Store Bloc

BlocBuilder → rebuild UI from Feature Bloc state

BlocListener → handle side effects

Example:

BlocSelector<PetsStoreBloc, PetsStoreState, List<Pet>>(
  selector: (state) =>
      state.petIds.map((id) => state.petsById[id]!).toList(),
  builder: (context, pets) {
    return PetListWidget(pets);
  },
)
16. Dependency Injection

Use get_it:

API Services → registerLazySingleton

Store Blocs → registerLazySingleton

Feature Blocs → registerFactory

Example:

getIt.registerLazySingleton(() => PetsStoreBloc());

getIt.registerFactory(
  () => PetsBloc(
    repository: getIt<PetsRepository>(),
    storeBloc: getIt<PetsStoreBloc>(),
  ),
);
17. Networking

All networking uses Dio

Location: core/network/

Required:

Base URL

Auth headers

Logging interceptor

Error handling

Token refresh

18. UI Rules

Remain stateless where possible

Contain presentation logic only

Trigger Bloc events

Must NOT:

Call APIs

Store business logic

Modify Store Bloc state directly

19. Preventing Bloc Explosion

Blocs represent features, not screens

Incorrect: PetListBloc, PetDetailsBloc

Correct: PetsBloc

Use events for actions: FetchPets, CreatePet, UpdatePet, DeletePet

20. Reusable Components

Core widgets: core/widgets/ → AppButton, AppCard, AppText, AppLoader, AppNetworkImage

Feature widgets: features/feature/presentation/widgets/

21. Performance Rules

Use const constructors

Avoid large rebuilds

Split large widgets

Use BlocSelector when needed

Recommended file size: 300–400 lines

22. Naming Conventions
Files        → snake_case
Classes      → PascalCase
Variables    → camelCase
Private vars → _prefix
23. Cross Feature Communication

Features must not directly depend on each other

Allowed: feature → core/domain/models

Not Allowed: feature_a → feature_b/domain/models

Flow:

Feature Bloc
↓
Store Bloc
↓
Other Feature reacts
24. Error Handling

Convert all errors into Feature Bloc states

UI must use BlocListener for error display

Example:

try {
  final pets = await repository.fetchPets();
  petsStoreBloc.add(PetsUpserted(pets));
  emit(state.copyWith(loading: false));
} catch (e) {
  emit(state.copyWith(
    loading: false,
    error: "Failed to load pets",
  ));
}
25. Store Bloc Initialization

Store Blocs initialized at app startup

Live for entire app lifecycle

Feature Blocs are screen-scoped

Example:

MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => getIt<AuthStoreBloc>()),
    BlocProvider(create: (_) => getIt<PetsStoreBloc>()),
    BlocProvider(create: (_) => getIt<EventsStoreBloc>()),
  ],
  child: const MyApp(),
);
26. Testing Guidelines

Unit tests for Feature Bloc, Store Bloc, Repository, API Services

Widget tests with BlocBuilder / BlocSelector

Mock API responses with mockito or http_mock_adapter

Verify normalized state updates

Ensure Feature Bloc → Repository → API → Mapper flow works correctly

27. Final Architecture
UI
↓
Feature Bloc
↓
Repository
↓
API Service
↓
Mapper → Domain Model
↓
Feature Bloc
↓
Store Bloc
↓
UI

Key Benefits:

Scalable Flutter apps

Predictable unidirectional data flow

High-performance UI updates

Modular, maintainable large codebase

Repository layer abstraction

Normalized domain entities

Consistent state management