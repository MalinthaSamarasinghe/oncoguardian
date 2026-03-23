import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/injector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:oncoguardian/firebase_options.dart';
import 'package:oncoguardian/oncoguardian_app.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:oncoguardian/core/blocs/bloc_observer.dart';
import 'package:oncoguardian/core/utils/config_easy_loader.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      /// Initialize service locator
      await setupServiceLocator();

      /// Set theme for EasyLoader indicator
      ConfigEasyLoader.darkTheme();

      /// Setup global observer to monitor all blocs
      Bloc.observer = OncoGuardianBlocObserver();

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
      );

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      // ignore: prefer_const_constructors
      setUrlStrategy(PathUrlStrategy());

      GoRouter.optionURLReflectsImperativeAPIs = true;

      runApp(const OncoGuardianAppWrapper());
    },
    (error, stack) {
      debugPrint('runZonedGuarded: Caught error in my root zone. $error | stack $stack');
    },
  );
}
