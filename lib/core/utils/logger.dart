import 'package:flutter/foundation.dart';

class AppLogger {
  static const String _appName = 'Gamified Todo';

  // Extra safety: disable all logging in release mode
  static const bool _enabled = !kReleaseMode;

  /// Log info messages
  static void info(String message, {String? tag}) {
    if (_enabled) {
      debugPrint('$_appName [INFO] ${tag != null ? '[$tag] ' : ''}$message');
    }
  }

  /// Log success messages
  static void success(String message, {String? tag}) {
    if (_enabled) {
      debugPrint('$_appName [SUCCESS] ${tag != null ? '[$tag] ' : ''}$message');
    }
  }

  /// Log warning messages
  static void warning(String message, {String? tag}) {
    if (_enabled) {
      debugPrint('$_appName [WARNING] ${tag != null ? '[$tag] ' : ''}$message');
    }
  }

  /// Log error messages
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (_enabled) {
      debugPrint('$_appName [ERROR] ${tag != null ? '[$tag] ' : ''}$message');
      if (error != null) debugPrint('Error: $error');
      if (stackTrace != null) debugPrint('StackTrace: $stackTrace');
    }
  }

  /// Log debug messages (only in debug mode, not profile)
  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      debugPrint('$_appName [DEBUG] ${tag != null ? '[$tag] ' : ''}$message');
    }
  }

  /// Log network requests
  static void network(String message, {String? tag}) {
    if (_enabled) {
      debugPrint('$_appName [NETWORK] ${tag != null ? '[$tag] ' : ''}$message');
    }
  }

  /// Log API calls
  static void api(
    String method,
    String endpoint, {
    Map<String, dynamic>? data,
  }) {
    if (_enabled) {
      debugPrint('$_appName [API] $method $endpoint');
      if (data != null) debugPrint('Data: $data');
    }
  }

  /// Log navigation
  static void route(String route) {
    if (_enabled) {
      debugPrint('$_appName [ROUTE] $route');
    }
  }

  /// Log data/state changes
  static void data(String message, {dynamic value}) {
    if (_enabled) {
      debugPrint('$_appName [DATA] $message');
      if (value != null) debugPrint('Value: $value');
    }
  }
}
