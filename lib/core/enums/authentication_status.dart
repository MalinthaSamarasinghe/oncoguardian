import 'package:oncoguardian/core/enums/enum_values.dart';

enum AuthenticationStatus { authenticated, unauthenticated, sessionExpired, accountDeleted, logOutInProgress }

final authenticationStatusValues = EnumValues({
  'authenticated': AuthenticationStatus.authenticated,
  'unauthenticated': AuthenticationStatus.unauthenticated,
  'sessionExpired': AuthenticationStatus.sessionExpired,
  'accountDeleted': AuthenticationStatus.accountDeleted,
  'logOutInProgress': AuthenticationStatus.logOutInProgress,
});
