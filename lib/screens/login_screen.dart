import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 0, 5),
                  child: Text(
                    'EMAIL',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    //labelText: '',
                    hintText: 'Phone number, email or user name'),
                style: const TextStyle(color: Colors.black, fontSize: 14),
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 0, 5),
                  child: Text(
                    'PASSWORD',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 300,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Password',
                ),
                style: const TextStyle(color: Colors.black, fontSize: 14),
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
                text: 'LOGIN',
                height: 44.0,
                // padding: const EdgeInsets.fromLTRB(120, 10, 120, 10),
                onPressed: () async {
                  Navigator.pushNamed(context, '/');
                  // Simulate a delay for loading
                  Future.delayed(const Duration(seconds: 1), () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, '/first');
                      }
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  });
                }),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: 80.0,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Social Logins',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: 80.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.facebook_sharp,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 30),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.g_mobiledata,
                    size: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Don\'t have an account?',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                'REGISTER',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
