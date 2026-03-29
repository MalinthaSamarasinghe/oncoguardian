part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class CreateAccountEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String fullName;

  const CreateAccountEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });

  @override
  List<Object?> get props => [email, password, fullName];
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutEvent extends AuthenticationEvent {
  const SignOutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends AuthenticationEvent {
  final String fullName;

  const UpdateProfileEvent({required this.fullName});

  @override
  List<Object?> get props => [fullName];
}
