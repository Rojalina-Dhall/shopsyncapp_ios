import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shopsync_app/Pages/registrationpage.dart';
import 'package:shopsync_app/widgets/gradient_button.dart'; // rename if needed
import 'package:shopsync_app/widgets/text_field.dart';
import 'package:shopsync_app/resources/validate_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: pwdController.text.trim(),
        );

       
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
  centerTitle: true,
  title: const Text(
    "Welcome Back",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
  ),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF6A5AE0),
          Color(0xFF8E7BFF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
),

      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
      top: screenHeight * 0.10, // 👈 move card UP
      left: screenWidth * 0.06,
      right: screenWidth * 0.06,
      bottom: screenHeight * 0.04,
    ),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.deepPurpleAccent.withOpacity(0.3),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.04,
                  horizontal: screenWidth * 0.06,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // 🔹 Email Field
                      AppTextField(
  controller: emailController,
  label: "Email",
  isPassword: false,
  keyboard: TextInputType.emailAddress,
  validator: ValidateMethods().validateEmail,
),

                      SizedBox(height: screenHeight * 0.02),

                      // 🔹 Password Field
                      AppTextField(
  controller: pwdController,
  label: "Password",
  isPassword: true,
  validator: ValidateMethods().validatePassword,
),

                      SizedBox(height: screenHeight * 0.04),

                      // 🔹 Gradient Login Button
                      GradientButton(
  text: "Login",
  onTap: login,
  width: screenWidth * 0.75, // 👈 controlled width
),


                      SizedBox(height: screenHeight * 0.02),

                      // 🔹 Go to Register Page
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const UserRegistration()),
                              );
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(color: Colors.indigo),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  
  }

  
}
