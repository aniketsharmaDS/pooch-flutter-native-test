# Architecture Compliance Checklist

Use this checklist in PR reviews to verify alignment with `docs/architecture_rules.md`.

## 1) Feature Structure

- [ ] Feature follows folder layout:
  - [ ] `data/api/`
  - [ ] `data/models/`
  - [ ] `data/mappers/`
  - [ ] `domain/models/`
  - [ ] `repository/`
  - [ ] `presentation/bloc/`
  - [ ] `presentation/view/`
  - [ ] `presentation/widgets/`
- [ ] No cross-feature domain imports (`feature_a` does not import `feature_b/domain/...`).
- [ ] Shared entities are imported from `core/domain/models/`.

## 2) Data Flow

- [ ] Flow is strictly: `UI -> Feature Bloc -> Repository -> API Service -> Mapper -> Store Bloc -> UI`.
- [ ] UI dispatches bloc events only (no API calls).
- [ ] Feature Bloc calls Repository only (not API service directly).
- [ ] Repository handles API call orchestration + mapping to domain models.
- [ ] Store Blocs are updated via events only.

## 3) API Layer

- [ ] API services live only in `features/<feature>/data/api/`.
- [ ] API services contain only networking concerns (requests/parsing), no business logic.
- [ ] API responses are parsed through `ApiResponse.fromJson`.
- [ ] Response envelope conforms to:
  - [ ] `success` (`bool`)
  - [ ] `message` (`String`)
  - [ ] `status` (`int`)
  - [ ] `data` (`object` or `array`)

## 4) Repository Layer

- [ ] Repository exists for each active feature.
- [ ] Repository returns domain models (never response models).
- [ ] Repository is registered in DI as `registerLazySingleton`.

## 5) Models and Mappers

- [ ] Response models are limited to `data/models/`.
- [ ] API models do not leak into presentation/store layers.
- [ ] Mappers convert response -> domain.
- [ ] Domain models do not depend on response models.

## 6) Blocs and State

- [ ] Feature Blocs are `registerFactory` (screen-scoped).
- [ ] Store Blocs are `registerLazySingleton` (app-lifetime).
- [ ] Feature Bloc state holds UI state only (loading/error/pagination/etc.).
- [ ] Domain entities are stored only in Store Bloc state.
- [ ] Store state uses normalized entity pattern where applicable (`Map<String, Entity>` + id list).

## 7) UI Rules

- [ ] UI remains presentation-only.
- [ ] No HTTP/repository/API calls from widgets.
- [ ] `BlocSelector` used for Store data reads when possible.
- [ ] `BlocListener` used for side effects (snackbar/navigation/dialog).

## 8) DI and Initialization

- [ ] API services registered as lazy singletons.
- [ ] Repositories registered as lazy singletons.
- [ ] Store Blocs initialized at app startup.
- [ ] Feature Blocs provided at screen scope.

## 9) Naming and Code Health

- [ ] Files use `snake_case`.
- [ ] Classes use `PascalCase`.
- [ ] Variables use `camelCase` and private members `_prefix`.
- [ ] `flutter analyze --no-pub` passes.

## 10) Quick Commands

```bash
flutter analyze --no-pub
```

Cross-feature import scan:

```bash
python3 - <<'PY'
import re
from pathlib import Path
root = Path('lib/features')
pat = re.compile(r"import\s+'package:pooch/features/([^/]+)/")
violations = []
for f in root.rglob('*.dart'):
    owner = f.parts[2]
    for i, line in enumerate(f.read_text(encoding='utf-8').splitlines(), 1):
        m = pat.search(line)
        if m and m.group(1) != owner:
            violations.append((f, i, line.strip()))
if violations:
    print('CROSS_FEATURE_IMPORTS_FOUND')
    for f, i, line in violations:
        print(f'{f}:{i}: {line}')
else:
    print('NO_CROSS_FEATURE_IMPORTS')
PY
```