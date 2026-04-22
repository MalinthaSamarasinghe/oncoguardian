import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oncoguardian/core/blocs/event_transformer.dart';
import 'package:oncoguardian/core/enums/authentication_status.dart';
import 'package:oncoguardian/features/auth/data/services/firebase_auth_service.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuthService _firebaseAuthService;

  AuthenticationBloc({FirebaseAuthService? firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService ?? FirebaseAuthService(),
        super(AuthenticationState(authenticationStatus: (firebaseAuthService ?? FirebaseAuthService()).isAuthenticated ? AuthenticationStatus.unauthenticated : AuthenticationStatus.unauthenticated)) {
    on<CreateAccountEvent>(_createAccountEvent, transformer: Transformer.throttleDroppable());
    on<SignInEvent>(_signInEvent, transformer: Transformer.throttleDroppable());
    on<SignOutEvent>(_signOutEvent, transformer: Transformer.throttleDroppable());
    on<UpdateProfileEvent>(_updateProfileEvent, transformer: Transformer.throttleDroppable());
  }

  Future<void> _createAccountEvent(CreateAccountEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));

      final userCredential = await _firebaseAuthService.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      );

      if (userCredential.user != null) {
        emit(
          state.copyWith(
            authenticationStatus: AuthenticationStatus.authenticated,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = _firebaseAuthService.getAuthErrorMessage(e);
      debugPrint('FirebaseAuthException: ${e.code} - $errorMessage');
      emit(
        state.copyWith(
          authenticationStatus: AuthenticationStatus.unauthenticated,
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      debugPrint('Exception in _createAccountEvent: $e');
      emit(
        state.copyWith(
          authenticationStatus: AuthenticationStatus.unauthenticated,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  Future<void> _signInEvent(SignInEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));

      final userCredential = await _firebaseAuthService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (userCredential.user != null) {
        emit(
          state.copyWith(
            authenticationStatus: AuthenticationStatus.authenticated,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = _firebaseAuthService.getAuthErrorMessage(e);
      debugPrint('FirebaseAuthException: ${e.code} - $errorMessage');
      emit(
        state.copyWith(
          authenticationStatus: AuthenticationStatus.unauthenticated,
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      debugPrint('Exception in _signInEvent: $e');
      emit(
        state.copyWith(
          authenticationStatus: AuthenticationStatus.unauthenticated,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  Future<void> _signOutEvent(SignOutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await _firebaseAuthService.signOut();
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.unauthenticated));
    } catch (e) {
      debugPrint('Exception in _signOutEvent: $e');
      emit(
        state.copyWith(
          authenticationStatus: AuthenticationStatus.unauthenticated,
          errorMessage: 'An unexpected error occurred while signing out. Please try again.',
        ),
      );
    }
  }

  Future<void> _updateProfileEvent(UpdateProfileEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await _firebaseAuthService.updateUserProfile(displayName: event.fullName);

      emit(
        state.copyWith(
          authenticationStatus: AuthenticationStatus.authenticated,
          errorMessage: null,
        ),
      );
    } catch (e) {
      debugPrint('Exception in _updateProfileEvent: $e');
      emit(
        state.copyWith(
          authenticationStatus: AuthenticationStatus.authenticated,
          errorMessage: 'Failed to update profile. Please try again.',
        ),
      );
    }
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
