import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:oncoguardian/core/enums/app_theme_mode.dart';
import 'package:oncoguardian/core/blocs/event_transformer.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(appThemeMode: PlatformDispatcher.instance.platformBrightness == Brightness.dark ? AppThemeMode.dark : AppThemeMode.light)){
    on<ThemeChanged>(_onThemeChanged, transformer: Transformer.throttleRestartable());
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    emit(ThemeState(
      appThemeMode: event.appThemeMode,
    ));
  }

  @override
  String get storagePrefix => 'theme_bloc_oncoguardian';

  @override
  ThemeState? fromJson(Map<String, dynamic>? json) {
    try {
      if (json == null || json.isEmpty) {
        debugPrint('ThemeBloc.fromJson: json is null or empty');
        return ThemeState(appThemeMode: PlatformDispatcher.instance.platformBrightness == Brightness.dark ? AppThemeMode.dark : AppThemeMode.light);
      }

      final appThemeMode = appThemeModeValues.map[json['appThemeMode']] ?? AppThemeMode.light;
      return ThemeState(appThemeMode: appThemeMode);
    } catch (e, stack) {
      debugPrint('ThemeBloc.fromJson error: $e\n$stack');
      return ThemeState(appThemeMode: PlatformDispatcher.instance.platformBrightness == Brightness.dark ? AppThemeMode.dark : AppThemeMode.light);
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    try {
      return {
        'appThemeMode': appThemeModeValues.reverse[state.appThemeMode],
      };
    } catch (e) {
      debugPrint('ThemeBloc.toJson error: $e');
    }
    return null;
  }
}
