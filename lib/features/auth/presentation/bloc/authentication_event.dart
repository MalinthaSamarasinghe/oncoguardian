part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class UserLoggedInEvent extends AuthenticationEvent {
  final AuthenticationStatus authenticationStatus;

  const UserLoggedInEvent({required this.authenticationStatus});

  @override
  List<Object?> get props => [authenticationStatus];
}

class UserLoggedOutEvent extends AuthenticationEvent {
  const UserLoggedOutEvent();

  @override
  List<Object?> get props => [];
}
