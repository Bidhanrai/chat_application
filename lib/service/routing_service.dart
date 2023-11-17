import 'package:chat_assessment/features/authentication/login/login_view.dart';
import 'package:chat_assessment/features/splash_view.dart';
import 'package:flutter/material.dart';
import '../features/chat/chat_view.dart';
import '../features/user/users_view.dart';

const String splashView = "splashView";
const String loginView = "loginView";
const String userListView = "userListView";
const String chatView = "chatView";


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashView:
      return CustomPageRoute(child: const SplashView(), routeSettings: settings);
    case loginView:
      return CustomPageRoute(child: const LoginView(), routeSettings: settings);
    case userListView:
      return CustomPageRoute(child: const UserListView(), routeSettings: settings);
    case chatView:
      return CustomPageRoute(child: const ChatView(), routeSettings: settings);
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
