import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; //to be changed depending on use
  final double height; //to be changed depending on use
  final EdgeInsets padding; //to be changed depending on use
  final VoidCallback onPressed; //to be changed depending on use

  const CustomButton({
    super.key,
    required this.text,
    this.height =
        44.0, //const provided, if nt given in any screen it will be called there
    this.padding = const EdgeInsets.fromLTRB(40, 10, 40, 10),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.blueGrey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, letterSpacing: 2),
        ),
      ),
    );
  }
}
