import 'package:get_it/get_it.dart';
import 'package:oncoguardian/core/blocs/theme/theme_bloc.dart';
import 'package:oncoguardian/features/auth/presentation/bloc/authentication_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// Feature: Authentication
  getIt.registerLazySingleton<AuthenticationBloc>(AuthenticationBloc.new);

  /// Feature: Theme
  getIt.registerLazySingleton<ThemeBloc>(ThemeBloc.new);
}
