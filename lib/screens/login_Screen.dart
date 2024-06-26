
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/custom_Button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 20,
            color: Colors.white,
          ),
          title: const Text(
            'Sign in',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.black,
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
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                        color: Colors.white,
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
                  fillColor: Colors.white,
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
                  Future.delayed(const Duration(seconds: 1), () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushReplacementNamed(context, '/main');
                      }
                    } catch (e) {
                      // Show a dialog with an error message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content:
                                const Text('Enter credentials and try again.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
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
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Social Logins',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: 80.0,
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Don\'t have an account?',
              style: TextStyle(color: Colors.blueGrey, fontSize: 15),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                'REGISTER',
                style: TextStyle(
                    color: Colors.white,
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
