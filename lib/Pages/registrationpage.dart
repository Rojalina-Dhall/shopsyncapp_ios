

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shopsync_app/Pages/loginpage.dart';
import 'package:shopsync_app/services/auth_service.dart';
import 'package:shopsync_app/widgets/gradient_button.dart';
import 'package:shopsync_app/widgets/text_field.dart';
import 'package:shopsync_app/resources/validate_methods.dart';




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
  if (!_formKey.currentState!.validate()) return;

  // Show loader
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  try {
    await _authService.signupUser(
      email: emailController.text,
      password: pwdController.text,
      name: nameController.text,
      city: cityController.text,
    );

    if (!mounted) return;

    Navigator.of(context).pop(); // ✅ close loader
    Navigator.of(context).pop(); // ✅ close registration page

    // ❌ DO NOT navigate to Home
    // RootPage will show HomeNavigationScreen automatically

  } catch (e) {
    Navigator.of(context).pop(); // close loader

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e is FirebaseAuthException
              ? e.message ?? "Signup failed"
              : "Something went wrong",
        ),
      ),
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
  elevation: 0,
  centerTitle: true,
  title: const Text(
    "Get Started",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Card(
  elevation: 10,
  shadowColor: const Color(0xFF6A5AE0).withOpacity(0.35),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
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
                      AppTextField(
  controller: nameController,
  label: "Name",
  isPassword: false,
  validator: ValidateMethods().validateName,
),

                      SizedBox(height: screenHeight * 0.02),
                      AppTextField(
  controller: emailController,
  label: "Email",
  isPassword: false,
  keyboard: TextInputType.emailAddress,
  validator: ValidateMethods().validateEmail,
),

                         
                      SizedBox(height: screenHeight * 0.02),
                     AppTextField(
  controller: pwdController,
  label: "Password",
  isPassword: true,
  validator: ValidateMethods().validatePassword,
),

                      SizedBox(height: screenHeight * 0.02),
                      AppTextField(
  controller: confirmPwdController,
  label: "Confirm Password",
  isPassword: true,
  validator: (value) =>
      ValidateMethods().validateConfirmPassword(value, pwdController.text),
),

                          
                      SizedBox(height: screenHeight * 0.02),
                     AppTextField(
  controller: cityController,
  label: "City",
  isPassword: false,
  validator: ValidateMethods().validateCityName,
),

                      SizedBox(height: screenHeight * 0.04),
                    GradientButton(
  text: "Register",
  width: screenWidth * 0.6, // 👈 narrower
  height: screenHeight * 0.06,
  onTap: signup,
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
      ),
    );
  }
}

  // 🔧 Styled text field