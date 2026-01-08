import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller; // Controller for the TextFormField
  final String hintText; // Hint text for the TextFormField
  final String labelText; // Label text for the TextFormField
  final TextInputType? keyboardType; // Keyboard type, optional
  final String? Function(String?)?
      validator; // Validator function for validation
  final bool? isPassword;

  // Constructor to initialize the widget with required and optional parameters
  const CustomTextFormField({
    super.key,
    required this.controller, // Controller is required
    required this.hintText, // Hint text is required
    required this.labelText, // Label text is required
    this.validator, // Validator function is required
    this.keyboardType,
    this.isPassword,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isShow = true;
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    bool isItAPasswd = widget.isPassword ?? false;

    if (flag) {
      isItAPasswd ? isShow = false : isShow = true;
      flag = false;
    }

    print(widget.labelText);
    final TextInputType effectiveKeyboardType =
        widget.keyboardType ?? TextInputType.text;

    // if (!isItAPasswd) isShow = true;

    return TextFormField(
      controller: widget.controller,
      obscureText: !isShow,
      validator: widget.validator, // Set the validator for the TextFormField
      textAlign: TextAlign.center,
      keyboardType: effectiveKeyboardType, // Use TextInputType.text by default
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(28.0)),
            borderSide: BorderSide(color: Colors.blueGrey, width: 3.0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(28.0)),
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 114, 82, 255), width: 3.0)),
        errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(28.0)),
            borderSide: BorderSide(color: Colors.red, width: 3.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(28.0)),
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 114, 82, 255), width: 3.0)),
        labelText: widget.labelText, // Display the label text
        hintText: widget.hintText, // Display the hint text
        suffixIcon: isItAPasswd
            ? IconButton(
                icon: Icon(
                  isShow ? Icons.visibility : Icons.visibility_off,
                  //Icons.sms_failed,
                ),
                onPressed: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
              )
            : null,
        hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
      ),
    );
  }
}