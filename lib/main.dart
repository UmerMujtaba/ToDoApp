import 'package:flutter/material.dart';
import 'component/loading.dart';
import 'pages/FrontScreen.dart';
import 'pages/FirstScreen.dart';
import 'pages/SettingsScreen.dart';
import 'component/BottomBar.dart';
import 'component/DrawerCheck.dart';
import 'pages/PremiumScreen.dart';
import 'component/drop.dart';
import 'pages/todoprovider.dart';

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
        '/d': (context)=>const DropButton(),
      },
    );
  }
}
