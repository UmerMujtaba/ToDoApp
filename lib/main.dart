import 'package:flutter/material.dart';
import 'component/loading.dart';
import 'pages/FrontScreen.dart';
import 'pages/FirstScreen.dart';
import 'pages/SettingsScreen.dart';
import 'component/BottomBar.dart';
import 'component/DrawerCheck.dart';
import 'pages/PremiumScreen.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/front',
      routes: {
        '/': (context) => const Loading(),
        '/front': (context) => const Frontscreen(),
        '/first': (context) => const Firstscreen(),
        '/setting': (context) => const Setting(),
        '/bar': (context) => const bar(),
        '/drawer': (context) => const drawer(title: 'ok',),
        '/premium': (context) => const Premium(),

      },
    ));
