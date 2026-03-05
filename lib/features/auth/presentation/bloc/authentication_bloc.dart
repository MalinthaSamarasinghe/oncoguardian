import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:oncoguardian/core/enums/authentication_status.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState()) {
    on<UserLoggedInEvent>(_userLoggedInEvent);
    on<UserLoggedOutEvent>(_userLoggedOutEvent);
  }

  void _userLoggedInEvent(UserLoggedInEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      authenticationStatus: event.authenticationStatus,
    ));
  }

  Future<void> _userLoggedOutEvent(UserLoggedOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      authenticationStatus: AuthenticationStatus.unauthenticated,
      clearUserEntity: true,
    ));
  }

  @override
  String get storagePrefix => 'authentication_bloc_oncoguardian';

  @override
  AuthenticationState? fromJson(Map<String, dynamic>? json) {
    try {
      if (json == null || json.isEmpty) {
        debugPrint('AuthenticationBloc.fromJson: json is null or empty');
        return const AuthenticationState();
      }
      return AuthenticationState(
        authenticationStatus: authenticationStatusValues.map[json['authenticationStatus']] ?? AuthenticationStatus.unauthenticated,
      );
    } catch (e, stack) {
      debugPrint('AuthenticationBloc.fromJson error: $e\n$stack');
      return const AuthenticationState();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    try {
      return {
        'authenticationStatus': authenticationStatusValues.reverse[state.authenticationStatus],
      };
    } catch (_) {}
    return null;
  }
}
