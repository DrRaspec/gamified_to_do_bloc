# Quick Start Guide

## Overview
This project uses **BLoC pattern** with **Get It** for dependency injection. It's designed to be clean, testable, and maintainable without being overly complex.

## Project Status: ✅ Ready to Use

All GetX dependencies have been removed and replaced with:
- **Get It** for dependency injection
- **BLoC** for state management
- **Constructor injection** for better testability

## Key Components

### 1. Service Locator (`lib/app/di/service_locator.dart`)
Central place for all dependency registrations.

```dart
final getIt = GetIt.instance;

// Already registered:
// - FlutterSecureStorage
// - TokenStorage
// - DioClient
// - AuthRepository
```

### 2. Network Client (`lib/core/network/dio_client.dart`)
Handles all HTTP requests with:
- ✅ Automatic token injection
- ✅ Auto token refresh on 401
- ✅ Error mapping to ApiException
- ✅ Pretty logging in debug mode

### 3. Token Storage (`lib/core/storage/token_storage.dart`)
Secure storage for access and refresh tokens.

### 4. App Config (`lib/env/app_config.dart`)
Environment-based configuration.

## Usage Examples

### 1. Using Services in BLoCs

```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  final MyRepository repository;
  final TokenStorage tokenStorage;

  // ✅ Constructor injection
  MyBloc({
    required this.repository,
    required this.tokenStorage,
  }) : super(InitialState());
}

// Provide in UI
BlocProvider(
  create: (_) => MyBloc(
    repository: getIt<MyRepository>(),
    tokenStorage: getIt<TokenStorage>(),
  ),
  child: MyScreen(),
)
```

### 2. Creating a New Repository

**Step 1:** Create repository class
```dart
class TaskRepository {
  final DioClient _client;

  TaskRepository(this._client);

  Future<List<Task>> getTasks() async {
    final response = await _client.dio.get('/tasks');
    return (response.data['data'] as List)
        .map((json) => Task.fromJson(json))
        .toList();
  }
}
```

**Step 2:** Register in service locator
```dart
// In lib/app/di/service_locator.dart
getIt.registerLazySingleton<TaskRepository>(
  () => TaskRepository(getIt()),
);
```

**Step 3:** Use in BLoC
```dart
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskInitial());
}
```

### 3. Making API Calls

The `DioClient` automatically:
- Adds auth token to requests
- Refreshes token if expired
- Maps errors to `ApiException`

```dart
// In repository
Future<ApiResponse<User>> getProfile() async {
  try {
    final response = await _client.dio.get(ApiEndpoints.me);
    return ApiResponse.fromJson(response.data, User.fromJson);
  } on DioException catch (e) {
    if (e.error is ApiException) throw e.error!;
    rethrow;
  }
}

// In BLoC
Future<void> _onLoadProfile(
  LoadProfile event,
  Emitter<ProfileState> emit,
) async {
  emit(ProfileLoading());
  try {
    final response = await repository.getProfile();
    emit(ProfileLoaded(response.data));
  } on ApiException catch (e) {
    emit(ProfileError(e.message));
  } catch (e) {
    emit(ProfileError('An unexpected error occurred'));
  }
}
```

### 4. Handling Authentication

```dart
// Login example
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final TokenStorage tokenStorage;

  Future<void> _onLogin(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.login(
        event.email,
        event.password,
      );
      
      final tokens = response.data;
      await tokenStorage.writeTokens(
        accessToken: tokens['accessToken'],
        refreshToken: tokens['refreshToken'],
      );
      
      emit(Authenticated());
    } on ApiException catch (e) {
      emit(AuthError(e.message));
    }
  }

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await tokenStorage.clear();
    emit(Unauthenticated());
  }
}
```

## Best Practices

### ✅ Do's

1. **Use constructor injection**
   ```dart
   class MyService {
     final DioClient client;
     MyService(this.client); // ✅ Good
   }
   ```

2. **Register dependencies in service_locator.dart**
   ```dart
   getIt.registerLazySingleton<MyService>(
     () => MyService(getIt()),
   );
   ```

3. **Handle errors in BLoCs**
   ```dart
   try {
     final data = await repository.getData();
     emit(DataLoaded(data));
   } on ApiException catch (e) {
     emit(DataError(e.message));
   }
   ```

4. **Use named parameters for clarity**
   ```dart
   DioClient(
     tokenStorage: getIt(),
     onUnauthorized: () => navigateToLogin(),
   )
   ```

### ❌ Don'ts

1. **Don't use getIt directly in business logic**
   ```dart
   class MyBloc {
     void someMethod() {
       final repo = getIt<MyRepo>(); // ❌ Bad
     }
   }
   ```

2. **Don't forget to register dependencies**
   ```dart
   // If you create a new service, register it!
   ```

3. **Don't mix state management patterns**
   ```dart
   // Use BLoC, not setState or other patterns
   ```

## Testing

### Unit Testing BLoCs

```dart
void main() {
  late MyBloc bloc;
  late MockMyRepository mockRepository;

  setUp(() {
    mockRepository = MockMyRepository();
    bloc = MyBloc(mockRepository); // Easy to inject mocks!
  });

  test('emits success state when data loaded', () async {
    when(mockRepository.getData())
        .thenAnswer((_) async => mockData);

    bloc.add(LoadData());

    await expectLater(
      bloc.stream,
      emitsInOrder([
        DataLoading(),
        DataLoaded(mockData),
      ]),
    );
  });
}
```

## Environment Configuration

### Development
```bash
# Uses env/.env.dev
flutter run
```

### Production
```bash
# Uses env/.env.prod
# Update main.dart to use 'production' environment
flutter run --release
```

## Troubleshooting

### Issue: "Type not found" error
**Solution**: Make sure service is registered in `service_locator.dart`

### Issue: "Can't resolve type"
**Solution**: Check that dependencies are registered before they're used

### Issue: Token not being sent
**Solution**: Ensure `DioClient` is properly initialized in service locator

### Issue: 401 errors not handled
**Solution**: `DioClient` handles this automatically. Check `onUnauthorized` callback.

## File Organization

```
lib/
├── app/
│   ├── di/service_locator.dart      # Register all dependencies here
│   ├── router/app_routes.dart        # Route constants
│   └── app.dart                      # Root widget
├── core/
│   ├── constants/                    # App-wide constants
│   ├── errors/api_exception.dart     # Custom exceptions
│   ├── network/dio_client.dart       # HTTP client
│   └── storage/token_storage.dart    # Secure storage
├── features/
│   └── [feature_name]/
│       ├── bloc/                     # State management
│       ├── data/                     # Data sources
│       └── presentation/             # UI
└── models/                           # Shared models
```

## Next Steps

1. ✅ All errors fixed
2. ✅ Clean architecture implemented
3. ✅ Dependencies properly injected
4. ✅ Ready to build features

Start building your features following the patterns above!
