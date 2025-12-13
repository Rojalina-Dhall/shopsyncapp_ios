import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  // Constructor
  const CustomMaterialButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10.0,
      color: Colors.blue,
      textColor: Colors.white,
      // textTheme: TextStyle(fontSize: 18,color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.bold, // Make text bold
          letterSpacing:
              12.0, // Adjust this value to set the space between characters
        ),
      ),
    );
  }
}
