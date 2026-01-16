import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gamified_to_do_app_bloc/core/utils/logger.dart';
import 'package:gamified_to_do_app_bloc/models/dashboard_data.dart';
import 'package:gamified_to_do_app_bloc/repository/dashboard_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DashboardRepository dashboardRepository;
  HomeBloc(this.dashboardRepository) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    AppLogger.info('[HomeBloc] LoadHomeData received');
    emit(HomeLoading());
    try {
      final dashboard = await dashboardRepository.fetchDashboardData();
      AppLogger.data(
        '[HomeBloc] Dashboard data fetched: ${dashboard.data?.toMap()}',
      );
      if (dashboard.data == null) {
        AppLogger.error('No dashboard data available');
        emit(const HomeError('No dashboard data available'));
        return;
      }
      final loaded = HomeLoaded(dashboard.data!);
      AppLogger.info('[HomeBloc] emitting HomeLoaded');
      emit(loaded);
    } catch (e) {
      AppLogger.error('[HomeBloc] error: $e');
      emit(HomeError(e.toString()));
    }
  }
}
