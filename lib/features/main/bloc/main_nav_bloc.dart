import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_nav_event.dart';
part 'main_nav_state.dart';

class MainNavBloc extends Bloc<MainNavEvent, MainNavState> {
  MainNavBloc() : super(const MainNavState(0)) {
    on<TabChanged>((event, emit) {
      emit(MainNavState(event.index));
    });
  }
}
