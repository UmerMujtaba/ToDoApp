import 'package:flutter/material.dart';
import 'package:instagramclone/pages/option.dart';
import 'component/loading.dart';
import 'pages/FrontScreen.dart';
import 'pages/FirstScreen.dart';
import 'pages/settings.dart';
import 'pages/barcheck.dart';
import 'component/DrawerCheck.dart';
import 'pages/premium.dart';

// import 'pages/option.dart';
void main() => runApp(MaterialApp(
      initialRoute: '/front',
      routes: {
        '/': (context) => const Loading(),
        '/front': (context) => const Frontscreen(),
        '/first': (context) => const Firstscreen(),
        '/setting': (context) => const Setting(),
        '/opt': (context) => const MenuAnchorExample(),
        '/bar': (context) => const bar(),
        '/drawer': (context) => const drawer(
              title: 'ok',
            ),
        '/premium': (context) => const Premium(),

      },
    ));
