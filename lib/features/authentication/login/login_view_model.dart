import 'package:chat_assessment/service/auth_service/auth_service.dart';
import 'package:chat_assessment/service/auth_service/facebook_auth_service.dart';
import 'package:chat_assessment/service/auth_service/google_auth_service.dart';
import 'package:chat_assessment/service/routing_service.dart';
import 'package:chat_assessment/utils/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../service/navigation_service.dart';
import '../../../service/service_locator.dart';


class LoginViewModel extends BaseViewModel {

  final AuthService _authService = locator<AuthService>();

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  showPassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  login() async {
    if(!formKey.currentState!.validate()) {
      return;
    }
    setBusy(true);
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      await _authService.login(email: emailController.text, password: passwordController.text).then((UserCredential userCredential) {
        locator<NavigationService>().navigateToAndRemoveAll(userListView);
      });

    } catch(e) {
      toastMessage(message: "$e");
    } finally {
      setBusy(false);
    }
  }



  final String socialSignInBusyKey = "socialSignInBusyKey";

  final GoogleAuthService _googleAuthService = locator<GoogleAuthService>();
  signInWithGoogle() async {
    setBusyForObject(socialSignInBusyKey, true);
    try {
      UserCredential userCredential = await _googleAuthService.signInWithGoogle();
      await _addUserDetails(userCredential);
      locator<NavigationService>().navigateToAndRemoveAll(userListView);
    } catch(e) {
      toastMessage(message: "$e");
    } finally {
      setBusyForObject(socialSignInBusyKey, false);
    }
  }

  _addUserDetails(UserCredential userCredential) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
        "id": userCredential.user!.uid,
        "first name": userCredential.user?.displayName!= null
            ? userCredential.user?.displayName!.split(" ").first
            : "",
        "last name": userCredential.user?.displayName!= null
            ? userCredential.user?.displayName!.split(" ").last
            : "",
        "email": userCredential.user?.email,
        "created at": DateTime.now(),
      });
    } catch(e) {
      rethrow;
    }
  }


  final FacebookAuthService _facebookAuthService = locator<FacebookAuthService>();
  signInWithFacebook() async {
    setBusyForObject(socialSignInBusyKey, true);
    try {
      UserCredential userCredential = await _facebookAuthService.signInWithFacebook();
      await _addUserDetails(userCredential);
      locator<NavigationService>().navigateToAndRemoveAll(userListView);
    } catch(e) {
      toastMessage(message: "$e");
    } finally {
      setBusyForObject(socialSignInBusyKey, false);
    }
  }


  disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }
}
