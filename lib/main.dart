import 'package:chat_assessment/service/navigation_service.dart';
import 'package:chat_assessment/service/routing_service.dart';
import 'package:chat_assessment/service/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Chat Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          appBarTheme: const AppBarTheme(
            color: Colors.blue,
            foregroundColor: Colors.white
          ),
          useMaterial3: true,
        ),
        navigatorKey: locator<NavigationService>().navigationKey,
        onGenerateRoute: generateRoute,
        initialRoute: splashView,
      ),
    );
  }
}

