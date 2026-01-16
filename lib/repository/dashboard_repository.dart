import 'package:dio/dio.dart';
import 'package:gamified_to_do_app_bloc/core/constants/api_constants.dart';
import 'package:gamified_to_do_app_bloc/core/errors/api_exception.dart';
import 'package:gamified_to_do_app_bloc/core/network/dio_client.dart';
import 'package:gamified_to_do_app_bloc/models/api_response.dart';
import 'package:gamified_to_do_app_bloc/models/dashboard_data.dart';

class DashboardRepository {
  final DioClient _dioClient;

  DashboardRepository(this._dioClient);

  Future<ApiResponse<DashboardData>> fetchDashboardData() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoints.dashboard);
      final data = response.data;
      if (data is Map<String, dynamic> && data['success'] != null) {
        return ApiResponse.fromJson(
          data,
          (json) => DashboardData.fromMap(json as Map<String, dynamic>),
        );
      }

      if (data is Map<String, dynamic>) {
        return ApiResponse<DashboardData>(
          success: true,
          message: 'OK',
          status: response.statusCode ?? 200,
          path: ApiEndpoints.dashboard,
          data: DashboardData.fromMap(data),
        );
      }

      return ApiResponse<DashboardData>(
        success: false,
        message: 'Unexpected response format',
        status: response.statusCode ?? 500,
        path: ApiEndpoints.dashboard,
        data: null,
      );
    } on DioException catch (e) {
      if (e.response?.data is Map<String, dynamic>) {
        final errorData = e.response!.data as Map<String, dynamic>;
        throw ApiException(
          message: errorData['message'] ?? 'An error occurred',
          status: e.response?.statusCode ?? 500,
          error: errorData['error'],
          details: errorData['details'],
        );
      }

      throw ApiException(
        message: e.message ?? 'Network error',
        status: e.response?.statusCode ?? 500,
        error: 'Connection failed',
      );
    }
  }
}
