part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus authenticationStatus;

  const AuthenticationState({
    this.authenticationStatus = AuthenticationStatus.unauthenticated,
  });

  @override
  List<Object?> get props => [authenticationStatus];

  AuthenticationState copyWith({
    AuthenticationStatus? authenticationStatus,
    bool clearUserEntity = false,
  }) {
    return AuthenticationState(
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
    );
  }
}
