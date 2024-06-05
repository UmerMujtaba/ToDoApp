import 'package:flutter/material.dart';

class Premium extends StatelessWidget {
  const Premium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.cyanAccent],
              begin: Alignment.centerRight,
              end: Alignment(-1.0, -1.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: const Row(
                  children: <Image>[
                    Image(
                      image: AssetImage('assets/coin.png'),
                      fit: BoxFit.contain,
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Image(
                    image: AssetImage('assets/ok.png'),
                    width: 300,
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'UPGRADE',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'PRO',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Full access to all features',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Unlimited changes and data',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Expanded(
                            child: Text(
                              'Access to all feature updates',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'No advertisement add',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Premium support',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[600],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Unlock Premium',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
