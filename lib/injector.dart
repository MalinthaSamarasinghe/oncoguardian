import 'package:get_it/get_it.dart';
import 'package:oncoguardian/core/blocs/theme/theme_bloc.dart';
import 'package:oncoguardian/core/services/firebase_firestore_service.dart';
import 'package:oncoguardian/features/auth/data/services/firebase_auth_service.dart';
import 'package:oncoguardian/features/auth/presentation/bloc/authentication_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// Feature: Authentication
  getIt.registerLazySingleton<FirebaseAuthService>(FirebaseAuthService.new);
  getIt.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc(firebaseAuthService: getIt<FirebaseAuthService>()));

  /// Core Services
  getIt.registerLazySingleton<FirebaseFirestoreService>(FirebaseFirestoreService.new);

  /// Feature: Theme
  getIt.registerLazySingleton<ThemeBloc>(ThemeBloc.new);
}
