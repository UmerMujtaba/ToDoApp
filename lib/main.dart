import 'package:flutter/material.dart';
import 'package:instagramclone/screens/login_screen.dart';
import 'package:instagramclone/screens/registeration_screen.dart';
import 'component/loading.dart';
import 'screens/start_Screen.dart';
import 'screens/first_Screen.dart';
import 'screens/setting_Screen.dart';
import 'component/bottom_Bar.dart';
import 'component/drawer.dart';
import 'screens/premium_Screen.dart';
import 'model/todo_Provider.dart';

void main() => runApp(MyApp());

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
