import 'package:chat_assessment/service/auth_service/auth_service.dart';
import 'package:chat_assessment/service/navigation_service.dart';
import 'package:chat_assessment/service/routing_service.dart';
import 'package:chat_assessment/utils/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../service/service_locator.dart';


class SignUpViewModel extends BaseViewModel {

  final AuthService _authService = locator<AuthService>();

  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  showPassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }


  //TODO: Email verification is not implemented
  //TODO: Forget password not implemented
  register() async {
    if(!formKey.currentState!.validate()) {
      return;
    }
    setBusy(true);
    try {
      UserCredential userCredential = await _authService.register(email: emailController.text, password: passwordController.text);
      await _addUserDetails(userCredential);
      toastMessage(message: "User registered!");
      locator<NavigationService>().navigateTo(loginView);
    } catch(e) {
      toastMessage(message: "$e");
    } finally {
      setBusy(false);
    }
  }

  _addUserDetails(UserCredential userCredential) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
        "id": userCredential.user!.uid,
        "first name": firstNameController.text.trim(),
        "last name": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "created at": DateTime.now(),
      });
    } catch(e) {
      rethrow;
    }
  }




  disposeControllers() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
