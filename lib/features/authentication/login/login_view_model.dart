import 'package:chat_assessment/service/routing_service.dart';
import 'package:stacked/stacked.dart';

import '../../../service/navigation_service.dart';
import '../../../service/service_locator.dart';

class LoginViewModel extends BaseViewModel {

  AuthState _authState = AuthState.login;
  AuthState get authState => _authState;
  changeAuthSate() {
    _authState = _authState==AuthState.login?AuthState.register:AuthState.login;
    notifyListeners();
  }

  login() {
    locator<NavigationService>().navigateToAndRemoveAll(userListView);
  }

}

enum AuthState {
  login,
  register;
}