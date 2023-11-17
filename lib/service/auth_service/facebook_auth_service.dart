import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {

  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      return userCredential;
    } on FirebaseAuthException catch(e) {
      throw e.message??e.code;
    } catch(e) {
      rethrow;
    }
  }
}