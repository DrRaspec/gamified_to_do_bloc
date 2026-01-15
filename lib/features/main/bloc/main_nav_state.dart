part of 'main_nav_bloc.dart';

class MainNavState extends Equatable {
  final int index;
  const MainNavState(this.index);

  @override
  List<Object?> get props => [index];
}
