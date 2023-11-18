import 'package:chat_assessment/features/authentication/login/login_view.dart';
import 'package:chat_assessment/features/authentication/sign_up/signup_view.dart';
import 'package:chat_assessment/features/splash_view.dart';
import 'package:flutter/material.dart';
import '../features/chat/chat_view.dart';
import '../features/user/users_view.dart';

const String splashView = "splashView";
const String loginView = "loginView";
const String signUpView = "signUpView";
const String userListView = "userListView";
const String chatView = "chatView";


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashView:
      return CustomPageRoute(child: const SplashView(), routeSettings: settings);
    case loginView:
      return CustomPageRoute(child: const LoginView(), routeSettings: settings);
    case signUpView:
      return CustomPageRoute(child: const SignUpView(), routeSettings: settings);
    case userListView:
      return CustomPageRoute(child: const UserListView(), routeSettings: settings);
    case chatView:
      String receiverId = (settings.arguments as Map)["receiverId"] as String;
      String receiverName = (settings.arguments as Map)["receiverName"] as String;
      return CustomPageRoute(child: ChatView(receiverId: receiverId, receiverName: receiverName), routeSettings: settings);
  default:
      return MaterialPageRoute(builder: (context) => Material(child: Center(child: Text("No such route ${settings.name}"),)));
  }
}


class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final RouteSettings routeSettings;

  CustomPageRoute({required this.child, required this.routeSettings})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => child,
            settings: routeSettings);
}
