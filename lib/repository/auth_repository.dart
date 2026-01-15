import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import '../core/errors/api_exception.dart';
import '../core/network/dio_client.dart';
import '../models/api_response.dart';
import '../models/auth_data.dart';
import '../models/register_request.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<ApiResponse<AuthData>> login(String email, String password) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => AuthData.fromMap(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.error is ApiException) throw e.error!;
      rethrow;
    }
  }

  Future<ApiResponse<AuthData>> register(RegisterRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.register,
        data: request.toMap(),
      );

      return ApiResponse.fromJson(
        response.data,
        (json) => AuthData.fromMap(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.error is ApiException) throw e.error!;
      rethrow;
    }
  }

  Future<ApiResponse<dynamic>> me() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoints.me);
      return ApiResponse.fromJson(response.data, null);
    } on DioException catch (e) {
      if (e.error is ApiException) throw e.error!;
      rethrow;
    }
  }

  Future<ApiResponse<dynamic>> refresh(String refreshToken) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      return ApiResponse.fromJson(response.data, null);
    } on DioException catch (e) {
      if (e.error is ApiException) throw e.error!;
      rethrow;
    }
  }
}
