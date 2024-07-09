import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/custom_Button.dart';

class LoginScreen extends StatefulWidget {
  String verificationId;
  final VoidCallback showRegisterPage;

  LoginScreen(
      {super.key,
      required this.verificationId,
      required this.showRegisterPage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  String password = '';
  bool showSpinner = false;
  bool _obscureText = true;
  TextEditingController otpController = TextEditingController();


  Future login() async{
    try {
      // Retrieve the verification ID from the arguments
      final String verificationId =
      ModalRoute.of(context)!.settings.arguments as String;

      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential =
      PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.toString(),
      );

      // Sign in with the phone credential
      UserCredential phoneAuthUser =
          await _auth.signInWithCredential(credential);

      // If phone authentication is successful, proceed with email sign-in
      if (phoneAuthUser.user != null) {
        // Sign in with email and password
        UserCredential emailAuthUser =
            await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (emailAuthUser.user != null) {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('email', email);
          Navigator.pushNamed(context, '/main');
        }
      }
    } catch (e) {
      print('Authentication Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Error: ${e.toString()}'),
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
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SizedBox(
          // color: Colors.red,
          height: screenHeight * 0.9,
          width: screenWidth * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('HELLO AGAIN',style: TextStyle(color: Colors.white,fontSize: 32),),
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
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.email, size: 24),
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
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock_rounded, size: 24),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  onChanged: (value) {
                    password = value;
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
                      'OTP',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  obscureText: false,
                  controller: otpController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'OTP',
                    prefixIcon: const Icon(Icons.numbers, size: 24),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgot');
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.lightBlue, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'LOGIN',
                height: 44.0,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                 login();

                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
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
              const SizedBox(height: 10),
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
                ),

            ],
          ),
        ),
      ),
    );
  }
}
