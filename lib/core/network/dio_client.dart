import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../env/app_config.dart';
import '../constants/api_constants.dart';
import '../errors/api_exception.dart';
import '../storage/token_storage.dart';

class DioClient {
  late final Dio dio;
  final TokenStorage _tokenStorage;
  final Function()? onUnauthorized;

  Future<void>? _refreshFuture;

  DioClient({required TokenStorage tokenStorage, this.onUnauthorized})
    : _tokenStorage = tokenStorage {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Add debug-only logger
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }

    // Add auth token interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.readAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final status = error.response?.statusCode;
          final path = error.requestOptions.path;

          final isAuthEndpoint =
              path.contains(ApiEndpoints.login) ||
              path.contains(ApiEndpoints.refreshToken);

          if (status == 401 && !isAuthEndpoint) {
            final ok = await _tryRefreshToken();
            if (ok) {
              final newToken = await _tokenStorage.readAccessToken();
              final requestOptions = error.requestOptions;
              if (newToken != null && newToken.isNotEmpty) {
                requestOptions.headers['Authorization'] = 'Bearer $newToken';
              }

              try {
                final response = await dio.fetch(requestOptions);
                handler.resolve(response);
                return;
              } catch (e) {
                handler.next(error);
                return;
              }
            }

            // Navigate to login
            onUnauthorized?.call();
          }

          handler.next(error);
        },
      ),
    );

    // Global interceptor to map backend errors
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          final data = response.data;
          if (data is Map && data['success'] == false) {
            throw ApiException(
              message: data['message'] ?? 'Unknown error',
              status: data['status'] ?? response.statusCode ?? 500,
              error: data['error'],
              details: data['details'],
            );
          }
          handler.next(response);
        },
        onError: (error, handler) {
          final res = error.response;
          if (res?.data is Map) {
            final data = res!.data;
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                response: res,
                error: ApiException(
                  message: data['message'] ?? 'Request failed',
                  status: data['status'] ?? res.statusCode ?? 500,
                  error: data['error'],
                  details: data['details'],
                ),
                type: error.type,
              ),
            );
            return;
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<bool> _tryRefreshToken() async {
    if (_refreshFuture != null) {
      await _refreshFuture;
      final token = await _tokenStorage.readAccessToken();
      return token != null && token.isNotEmpty;
    }

    final completer = Completer<void>();
    _refreshFuture = completer.future;

    try {
      final refreshToken = await _tokenStorage.readRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        await _tokenStorage.clear();
        return false;
      }

      // Direct refresh call to avoid circular dependency
      final response = await dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final access = (data['accessToken'] ?? data['access_token'])
            ?.toString();
        final refresh = (data['refreshToken'] ?? data['refresh_token'])
            ?.toString();
        if (access != null && access.isNotEmpty) {
          await _tokenStorage.writeTokens(
            accessToken: access,
            refreshToken: refresh,
          );
          return true;
        }
      }

      return false;
    } on DioException catch (e) {
      final api = e.error;
      if (api is ApiException && api.status == 401) {
        await _tokenStorage.clear();
      }
      return false;
    } catch (_) {
      await _tokenStorage.clear();
      return false;
    } finally {
      completer.complete();
      _refreshFuture = null;
    }
  }
}
