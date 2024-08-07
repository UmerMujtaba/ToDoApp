import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../component/custom_Button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, required this.showLoginPage});

  final VoidCallback showLoginPage;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future Signup() async {
    try {
      final UserCredential newUser = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (newUser.user != null) {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneController.text.toString(),
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Automatically signs in the user
            await _auth.signInWithCredential(credential);
            Navigator.pushNamed(context, '/login');
          },
          verificationFailed: (FirebaseAuthException ex) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text('Phone verification failed: ${ex.message}'),
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
          },
          codeSent: (String verificationId, int? resendToken) {
            // Navigate to the code entry screen
            Navigator.pushNamed(
              context,
              '/login',
              arguments: verificationId,
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // Handle timeout scenario
            print('Code auto retrieval timeout');
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    //final Orientation orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Sign up',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                SizedBox(
                  //color: Colors.red,
                  height: screenHeight * 0.2,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[600],
                      maxRadius: 50,
                      child: const Icon(
                        Icons.person_rounded,
                        size: 90,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Add profile picture',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 0.55,
                  child: Center(
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.text_fields, size: 24),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Enter Name',
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),

                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(35, 5, 0, 0),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            // obscureText: true,
                            enableSuggestions: true,
                            controller: _emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.email, size: 24),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Enter Email',
                            ),

                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                        // const SizedBox(height: 15),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(35, 5, 0, 0),
                              child: Text(
                                'Password',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: TextField(
                            obscureText: _obscureText,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock, size: 24),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Enter Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(35, 5, 0, 0),
                              child: Text(
                                'Phone Number',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: TextField(
                            controller: phoneController,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone, size: 24),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Enter Phone Number',
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 1,
                  height: screenHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: 'LOGIN',
                        height: 44.0,
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });

                          widget.showLoginPage;
                        },
                      ),
                      const SizedBox(width: 20),
                      CustomButton(
                        text: 'REGISTER',
                        height: 44.0,
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          Signup();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
