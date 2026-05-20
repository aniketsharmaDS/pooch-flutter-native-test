# Store Integration Manual (Reusable Steps)

Use this document when working manually with stores in three real scenarios:

1. New store for a new feature
2. New store added to an existing screen flow
3. Existing store reused in another screen

Example names used below:

- New store: MedicalHistoryStoreBloc
- Existing screen: Home
- Extension screen: Profile or Details

---

## Common Rules (Always)

- StoreBlocs are app source-of-truth and should be lazy singletons.
- Feature Blocs are screen-scoped and should be factories.
- UI reads data from stores via BlocSelector or BlocBuilder.
- Feature Bloc writes data into stores via store events.
- Keep data flow as:

UI -> Feature Bloc -> Repository -> API Service -> Mapper -> Store Bloc -> UI

---

## Scenario A: New Store for a New Feature

Use this when both feature and store are new.

### Steps

1) Create feature folders (if not present)

- features/medical_history/data/api
- features/medical_history/data/models
- features/medical_history/data/mappers
- features/medical_history/domain/models
- features/medical_history/repository
- features/medical_history/presentation/bloc
- features/medical_history/presentation/view
- features/medical_history/presentation/widgets

2) Create new store files in core layer

- lib/core/store/medical_history/medical_history_store_event.dart
- lib/core/store/medical_history/medical_history_store_state.dart
- lib/core/store/medical_history/medical_history_store_bloc.dart

3) Register new store in DI

Update [lib/core/di/service_locator.dart](lib/core/di/service_locator.dart):

- Add store import
- Register lazy singleton

Example:

```dart
getIt.registerLazySingleton<MedicalHistoryStoreBloc>(
  MedicalHistoryStoreBloc.new,
);
```

4) Add app-level provider

Update [lib/app.dart](lib/app.dart) top MultiBlocProvider:

```dart
BlocProvider<MedicalHistoryStoreBloc>.value(
  value: getIt<MedicalHistoryStoreBloc>(),
),
```

5) Create API service + repository for the new feature

- Register API as lazy singleton in DI
- Register repository as lazy singleton in DI

6) Create feature bloc for new feature

- Inject repository and needed store(s)
- Register feature bloc as factory in DI

7) Build feature screen

- Provide feature bloc at screen route
- Dispatch load event
- Render data from store state

8) Validate

Run:

```bash
flutter analyze --no-pub
```

---

## Scenario B: New Store Added to Existing Screen (Home)

Use this when Home already exists but now needs one more store.

### Steps

1) Create new store files in core/store

- event, state, bloc files for the new store

2) Register store in DI

Update [lib/core/di/service_locator.dart](lib/core/di/service_locator.dart):

- import new store bloc
- add lazy singleton registration

3) Add provider in app-level tree

Update [lib/app.dart](lib/app.dart):

- add BlocProvider.value for new store

4) Inject store into HomeBloc

Update [lib/features/home/presentation/bloc/home_bloc.dart](lib/features/home/presentation/bloc/home_bloc.dart):

- add constructor parameter required NewStoreBloc newStore
- add private field
- dispatch store event in relevant handler (usually HomeDataRequested)

5) Update HomeBloc factory wiring

Update [lib/core/di/service_locator.dart](lib/core/di/service_locator.dart) HomeBloc factory:

- pass newStore: getIt<NewStoreBloc>()

6) Read store in Home widgets/screen

- use BlocSelector or BlocBuilder in Home widget tree

7) Validate

```bash
flutter analyze --no-pub
```

### Quick failure checklist for Scenario B

- App crash at startup: likely missing registration in DI
- Error creating HomeBloc: likely missing factory argument
- UI not updating: likely store event not dispatched or selector wrong

---

## Scenario C: Existing Store Added to an Extension Screen

Use this when store already exists, but a new screen now needs that same store.

Example: PetsStoreBloc already exists, Profile screen now also reads pet data.

### Steps

1) Do not create a new store

- Reuse existing store type from core/store

2) Confirm store is app-level provided

Check [lib/app.dart](lib/app.dart) top MultiBlocProvider includes that store.

3) Use existing store inside extension screen

- Read state using BlocSelector or context.select
- If needed, dispatch events to same store from extension screen bloc

4) Inject into extension feature bloc only if required

If extension screen has FeatureBloc that writes to store:

- add required ExistingStoreBloc parameter in that feature bloc
- wire it in DI factory for that feature bloc

5) Validate no duplicate source-of-truth

- Do not register same store type again
- Do not create local duplicate store instance

6) Validate

```bash
flutter analyze --no-pub
```

### Quick failure checklist for Scenario C

- Data mismatch between screens: duplicate store instance created locally
- Event works in one screen only: extension screen not using app-level store
- Runtime DI error: factory not updated for extension feature bloc

---

## Copy-Paste Mini Templates

### Template 1: Register new store

```dart
// service_locator.dart
import 'package:pooch/core/store/<name>/<name>_store_bloc.dart';

getIt.registerLazySingleton<<Name>StoreBloc>(<Name>StoreBloc.new);
```

### Template 2: App-level provider

```dart
// app.dart
BlocProvider<<Name>StoreBloc>.value(
  value: getIt<<Name>StoreBloc>(),
),
```

### Template 3: Add to existing feature bloc constructor

```dart
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required ExistingAStoreBloc aStore,
    required ExistingBStoreBloc bStore,
    required NewStoreBloc newStore,
    required HomeRepository repository,
  })  : _aStore = aStore,
        _bStore = bStore,
        _newStore = newStore,
        _repository = repository,
        super(const HomeState());

  final NewStoreBloc _newStore;
}
```

### Template 4: Update factory wiring

```dart
getIt.registerFactory<HomeBloc>(
  () => HomeBloc(
    aStore: getIt<ExistingAStoreBloc>(),
    bStore: getIt<ExistingBStoreBloc>(),
    newStore: getIt<NewStoreBloc>(),
    repository: getIt<HomeRepository>(),
  ),
);
```

---

## Final Manual Checklist (Use Every Time)

1. Decide which scenario applies: A, B, or C.
2. Update DI registration in [lib/core/di/service_locator.dart](lib/core/di/service_locator.dart).
3. Update app-level providers in [lib/app.dart](lib/app.dart) if needed.
4. Update feature bloc constructor and private fields if needed.
5. Update feature bloc factory wiring in DI.
6. Dispatch correct store events from feature bloc.
7. Read store state in screen/widget with BlocSelector.
8. Run analyzer and fix only relevant issues.
