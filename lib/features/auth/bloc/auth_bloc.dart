import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/api_exception.dart';
import '../../../core/storage/token_storage.dart';
import '../../../models/auth_data.dart';
import '../../../models/register_request.dart';
import '../../../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TokenStorage tokenStorage;
  final AuthRepository authRepository;

  AuthBloc({required this.tokenStorage, required this.authRepository})
    : super(AuthUnknown()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final token = await tokenStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      try {
        // Fetch current user data to restore authentication state
        final response = await authRepository.me();

        if (response.success && response.data != null) {
          emit(Authenticated(response.data!));
        } else {
          // Token exists but is invalid, clear and logout
          await tokenStorage.clear();
          emit(Unauthenticated());
        }
      } catch (e) {
        // Failed to fetch user data, token might be expired
        await tokenStorage.clear();
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.login(event.email, event.password);

      if (response.success && response.data != null) {
        await tokenStorage.writeTokens(
          accessToken: response.data!.accessToken,
          refreshToken: response.data!.refreshToken,
        );
        emit(Authenticated(response.data!));
      } else {
        // API returned error in ApiResponse structure
        emit(AuthError(response.getDetailedMessage()));
      }
    } on ApiException catch (e) {
      // Network or connection errors
      emit(AuthError(e.getDetailedMessage()));
    } catch (e) {
      emit(AuthError('An unexpected error occurred'));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final request = RegisterRequest(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
      );

      final response = await authRepository.register(request);

      if (response.success && response.data != null) {
        await tokenStorage.writeTokens(
          accessToken: response.data!.accessToken,
          refreshToken: response.data!.refreshToken,
        );
        emit(Authenticated(response.data!));
      } else {
        // API returned error in ApiResponse structure
        emit(AuthError(response.getDetailedMessage()));
      }
    } on ApiException catch (e) {
      // Network or connection errors
      emit(AuthError(e.getDetailedMessage()));
    } catch (e) {
      emit(AuthError('An unexpected error occurred'));
    }
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await tokenStorage.clear();
    emit(Unauthenticated());
  }
}
