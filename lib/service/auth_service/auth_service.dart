import 'package:chat_assessment/service/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../routing_service.dart';
import '../service_locator.dart';

class AuthService {
  AuthService() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        }
        locator<NavigationService>().navigateToAndRemoveAll(loginView);
      } else {
        if (kDebugMode) {
          print('User is signed in!');
        }
      }
    });
  }

  bool get isUserLoggedIn {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<UserCredential> register({required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw e.message??e.code;
    } catch(e) {
      rethrow;
    }
  }

  Future<UserCredential> login({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      throw e.code;
    } catch(e) {
      rethrow;
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }


}