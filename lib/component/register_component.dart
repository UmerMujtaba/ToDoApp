import 'package:flutter/material.dart';

class RegisterOption extends StatelessWidget {
  const RegisterOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Enter Name',
            ),
            style: const TextStyle(color: Colors.white, fontSize: 14),
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
            // obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Enter Email',
            ),
            style: const TextStyle(color: Colors.white, fontSize: 14),
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
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Enter Password',
            ),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
