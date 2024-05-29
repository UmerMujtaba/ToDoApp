import 'package:flutter/material.dart';
import 'pages/loading.dart';
import 'pages/FrontScreen.dart';
import 'pages/FirstScreen.dart';
import 'pages/SecondScreen.dart';
import 'pages/settings.dart';
// import 'pages/option.dart';
void main() => runApp(MaterialApp(
      initialRoute: '/front',
      routes: {
        '/': (context) => const Loading(),
        '/front': (context) => const Frontscreen(),
        '/first': (context) => const Firstscreen(),
        '/second': (context) => const Secondscreen(),
        '/setting': (context) => const Setting(),
        // '/opt': (context) => MenuAnchorApp(),
      },
    ));
