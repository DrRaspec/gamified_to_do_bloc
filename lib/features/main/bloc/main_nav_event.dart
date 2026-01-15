part of 'main_nav_bloc.dart';

sealed class MainNavEvent extends Equatable {
  const MainNavEvent();

  @override
  List<Object?> get props => [];
}

class TabChanged extends MainNavEvent {
  final int index;
  const TabChanged(this.index);

  @override
  List<Object?> get props => [index];
}
