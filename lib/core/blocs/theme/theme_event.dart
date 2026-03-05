part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final AppThemeMode appThemeMode;

  const ThemeChanged({required this.appThemeMode});

  @override
  List<Object> get props => [appThemeMode];
}
