# Flutter Enterprise Architecture & Coding Standards (AI-Enforced)

This document defines a strict, production-grade Flutter architecture and coding standard for large-scale applications.

It combines:
- Feature-First Architecture
- Bloc + Repository Pattern
- Domain-Driven Design principles
- Global Store (Normalized State)
- Enterprise naming conventions
- AI-assisted code validation rules

---

# 1. Architecture Overview (MANDATORY)

## 1.1 Core Principle

The system follows a **Feature-First + Layered + Unidirectional Data Flow Architecture**.

---

## 1.2 Global Data Flow

UI
↓
Feature Bloc
↓
Repository
↓
API Service
↓
Mapper
↓
Domain Model
↓
Feature Bloc
↓
Store Bloc (Global State)
↓
UI

---

## 1.3 Layer Responsibilities

| Layer | Responsibility |
|------|------|
| UI | Render widgets, dispatch events only |
| Feature Bloc | Feature logic + UI state (loading, error, pagination) |
| Repository | Data abstraction, caching, merging |
| API Service | Pure HTTP requests only |
| Mapper | API → Domain transformation |
| Domain Model | Pure business entities |
| Store Bloc | Global normalized single source of truth |

---

# 2. Project Structure (MANDATORY)

lib/

app/
core/
features/
shared/
l10n/
assets/
main.dart

---

# 3. Feature Structure (STRICT)

Each feature MUST follow:

features/feature_name/

data/
  api/
  models/
  mappers/

domain/
  models/

repository/

presentation/
  bloc/
  view/
  widgets/

---

# 4. Architecture Rules (STRICT)

## 4.1 Forbidden

- UI calling API directly
- Business logic inside widgets
- Feature-to-feature direct communication
- UI modifying Store state
- API Service containing business logic
- Feature importing another feature’s domain models

---

## 4.2 Allowed Flow Only

UI → Feature Bloc → Repository → API Service → Mapper → Domain → Store Bloc → UI

---

## 4.3 Cross Feature Rule

Only allowed communication:

Feature Bloc → Store Bloc → Other Feature reacts

---

# 5. Naming Conventions (STRICT)

## Files
snake_case.dart

## Classes
PascalCase

## Variables
camelCase

## Private variables
_prefix

## Functions
camelCase

---

# 6. Feature Naming Rules

| Type | Example |
|------|--------|
| Screen | PetListScreen |
| Widget | PetCardWidget |
| Bloc | PetBloc |
| Event | PetEvent |
| State | PetState |
| Repository | PetRepository |
| API Service | PetApiService |
| Model | PetModel |
| Entity | Pet |

---

# 7. Bloc Rules

## Feature Bloc
- Handles UI state
- Calls repository
- Dispatches store updates

❌ Must NOT store global data

---

## Store Bloc (GLOBAL STATE)
- Single source of truth
- Normalized state
- No API calls
- No business logic

Example:
PetsStoreBloc, AuthStoreBloc, CartStoreBloc

---

# 8. Repository Rules

- Must abstract API layer
- Must handle caching (if needed)
- Must convert API → Domain models

---

# 9. API Service Rules

ONLY:
- HTTP calls
- Request/response handling

NEVER:
- Business logic
- Mapping
- State handling

---

# 10. Mapper Rules

Convert API → Domain

API models must never leave data layer.

---

# 11. Domain Models

- Pure Dart classes
- No JSON logic
- No dependencies

---

# 12. UI Rules

UI MUST:
- Be stateless where possible
- Dispatch events only
- Render state only

UI MUST NOT:
- Call APIs
- Contain business logic
- Modify store state

---

# 13. Store Pattern (IMPORTANT)

Use normalized structure:

Map<String, Entity>
List<String> ids

UPSERT rule:
entityMap[id] = entity;

---

# 14. Dependency Injection

Use get_it

- API Services → LazySingleton
- Store Blocs → LazySingleton
- Feature Blocs → Factory

---

# 15. Error Handling

All errors must be converted into Feature Bloc states.

---

# 16. Performance Rules

- Use const constructors
- Avoid unnecessary rebuilds
- Use BlocSelector
- Split large widgets (300–400 lines max)

---

# 17. Cross Feature Communication

❌ Never directly access another feature

✔ Allowed:
Feature → Store → Feature reacts

---

# 18. Lint Rules (analysis_options.yaml)

include: package:flutter_lints/flutter.yaml

linter:
  rules:
    avoid_print: true
    prefer_const_constructors: true
    prefer_final_fields: true
    prefer_final_locals: true
    avoid_unused_parameters: true
    unnecessary_this: true
    sort_child_properties_last: true
    always_use_package_imports: true
    prefer_single_quotes: true

---

# 19. AI Code Review Rules (IMPORTANT)

AI MUST FLAG:

- API calls inside UI
- Missing repository layer
- Missing mapper layer
- Domain leakage into API layer
- Cross-feature imports
- UI modifying store state
- Business logic inside widgets

---

# 20. Final Architecture

UI
↓
Feature Bloc
↓
Repository
↓
API Service
↓
Mapper
↓
Domain Model
↓
Store Bloc
↓
UI

---

# 21. Golden Rule

UI is dumb.
Bloc is controlled.
Repository is abstract.
Store is truth.
Domain is pure.