import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                          // Simulate a delay for loading
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushReplacementNamed(context, '/main');
                          });
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 80),
                const Image(
                  image: AssetImage('assets/two.png'),
                  height: 350,
                  //alignment: Alignment.center,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Manage Your Task',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontFamily: 'Freeman'),
                ),
                const Text(
                  'Manage and organize all your to-dos and tasks easily',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Opacity(
              opacity: 0.5,
              child: Image(
                image: AssetImage('assets/5.png'),
                //height: 185,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
