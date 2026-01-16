class ApiException implements Exception {
  final String message;
  final int status;
  final String? error;
  final Map<String, dynamic>? details;

  ApiException({
    required this.message,
    required this.status,
    this.error,
    this.details,
  });

  @override
  String toString() =>
      'ApiException(status: $status, message: $message, error: $error)';

  String getDetailedMessage() {
    if (details != null && details!.isNotEmpty) {
      final firstError = details!.values.first;
      if (firstError is String) {
        return firstError;
      } else if (firstError is List && firstError.isNotEmpty) {
        return firstError.first.toString();
      }
    }
    return message;
  }
}
