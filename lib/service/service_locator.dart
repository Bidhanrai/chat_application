import 'package:chat_assessment/service/auth_service/facebook_auth_service.dart';
import 'package:get_it/get_it.dart';
import 'auth_service/auth_service.dart';
import 'auth_service/google_auth_service.dart';
import 'navigation_service.dart';


final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => GoogleAuthService());
  locator.registerLazySingleton(() => FacebookAuthService());
  locator.registerLazySingleton(() => NavigationService());
}