import 'package:logging/logging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oncoguardian/core/utils/log_manager.dart';

class OncoGuardianBlocObserver extends BlocObserver {
  final Logger log = Logger('BlocObserver');

  OncoGuardianBlocObserver() {
    LogManager.init(); // Initialize logging only once
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log.info('Bloc onCreate: $bloc\n');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    log.info('Bloc onEvent: $event\n');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // Uncomment if needed
    // log.fine("Bloc onChange: $change\n");
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    // Uncomment if needed
    // log.fine("Bloc onTransition: $transition\n");
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log.info('Bloc onClose: $bloc\n');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log.severe('Bloc onError: $error | stackTrace: $stackTrace\n');
  }
}
