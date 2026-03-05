import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/core/theme/dark_theme.dart';
import 'package:oncoguardian/core/theme/light_theme.dart';
import 'package:oncoguardian/core/enums/app_theme_mode.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oncoguardian/core/blocs/theme/theme_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:oncoguardian/features/auth/presentation/bloc/authentication_bloc.dart';

class OncoGuardianAppWrapper extends StatelessWidget {
  const OncoGuardianAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (context) => getIt<AuthenticationBloc>()),
        BlocProvider<ThemeBloc>(create: (context) => getIt<ThemeBloc>()),
      ],
      child: const OncoGuardianApp(),
    );
  }
}

class OncoGuardianApp extends StatefulWidget {
  const OncoGuardianApp({super.key});

  @override
  State<OncoGuardianApp> createState() => _OncoGuardianAppState();
}

class _OncoGuardianAppState extends State<OncoGuardianApp> {
  late final GoRouter _router;

  @override
  void initState() {
    /// Create router once
    _router = AppRouter.createRouter(getIt<AuthenticationBloc>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      buildWhen: (previous, current) => previous.appThemeMode.name != current.appThemeMode.name,
      builder: (context, state) {
        return MaterialApp.router(
          key: const ValueKey('MaterialApp'),
          routerConfig: _router,
          builder: (context, child) {
            child = EasyLoading.init()(context, child);

            /// Remove the splash screen
            FlutterNativeSplash.remove();
            return ScrollConfiguration(behavior: AppBehavior(), child: child);
          },
          debugShowCheckedModeBanner: false,
          title: 'OncoGuardian',
          theme: _getTheme(context),
        );
      },
    );
  }

  ThemeData _getTheme(BuildContext context) {
    return context.read<ThemeBloc>().state.appThemeMode == AppThemeMode.light
        ? LightTheme.themeData
        : DarkTheme.themeData;
  }
}

/// To remove scroll glow
class AppBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;
}
