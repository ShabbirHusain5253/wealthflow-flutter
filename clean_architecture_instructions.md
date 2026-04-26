# Clean Architecture Implementation Guide (Flutter)

This document serves as the master blueprint for the project's architecture. Use these instructions to restructure code, implement new features, or refactor existing logic while maintaining architectural integrity.

## 1. Core Principles
- **Separation of Concerns**: Each layer has a single responsibility.
- **Dependency Rule**: Dependencies point inwards. Outer layers (Data, Presentation) depend on the inner layer (Domain).
- **Independence**: The Domain layer must be independent of external libraries/frameworks (except basic utilities like `fpdart`).

---

## 2. Directory Structure

```text
lib/
├── core/                  # Shared utilities and core logic
│   ├── common/            # Shared entities, widgets, and cubits
│   ├── error/             # Failure and Exception classes
│   ├── navigation/        # Routing logic
│   ├── network/           # Connection checking
│   ├── theme/             # Styling and themes
│   ├── usecase/           # Base UseCase interface
│   └── utils/             # Helper functions
├── features/              # Feature-based modules
│   └── [feature_name]/
│       ├── data/          # Implementation of data retrieval
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/        # Business logic and contracts
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/  # UI and state management
│           ├── bloc/
│           ├── pages/
│           └── widgets/
├── init_dependencies.dart # Manual Dependency Injection (GetIt)
└── main.dart              # Entry point
```

---

## 3. Layer Definitions

### A. Domain Layer (The Heart)
- **Entities**: Simple classes representing the business objects.
- **Repositories (Interfaces)**: Abstract classes defining the contracts for data operations.
- **UseCases**: Classes that perform a single business action. They depend on Repositories.
    - *Base Class*: `UseCase<SuccessType, Params>` returning `Future<Either<Failure, SuccessType>>`.

### B. Data Layer (The Implementation)
- **Models**: Data Transfer Objects (DTOs) that extend Entities. They include JSON serialization (`fromJson`, `toJson`).
- **Repositories (Implementations)**: Concrete implementations of the Domain Repository interfaces. They coordinate DataSources.
- **DataSources**: Direct interfaces with external APIs or local databases.
    - `RemoteDataSource`: Handles API calls (e.g., Supabase).
    - `LocalDataSource`: Handles local storage (e.g., Hive).

### C. Presentation Layer (The UI)
- **Bloc/Cubit**: Handles state transitions based on UseCases.
- **Pages**: Top-level widgets (Screens).
- **Widgets**: Reusable UI components specific to the feature.

---

## 4. Naming Conventions

- **Files**: `lower_snake_case.dart`.
- **Classes**: `UpperPascalCase`.
- **Suffixes**:
    - Repository Interfaces: `[Name]Repository`
    - Repository Impl: `[Name]RepositoryImpl`
    - DataSources: `[Name]RemoteDataSource` / `[Name]LocalDataSource`
    - Models: `[Name]Model`
    - Entities: `[Name]` (no suffix)
    - Blocs: `[Name]Bloc` / `[Name]State` / `[Name]Event`

---

## 5. Dependency Injection (Manual GetIt)

All dependencies must be registered in `lib/init_dependencies.dart`.
- Use `registerFactory` for Blocs and temporary objects.
- Use `registerLazySingleton` for Repositories, DataSources, and shared services.
- Group registrations by feature using private methods (e.g., `_initAuth()`).

---

## 6. Error Handling
- Use the `Either<Failure, SuccessType>` pattern from `fpdart`.
- Catch exceptions in the **Repository Implementation** and convert them to `Failure` objects.
- Present `Failure` messages in the UI via Bloc states.

---

## 7. Refactoring Instructions for AI

When asked to restructure code:
1. **Analyze Logic**: Identify the core business logic, data models, and UI components.
2. **Map to Layers**:
    - Move business logic to `domain/usecases`.
    - Move data models to `data/models` (extending entities in `domain/entities`).
    - Move API/DB calls to `data/datasources`.
    - Move UI and state to `presentation`.
3. **Establish Contracts**: Create repository interfaces in `domain` and implement them in `data`.
4. **Register Dependencies**: Add necessary registrations in `init_dependencies.dart`.
5. **Update State Management**: Ensure Blocs call UseCases and handle `Either` results.
6. **Cleanup**: Remove any tight coupling or leaked data layer logic from the UI.
