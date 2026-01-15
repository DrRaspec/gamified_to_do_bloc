import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://api.example.com';

  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  static bool get isProduction => environment == 'production';

  static bool get isDevelopment => environment == 'development';

  static Future<void> initialize({required String environment}) async {
    final envFile = environment == 'production'
        ? 'env/.env.prod'
        : 'env/.env.dev';
    await dotenv.load(fileName: envFile);
  }
}
