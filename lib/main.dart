import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'package:todoapp/screens/registeration_screen.dart';
import 'component/loading.dart';
import 'screens/start_Screen.dart';
import 'screens/first_Screen.dart';
import 'screens/setting_Screen.dart';
import 'component/bottom_Bar.dart';
import 'component/drawer.dart';
import 'screens/premium_Screen.dart';
import 'model/todo_Provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
  ? await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyCX68-DrxOtXBSnJgN9iuK2TQQz-4EslVM", appId: "1:835284065278:android:035b579d9fd9cd954cbeaf", messagingSenderId: "835284065278", projectId: "to-do-app-96bba")
  )
  : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TodoProvider todoProvider = TodoProvider(); // Create an instance of TodoProvider

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/front',
      routes: {
        '/': (context) => const Loading(),
        '/front': (context) => const Frontscreen(),
        '/first': (context) => Firstscreen(todoProvider: todoProvider), // Pass todoProvider to Firstscreen
        '/setting': (context) => const Setting(),
        '/bar': (context) => const bar(),
        '/drawer': (context) => const drawer(title: 'ok',),
        '/premium': (context) => const Premium(),
        '/login':(context)=>const LoginScreen(),
        '/register':(context)=>const RegistrationScreen(),
      },
    );
  }
}
