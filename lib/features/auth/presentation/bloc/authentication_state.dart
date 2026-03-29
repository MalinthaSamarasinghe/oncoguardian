part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus authenticationStatus;
  final String? errorMessage;

  const AuthenticationState({
    this.authenticationStatus = AuthenticationStatus.unauthenticated,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [authenticationStatus, errorMessage];

  AuthenticationState copyWith({
    AuthenticationStatus? authenticationStatus,
    String? errorMessage,
  }) {
    return AuthenticationState(
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      errorMessage: errorMessage,
    );
  }
}
