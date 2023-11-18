import 'package:chat_assessment/features/user/user_model.dart';
import 'package:chat_assessment/service/auth_service/auth_service.dart';
import 'package:chat_assessment/service/auth_service/facebook_auth_service.dart';
import 'package:chat_assessment/service/auth_service/google_auth_service.dart';
import 'package:chat_assessment/service/navigation_service.dart';
import 'package:chat_assessment/service/routing_service.dart';
import 'package:chat_assessment/service/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class UserViewModel extends BaseViewModel {

  final Stream<QuerySnapshot<UserModel>> usersListStream = FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
    fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
    toFirestore: (users, _) => users.toJson(),
  ).where('id', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots();

  goToChat(String receiverId, String receiverName) async {
    locator<NavigationService>().navigateToAndBack(chatView, arguments: {"receiverName": receiverName, "receiverId": receiverId});
  }


  signOut() {
    locator<AuthService>().signOut();
    locator<GoogleAuthService>().signOut();
    locator<FacebookAuthService>().signOut();
  }
}