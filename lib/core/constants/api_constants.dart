class ApiEndpoints {
  static const String apiVersion = 'v1';

  static const String login = '/$apiVersion/auth/login';
  static const String register = '/$apiVersion/auth/register';
  static const String refreshToken = '/$apiVersion/auth/refresh';

  static const String me = '/$apiVersion/user/me';
  static const String profile = '/$apiVersion/user/profile';

  static const String dashboard = '/$apiVersion/dashboard';
}
