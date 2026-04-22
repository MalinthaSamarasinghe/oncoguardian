import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/routes/router_stream.dart';
import 'package:oncoguardian/routes/router_observer.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';
import 'package:oncoguardian/core/widgets/base_navigation.dart';
import 'package:oncoguardian/features/food/screen/food_screen.dart';
import 'package:oncoguardian/features/tips/screen/tips_screen.dart';
import 'package:oncoguardian/features/home/screen/home_screen.dart';
import 'package:oncoguardian/core/enums/authentication_status.dart';
import 'package:oncoguardian/features/onboarding/onboarding_screen.dart';
import 'package:oncoguardian/features/risk/screens/risk_result_screen.dart';
import 'package:oncoguardian/features/settings/screens/settings_screen.dart';
import 'package:oncoguardian/features/risk/screens/risk_assessment_screen.dart';
import 'package:oncoguardian/features/settings/screens/edit_profile_screen.dart';
import 'package:oncoguardian/features/settings/screens/account_settings_screen.dart';
import 'package:oncoguardian/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:oncoguardian/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:oncoguardian/features/auth/presentation/screens/create_account_screen.dart';
import 'package:oncoguardian/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:oncoguardian/features/auth/presentation/screens/term_conditions_screen.dart';
import 'package:oncoguardian/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:oncoguardian/features/auth/presentation/screens/create_new_password_screen.dart';

/// AppRouter is responsible for creating and configuring the app's navigation structure
class AppRouter {
  AppRouter._(); // Private constructor to prevent instantiation

  // Core static route paths
  // Onboarding & Auth Routes
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String createAccount = '/create-account';
  static const String emailVerification = '/email-verification';
  static const String forgotPassword = '/forgot-password';
  static const String createNewPassword = '/create-new-password';
  static const String termConditions = '/terms-conditions';

  // Authenticated Routes within Main Shell
  static const String home = '/home';
  static const String risk = '/risk';
  static const String riskResults = '/results';
  static const String food = '/food';
  static const String tips = '/tips';

  // Authenticated Routes outside Main Shell
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';
  static const String accountSettings = '/account-settings';

  // Error Routes
  static const String notFound = '/not-found';

  /// Creates and returns a GoRouter configured with dynamic routes based on the user's permissions
  static GoRouter createRouter(AuthenticationBloc authenticationBloc) {
    // Create the ValueNotifier for RoutingConfig
    final routingConfig = ValueNotifier<RoutingConfig>(_generateRoutingConfig(authenticationBloc));

    // Listen to auth changes and update routing config
    authenticationBloc.stream.listen((_) {
      routingConfig.value = _generateRoutingConfig(authenticationBloc);
    });

    return GoRouter.routingConfig(
      routingConfig: routingConfig,
      navigatorKey: GlobalKey<NavigatorState>(),
      observers: <NavigatorObserver>[OncoGuardianNavigatorObserver()],
      // debugLogDiagnostics: true,
      initialLocation: onboarding,
      refreshListenable: RouterStream(authenticationBloc.stream),
      onException: (_, GoRouterState state, GoRouter router) => router.push(notFound, extra: state.uri.toString()),
    );
  }

  /// Generates a new routing configuration based on current auth state
  static RoutingConfig _generateRoutingConfig(AuthenticationBloc authenticationBloc) {
    final bool isAuthenticated = authenticationBloc.state.authenticationStatus == AuthenticationStatus.authenticated;

    return RoutingConfig(
      routes: <RouteBase>[
        // Public routes available to all users
        ..._createPublicRoutes(),

        // Authenticated routes
        if (isAuthenticated) _createAuthenticatedMainShellRoutes(),
        if (isAuthenticated) ..._createAuthenticatedRoutes(),
      ],
      redirect: _handleRedirect(authenticationBloc),
    );
  }

  /// Creates the public routes that don't require authentication
  static List<RouteBase> _createPublicRoutes() {
    return [
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: signIn,
        name: 'sign-in',
        builder: (BuildContext context, GoRouterState state) {
          return const SignInScreen();
        },
      ),
      GoRoute(
        path: createAccount,
        name: 'create-account',
        builder: (BuildContext context, GoRouterState state) {
          return const CreateAccountScreen();
        },
      ),
      GoRoute(
        path: emailVerification,
        name: 'email-verification',
        builder: (BuildContext context, GoRouterState state) {
          return const EmailVerificationScreen();
        },
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgot-password',
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordScreen();
        },
      ),
      GoRoute(
        path: createNewPassword,
        name: 'create-new-password',
        builder: (BuildContext context, GoRouterState state) {
          return const CreateNewPasswordScreen();
        },
      ),
      GoRoute(
        path: termConditions,
        name: 'terms-conditions',
        builder: (BuildContext context, GoRouterState state) {
          return const TermConditionsScreen();
        },
      ),
      GoRoute(
        path: notFound,
        name: 'not-found',
        builder: (BuildContext context, GoRouterState state) {
          return NotFoundScreen(uri: state.extra as String? ?? state.uri.toString());
        },
      ),
    ];
  }

  /// Creates the main application shell with authenticated routes
  static RouteBase _createAuthenticatedMainShellRoutes() {
    return ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BaseNavigation(child: child);
      },
      routes: [
        GoRoute(
          path: home,
          name: 'home',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: risk,
          name: 'risk',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const RiskAssessmentScreen(),
            );
          },
        ),
        GoRoute(
          path: food,
          name: 'food',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const FoodScreen(),
            );
          },
        ),
        GoRoute(
          path: tips,
          name: 'tips',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const TipsScreen(),
            );
          },
        ),
      ],
    );
  }

  /// Creates the authenticated routes that are outside the main shell
  static List<RouteBase> _createAuthenticatedRoutes() {
    return [
      GoRoute(
        path: riskResults,
        name: 'results',
        builder: (BuildContext context, GoRouterState state) {
          return const RiskResultScreen();
        },
      ),
      GoRoute(
        path: settings,
        name: 'settings',
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsScreen();
        },
        routes: [
          GoRoute(
            path: editProfile,
            name: 'edit-profile',
            builder: (BuildContext context, GoRouterState state) {
              return const EditProfileScreen();
            },
          ),
          GoRoute(
            path: accountSettings,
            name: 'account-settings',
            builder: (BuildContext context, GoRouterState state) {
              return const AccountSettingsScreen();
            },
          ),
        ],
      ),
    ];
  }

  /// Handles redirection based on auth state
  static GoRouterRedirect _handleRedirect(AuthenticationBloc authenticationBloc) {
    return (context, state) {
      final bool isSignedIn = authenticationBloc.state.authenticationStatus == AuthenticationStatus.authenticated;
      final String uri = state.uri.toString();

      final bool isOnboarding = uri == onboarding;
      final bool isSigningIn = uri == signIn;
      final bool isCreatingAccount = uri == createAccount;
      final bool isEmailVerification = uri == emailVerification;
      final bool isForgotPassword = uri == forgotPassword;
      final bool isCreatingNewPassword = uri == createNewPassword;
      final bool isTermsConditions = uri == termConditions;
      final bool isNotFound = uri == notFound;

      // Don't redirect if already on 404 page route
      if (isNotFound) {
        return null;
      }

      // Redirect unauthenticated users to sign-in page route
      if (!isSignedIn && !isOnboarding && !isSigningIn && !isCreatingAccount && !isEmailVerification && !isForgotPassword && !isCreatingNewPassword && !isTermsConditions) {
        return signIn;
      }

      // Redirect signed-in users away from the sign-in page route
      if (isSignedIn && (isOnboarding || isSigningIn || isCreatingAccount || isEmailVerification || isForgotPassword || isCreatingNewPassword || isTermsConditions)) {
        return home;
      }

      return null; // No redirect needed
    };
  }
}

/// The Not Found Screen
class NotFoundScreen extends StatelessWidget {
  final String uri;

  const NotFoundScreen({super.key, required this.uri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Page Not Found'),
        titleTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 25, height: 1.41),
        leadingWidth: 83,
        titleSpacing: 2,
        leading: !GoRouter.of(context).canPop()
            ? null
            : Center(
                child: AppIconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    GoRouter.of(context).pop();
                  },
                  backgroundColor: const Color(0xFFF3F4F6),
                  iconWidget: SvgPicture.asset('assets/svg/back.svg', width: 24, height: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
                ),
              ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('404 - Page Not Found'),
            const SizedBox(height: 16),
            Text('Requested URI: $uri'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRouter.home),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF242424),
                foregroundColor: const Color(0xFFFFFFFF),
              ),
              child: const Text('Go Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
