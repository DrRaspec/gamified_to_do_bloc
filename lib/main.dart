import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di/service_locator.dart';
import 'env/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app configuration using compile-time define `ENV`.
  // Pass via `--dart-define=ENV=development` or `--dart-define=ENV=production`.
  final environment = const String.fromEnvironment(
    'ENV',
    defaultValue: 'development',
  );
  await AppConfig.initialize(environment: environment);

  // Setup dependency injection
  await setupServiceLocator();

  runApp(const App());
}
