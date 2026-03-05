part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final AppThemeMode appThemeMode;

  const ThemeState({
    required this.appThemeMode,
  });

  @override
  List<Object?> get props => [appThemeMode];

  ThemeState copyWith({
    AppThemeMode? appThemeMode,
  }) {
    return ThemeState(
      appThemeMode: appThemeMode ?? this.appThemeMode,
    );
  }
}
