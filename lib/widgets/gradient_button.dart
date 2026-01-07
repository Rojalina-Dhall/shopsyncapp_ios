// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double borderRadius;

  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    this.height = 52,
    this.borderRadius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.deepPurpleAccent.withOpacity(0.18),
          highlightColor: Colors.deepPurpleAccent.withOpacity(0.08),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF6A5AE0),
                  Color(0xFF8E7BFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
