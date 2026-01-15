import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../core/network/dio_client.dart';
import '../../core/storage/token_storage.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../repository/auth_repository.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Core Services - Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(getIt()));

  // Network - DioClient
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      tokenStorage: getIt(),
      onUnauthorized: () {
        // Handle navigation to login when unauthorized
        // This can be enhanced with a navigation service
      },
    ),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt()));

  // BLoCs
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(tokenStorage: getIt(), authRepository: getIt()),
  );

  // Add other dependencies here as needed
}
