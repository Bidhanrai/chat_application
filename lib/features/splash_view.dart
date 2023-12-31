import 'package:chat_assessment/service/auth_service/auth_service.dart';
import 'package:chat_assessment/service/navigation_service.dart';
import 'package:chat_assessment/service/routing_service.dart';
import 'package:flutter/material.dart';
import '../service/service_locator.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    _checkIfUserLoggedIn();
  }

  _checkIfUserLoggedIn() async {
    Future.delayed(const Duration(seconds: 1), () {
      if(locator<AuthService>().isUserLoggedIn) {
        locator<NavigationService>().navigateToAndRemoveAll(userListView);
      } else {
        locator<NavigationService>().navigateToAndRemoveAll(loginView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.flutter_dash, size: 100, color: Colors.blue.shade600,),
      ),
    );
  }
}
