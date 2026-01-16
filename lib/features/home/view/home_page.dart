import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamified_to_do_app_bloc/gen/assets.gen.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../../app/di/service_locator.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(getIt())..add(LoadHomeData()),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return Text('Hi, ${state.authData.firstName}!');
              }
              return const Text('Home');
            },
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, homeState) {
            if (homeState is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (homeState is HomeError) {
              return Center(child: Text('Error: ${homeState.message}'));
            }

            if (homeState is HomeLoaded) {
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  if (authState is Authenticated) {
                    final user = authState.authData;
                    final dashboard = homeState.dashboard;
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back!',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${user.firstName} ${user.lastName}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  Text(
                                    user.email,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Task Overview',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _StatCard(
                                    title: 'Completed',
                                    value:
                                        dashboard.completedTask ??
                                        dashboard.tasksToday ??
                                        0,
                                    color: Colors.blue,
                                    iconPath: Assets.icons.home.tasks.path,
                                    iconIsSvg: true,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _StatCard(
                                    title: 'Current Streak',
                                    value: dashboard.currentStreak ?? 0,
                                    color: Colors.green,
                                    iconPath: Assets.icons.home.streak.path,
                                    iconIsSvg: true,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _StatCard(
                                    title: 'Total XP',
                                    value: dashboard.totalXp ?? 0,
                                    color: Colors.orange,
                                    iconPath: Assets.images.home.totalXp.path,
                                    iconIsSvg: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: Text('Loading user data...'));
                },
              );
            }

            return Center(child: Text('Home - ${homeState.runtimeType}'));
          },
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final num value;
  final Color color;
  final String? iconPath;
  final bool iconIsSvg;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    this.iconPath,
    this.iconIsSvg = true,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = _formatCompact(value);
    final textStyle = _valueTextStyle(context, displayValue.length, color);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPath != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: iconIsSvg
                    ? SvgPicture.asset(iconPath!, width: 20, height: 20)
                    : Image.asset(
                        iconPath!,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
              ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                displayValue,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatCompact(num value) {
  final absValue = value.abs();
  if (absValue >= 1000000000) {
    return '${_trimDecimals(value / 1000000000)}B';
  }
  if (absValue >= 1000000) {
    return '${_trimDecimals(value / 1000000)}M';
  }
  if (absValue >= 1000) {
    return '${_trimDecimals(value / 1000)}K';
  }
  return value.toStringAsFixed(0);
}

String _trimDecimals(num value) {
  final fixed = value.toStringAsFixed(1);
  return fixed.endsWith('.0') ? fixed.substring(0, fixed.length - 2) : fixed;
}

TextStyle _valueTextStyle(BuildContext context, int length, Color color) {
  final base = Theme.of(context).textTheme.headlineMedium;
  final fontSize = length > 6
      ? 20.0
      : length > 4
      ? 24.0
      : 28.0;
  return base?.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ) ??
      TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: fontSize);
}
