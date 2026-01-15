import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/bloc/auth_bloc.dart';
import 'di/service_locator.dart';
import 'router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Use getIt to inject TokenStorage into AuthBloc
      create: (_) => getIt<AuthBloc>()..add(AppStarted()),
      child: MaterialApp.router(
        title: 'Gamified To-Do App',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
