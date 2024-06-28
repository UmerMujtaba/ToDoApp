import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String finalEmail;
class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamed(
            context,
            finalEmail == null ? '/login' : '/main'
        );
      });
    });

    super.initState();
  }

  Future getValidationData() async{
    final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    var obtainedEmail = sharedpreferences.getString('email');
    setState(() {
      finalEmail=obtainedEmail!;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: SpinKitFadingCircle(
        color: Colors.white,
        size: 40,
      )),
    );
  }
}
