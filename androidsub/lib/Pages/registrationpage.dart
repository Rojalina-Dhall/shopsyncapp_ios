import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsync_app/Pages/Homepage.dart';
import 'package:shopsync_app/Pages/loginpage.dart';
import 'package:shopsync_app/services/auth_service.dart';


class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  // Uint8List? _image;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
    cityController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
  if (_formKey.currentState!.validate()) {
    // 1️⃣ Sign up the user
    await _authService.signupUser(
      email: emailController.text.trim(),
      password: pwdController.text.trim(),
      name: nameController.text.trim(),
      city: cityController.text.trim(),
      context: context,
    );

    

    // 4️⃣ Navigate to HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // backgroundColor: const Color(0xFF0A84FF),
        title: const Text("User Registration",style: TextStyle(
      color: Colors.white,  // 👈 Title color
    ),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
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
                        "Create Account",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      _buildTextField(nameController, "Name", false),
                      SizedBox(height: screenHeight * 0.02),
                      _buildTextField(emailController, "Email", false,
                          keyboard: TextInputType.emailAddress),
                      SizedBox(height: screenHeight * 0.02),
                      _buildTextField(pwdController, "Password", true),
                      SizedBox(height: screenHeight * 0.02),
                      _buildTextField(confirmPwdController, "Confirm Password", true,
                          validator: (value) {
                        if (value != pwdController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      }),
                      SizedBox(height: screenHeight * 0.02),
                      _buildTextField(cityController, "City", false),
                      SizedBox(height: screenHeight * 0.04),
                      GestureDetector(
                        onTap: signup,
                        child: Container(
                          width: double.infinity,
                          height: screenHeight * 0.065,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient:  LinearGradient(
                               colors: [Colors.deepPurple, Colors.purpleAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
                          
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.deepPurple),
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
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool isPassword,
      {TextInputType keyboard = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboard,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $label";
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
