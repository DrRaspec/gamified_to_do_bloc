# Gamified To-Do App - BLoC Architecture

A Flutter gamified to-do application built with clean architecture and BLoC pattern.

## Project Structure

```
lib/
├── app/                    # Application-level configuration
│   ├── di/                # Dependency Injection (Get It)
│   │   └── service_locator.dart
│   ├── router/            # Navigation configuration
│   │   └── app_routes.dart
│   └── app.dart           # Root app widget
├── core/                  # Core functionality shared across features
│   ├── constants/         # App constants (API endpoints, storage keys)
│   ├── errors/            # Custom exceptions and error handling
│   ├── network/           # Network configuration (Dio client)
│   ├── storage/           # Local storage (Token storage)
│   └── utils/             # Utility functions
├── env/                   # Environment configuration
│   └── app_config.dart
├── features/              # Feature modules (BLoC pattern)
│   ├── auth/
│   │   ├── bloc/         # BLoC (Business Logic Component)
│   │   ├── data/         # Data layer (repositories, models)
│   │   └── presentation/ # UI layer (screens, widgets)
│   ├── tasks/
│   ├── calendar/
│   └── profile/
├── models/                # Shared data models
└── repository/            # Global repositories
```

## Architecture Principles

### 1. Dependency Injection (Get It)
- All services are registered in `service_locator.dart`
- Constructor injection for better testability
- Lazy singleton pattern for shared instances

### 2. BLoC Pattern
- Separates business logic from UI
- Uses events and states for predictable state management
- Easy to test and maintain

### 3. Clean Architecture
- **Presentation Layer**: UI components (widgets, screens)
- **Business Logic Layer**: BLoCs handle state and business rules
- **Data Layer**: Repositories manage data sources (API, local storage)

### 4. Network Layer
- `DioClient`: Handles all HTTP requests
- Automatic token refresh on 401 errors
- Error mapping to custom exceptions
- Pretty logging in debug mode

## Key Features

- ✅ Token-based authentication with auto-refresh
- ✅ Clean separation of concerns
- ✅ Dependency injection with Get It
- ✅ Environment-based configuration
- ✅ Secure token storage
- ✅ Centralized error handling
- ✅ Debug logging with Pretty Dio Logger

## Getting Started

### Prerequisites
- Flutter SDK >=3.10.0
- Dart SDK >=3.10.0

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Configure environment files:
```bash
# Development
env/.env.dev

# Production
env/.env.prod
```

3. Run the app:
```bash
flutter run
```

## Configuration

### Environment Variables

Create `.env.dev` and `.env.prod` files in the `env/` directory:

```env
ENVIRONMENT=development
BASE_URL=http://127.0.0.1:8080/api
```

### Dependency Registration

Register new services in `lib/app/di/service_locator.dart`:

```dart
getIt.registerLazySingleton<YourService>(
  () => YourService(getIt()),
);
```

### Using Dependencies

Inject dependencies via constructor:

```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  final MyRepository repository;

  MyBloc(this.repository) : super(InitialState());
}

// In BlocProvider
BlocProvider(
  create: (_) => MyBloc(getIt()),
  child: MyWidget(),
)
```

## Best Practices

1. **Single Responsibility**: Each class has one clear purpose
2. **Dependency Injection**: Use constructor injection, not service locator pattern in business logic
3. **Immutable States**: All BLoC states should be immutable
4. **Error Handling**: Use custom exceptions and handle them in BLoCs
5. **Feature-First Structure**: Organize by feature, not by type
6. **Test-Friendly**: Inject dependencies to make testing easier

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Common Patterns

### Creating a New Feature

1. Create feature folder structure:
```
features/my_feature/
├── bloc/
│   ├── my_feature_bloc.dart
│   ├── my_feature_event.dart
│   └── my_feature_state.dart
├── data/
│   └── my_feature_repository.dart
└── presentation/
    ├── screens/
    └── widgets/
```

2. Register repository in service locator
3. Create BLoC with injected dependencies
4. Use BlocProvider in UI

### Making API Calls

```dart
class MyRepository {
  final DioClient _client;

  MyRepository(this._client);

  Future<ApiResponse<MyData>> fetchData() async {
    final response = await _client.dio.get('/endpoint');
    return ApiResponse.fromJson(response.data, MyData.fromJson);
  }
}
```

## License

This project is private and proprietary.
