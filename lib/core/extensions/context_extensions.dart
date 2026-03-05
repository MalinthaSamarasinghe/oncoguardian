import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oncoguardian/core/enums/app_theme_mode.dart';
import 'package:oncoguardian/core/blocs/theme/theme_bloc.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  AppThemeMode get appThemeMode => read<ThemeBloc>().state.appThemeMode;

  void showErrorSnackBar(String message, {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Color(0xFFFFFFFF))),
        duration: duration,
        backgroundColor: colorScheme.error,
      ),
    );
  }

  void showSuccessSnackBar(String message, {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Color(0xFFFFFFFF))),
        duration: duration,
        backgroundColor: colorScheme.secondary,
      ),
    );
  }
}
