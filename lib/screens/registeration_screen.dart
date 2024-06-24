import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../component/button.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 20,
            color: Colors.white,
          ),
          title: const Text(
            'Back',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[600],
                    maxRadius: 60,
                    child: const Icon(
                      Icons.person_rounded,
                      size: 90,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Add profile picture',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const SizedBox(height: 15),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(35, 0, 0, 5),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 300,
                        height: 45,
                        child: TextField(
                          //obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Enter Name',
                          ),
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(35, 0, 0, 5),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 300,
                        height: 45,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          // obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Enter Email',
                          ),
                          onChanged: (value) {
                            email = value;
                            //Do something with the user input.
                          },
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(35, 0, 0, 5),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 300,
                        height: 45,
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
                            hintText: 'Enter Password',
                          ),
                          onChanged: (value) {
                            password = value;
                            //Do something with the user input.
                          },
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                CustomButton(
                  text: 'REGISTER',
                  height: 44.0,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, '/login');
                      }
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}