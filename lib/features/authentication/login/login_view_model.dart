import 'package:chat_assessment/service/auth_service/auth_service.dart';
import 'package:chat_assessment/service/auth_service/facebook_auth_service.dart';
import 'package:chat_assessment/service/auth_service/google_auth_service.dart';
import 'package:chat_assessment/service/routing_service.dart';
import 'package:chat_assessment/utils/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import '../../../service/navigation_service.dart';
import '../../../service/service_locator.dart';


class LoginViewModel extends BaseViewModel {

  LoginViewState _viewState = LoginViewState.login;
  LoginViewState get viewState => _viewState;
  changeLoginViewSate() {
    _viewState = _viewState==LoginViewState.login?LoginViewState.register:LoginViewState.login;
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }


  final AuthService _authService = locator<AuthService>();

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  showPassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  UserCredential? _userCredential;
  UserCredential? get userCredential => _userCredential;
  login() async {
    setBusy(true);
    try {
      if(!formKey.currentState!.validate()) {
        return;
      }
      _userCredential = await _authService.login(email: emailController.text, password: passwordController.text);
      if(_userCredential != null) {
        locator<NavigationService>().navigateToAndRemoveAll(userListView);
      }
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      toastMessage(message: "$e");
    } finally {
      setBusy(false);
    }
  }


  register() async {
    setBusy(true);
    try {
      if(!formKey.currentState!.validate()) {
        return;
      }
      _userCredential = await _authService.register(email: emailController.text, password: passwordController.text);
      if(_userCredential != null) {
        toastMessage(message: "User registered!");
        changeLoginViewSate();
      }
    } catch(e) {
      toastMessage(message: "$e");
    } finally {
      setBusy(false);
    }
  }



  final String socialSignUpBusyKey = "socialSignUpBusyKey";

  final GoogleAuthService _googleAuthService = locator<GoogleAuthService>();
  signInWithGoogle() async {
    setBusyForObject(socialSignUpBusyKey, true);
    try {
      _userCredential = await _googleAuthService.signInWithGoogle();
      if(_userCredential != null) {
        locator<NavigationService>().navigateToAndRemoveAll(userListView);
      }
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      toastMessage(message: "$e");
    } finally {
      setBusyForObject(socialSignUpBusyKey, false);
    }
  }


  final FacebookAuthService _facebookAuthService = locator<FacebookAuthService>();
  signInWithFacebook() async {
    setBusyForObject(socialSignUpBusyKey, true);
    try {
      _userCredential = await _facebookAuthService.signInWithFacebook();
      if(_userCredential != null) {
        locator<NavigationService>().navigateToAndRemoveAll(userListView);
      }
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      toastMessage(message: "$e");
    } finally {
      setBusyForObject(socialSignUpBusyKey, false);
    }
  }


  disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }
}

enum LoginViewState {
  login,
  register;
}