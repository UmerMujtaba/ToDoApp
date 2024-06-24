import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/login_Screen.dart';
import 'package:todoapp/screens/registeration_Screen.dart';
import 'component/loader.dart';
import 'screens/start_Screen.dart';
import 'screens/main_Screen.dart';
import 'screens/setting_Screen.dart';
import 'component/bottom_Bar.dart';
import 'component/drawer.dart';
import 'screens/premium_Screen.dart';
import 'model/todo_Provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCX68-DrxOtXBSnJgN9iuK2TQQz-4EslVM",
              appId: "1:835284065278:android:035b579d9fd9cd954cbeaf",
              messagingSenderId: "835284065278",
              projectId: "to-do-app-96bba"))
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TodoProvider todoProvider =
      TodoProvider(); // Create an instance of TodoProvider

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/front',
      routes: {
        '/': (context) => const Loading(),
        '/start': (context) => const StartScreen(),
        '/main': (context) => MainScreen(todoProvider: todoProvider),
        '/setting': (context) => const Setting(),
        '/bar': (context) => const Bar(),
        '/drawer': (context) => const DrawerApp(
              title: 'ok',
            ),
        '/premium': (context) => const Premium(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
      },
    );
  }
}
