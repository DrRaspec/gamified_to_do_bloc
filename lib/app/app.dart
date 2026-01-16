import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/bloc/auth_bloc.dart';
import 'di/service_locator.dart';
import 'router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthBloc>()..add(AppStarted());
    return BlocProvider.value(
      value: authBloc,
      child: ToastificationWrapper(
        child: MaterialApp.router(
          title: 'Gamified To-Do App',
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router(authBloc),
        ),
      ),
    );
  }
}
