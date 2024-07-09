import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: screenHeight * 0.1,
                  child: Row(
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
                            // Navigator.pushNamed(context, '/');
                            // Simulate a delay for loading
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.pushNamed(
                                  context, '/register');
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
                ),
                //const SizedBox(height: 80),
                SizedBox(
                  height: screenHeight * 0.5,
                  child: const Image(
                    image: AssetImage('assets/two.png'),
                    height: 350,
                    //alignment: Alignment.center,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Manage Your Task',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontFamily: 'Freeman'),
                ),
                const Text(
                  'Manage and organize all your to-dos and tasks easily',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Opacity(
              opacity: 0.5,
              child: SizedBox(
                height: screenHeight * 0.2,
                width: screenWidth * 1,
                child: const Image(
                  image: AssetImage('assets/5.png'),
                  //height: 185,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
