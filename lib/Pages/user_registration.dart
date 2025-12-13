// import 'dart:typed_data';

// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// import 'package:shopsync_app/Pages/Homepage.dart';
// import 'package:shopsync_app/resources/auth_methods.dart';
// import 'package:shopsync_app/Pages/custom_materialbutton.dart';
// import 'package:shopsync_app/Pages/custom_textfield.dart';
// import 'package:shopsync_app/resources/validate_methods.dart';
// import 'package:shopsync_app/services/auth_service.dart';



// class UserRegistration extends StatefulWidget {
//   const UserRegistration({super.key});

//   @override
//   State<UserRegistration> createState() => UserRegistrationPageState();
// }

// class UserRegistrationPageState extends State<UserRegistration> {
//   late String name;
//   late String email;
//   late String password;
//   Uint8List? _image;
//   final AuthService _authService = AuthService();

//   TextEditingController namecontroller = TextEditingController();
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController pwdcontroller = TextEditingController();
//   TextEditingController confirmpwdcontroller = TextEditingController();
//   TextEditingController citycontroller = TextEditingController();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   //final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
//   //GlobalKey<ScaffoldMessengerState>();
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     namecontroller.dispose();
//     emailcontroller.dispose();
//     pwdcontroller.dispose();
//     citycontroller.dispose();
//     super.dispose();
//   }

//   // selectImage() async {
//   //   Uint8List im = await pickImage(ImageSource.gallery);
//   //   //set state because we need to display the image we selected on the circle avatar
//   //   setState(() {
//   //     _image = im;
//   //   });
//   // }

//   // Future<void> signup() async {
//   //   if (_formKey.currentState!.validate()) {
//   //     //_formKey.currentState!.save();
//   //     await AuthMethods().signUpUser(
//   //         email: emailcontroller.text,
//   //         password: pwdcontroller.text,
//   //         name: namecontroller.text,
//   //         // file: _image!,
//   //         city: citycontroller.text);

           

//       // onPressed:
//       // () {
//       //Future.delayed(Duration(seconds: 20), () {
//       //Navigator.pop(context); // Pop the page after the delay
//       // ScaffoldMessenger.of(context)
//       //     .showSnackBar(SnackBar(content: Text("You're in! Enjoy exploring.")));
//       // //});
//       // showSnackBar(context, "You're in! Enjoy exploring.");
//       //  Future.delayed(Duration(seconds: 3), () {
//       //   Navigator.pushReplacement(
//       //        context,
//       //        MaterialPageRoute(
//       //           builder: (BuildContext context) =>
//       //                const HomePage()));
//       //  });
//       //   };
//     //  }


// // Future<void> signup() async {
// //   if (_formKey.currentState!.validate()) {

// //     // 1️⃣ Call your Firebase Cloud Function
// // final callable = FirebaseFunctions.instanceFor(region: 'us-central1')
// //     .httpsCallable('createUserAccount');

// // final result = await callable.call({
// //   "email": emailcontroller.text.trim(),
// //   "password": pwdcontroller.text.trim(),
// // });

// // print("User created: ${result.data['uid']}");

// // // Sign in the user
// // await FirebaseAuth.instance.signInWithEmailAndPassword(
// //   email: emailcontroller.text.trim(),
// //   password: pwdcontroller.text.trim(),
// // );

// // // Check last sign-in time
// // final user = FirebaseAuth.instance.currentUser!;
// // await user.reload();
// // print("Last sign-in: ${user.metadata.lastSignInTime}");


// //     // 4️⃣ Navigate to HomePage
// //     Future.delayed(Duration(seconds: 1), () {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => const HomePage()),
// //       );
// //     });
//   //  }
// // }


// // Future<void> signup() async {
// //   if (_formKey.currentState!.validate()) {
// //     try {
// //       // 1️⃣ Call your Firebase Cloud Function
// //       final callable = FirebaseFunctions.instanceFor(region: 'us-central1')
// //           .httpsCallable('createUserAccount');

// //       final result = await callable.call({
// //         "email": emailcontroller.text.trim(),
// //         "password": pwdcontroller.text.trim(),
// //         "name": namecontroller.text.trim(),
// //         "city": citycontroller.text.trim(),
// //       });

// //       print("🔥 User created by Cloud Function: ${result.data['uid']}");

// //       // 2️⃣ Sign in the user
// //       await FirebaseAuth.instance.signInWithEmailAndPassword(
// //         email: emailcontroller.text.trim(),
// //         password: pwdcontroller.text.trim(),
// //       );

// //       // 3️⃣ Check last sign-in time
// //       final user = FirebaseAuth.instance.currentUser!;
// //       await user.reload();
// //       print("⏱️ Last sign-in: ${user.metadata.lastSignInTime}");

// //       // 4️⃣ Navigate to HomePage
// //       Future.delayed(const Duration(seconds: 1), () {
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (context) => const HomePage()),
// //         );
// //       });
// //     } on FirebaseFunctionsException catch (e) {
// //       print("❌ Cloud Function Error: ${e.code} - ${e.message}");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Error: ${e.message}")),
// //       );
// //     } on FirebaseAuthException catch (e) {
// //       print("❌ Auth Error: ${e.code} - ${e.message}");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Auth Error: ${e.message}")),
// //       );
// //     } catch (e) {
// //       print("❌ Unknown Error: $e");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Something went wrong. Please try again.")),
// //       );
// //     }
// //   }
// // }


// Future<void> signup() async {
//   if (_formKey.currentState!.validate()) {
//     await _authService.signupUser(
//       email: emailcontroller.text,
//       password: pwdcontroller.text,
//       name: namecontroller.text,
//       city: citycontroller.text,
//       context: context,
//     );

//     // Navigate after signup + login
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const HomePage()),
//     );
//   }
// }






   

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "User Registration",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         // backgroundColor: Colors.pink,
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Builder(
//         builder: (context) {
//           // Get screen width and height
//           double screenWidth = MediaQuery.of(context).size.width;
//           double screenHeight = MediaQuery.of(context).size.height;

//           return Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.only(
//                     left: screenWidth * 0.07,
//                     right: screenWidth * 0.07,
//                     top: screenHeight * 0.02,
//                     bottom: screenHeight * 0.2),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Stack(
//                           children: [
//                             // _image != null
//                             //     ? CircleAvatar(
//                             //         radius: 64,
//                             //         backgroundImage: MemoryImage(_image!),
//                             //         backgroundColor: Colors.blue,
//                             //       )
//                             //     : const CircleAvatar(
//                             //         radius: 64,
//                             //         backgroundImage: AssetImage(
//                             //             'assets/images/default_profile.png'),
//                             //         //backgroundImage: NetworkImage(
//                             //         //  'https://i.stack.imgur.com/l60Hf.png'),
//                             //         backgroundColor: Colors.blue,
//                             //         //child: Icon(Icons.person, size: 64),
//                             //       ),
//                             // Positioned(
//                             //   bottom: -10,
//                             //   left: 80,
//                             //   child: IconButton(
//                             //     onPressed: selectImage,
//                             //     icon: const Icon(Icons.add_a_photo),
//                             //   ),
//                             // )
//                           ],
//                         ),
//                         SizedBox(height: screenHeight * 0.07),
//                         CustomTextFormField(
//                           controller: namecontroller,
//                           hintText: 'Enter your Name',
//                           labelText: 'Name',
//                           validator: ValidateMethods()
//                               .validateName, // Required validator
//                           isPassword: false,
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         CustomTextFormField(
//                           controller: emailcontroller,
//                           hintText: 'Enter your Email',
//                           labelText: 'Email',
//                           validator: ValidateMethods()
//                               .validateEmail, // Required validator
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         CustomTextFormField(
//                           controller: pwdcontroller,
//                           hintText: 'Enter your password',
//                           labelText: 'Password',
//                           validator: ValidateMethods()
//                               .validatePassword, // Required validator
//                           isPassword: true,
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         CustomTextFormField(
//                           controller: confirmpwdcontroller,
//                           hintText: 'Re-enter your password',
//                           labelText: 'Confirm Password',
//                           validator: (value) => ValidateMethods()
//                               .validateConfirmPassword(
//                                   value, pwdcontroller.text),
//                           isPassword: true,
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         CustomTextFormField(
//                           controller: citycontroller,
//                           hintText: 'Enter your city name',
//                           labelText: 'City',
//                           validator: ValidateMethods()
//                               .validateCityName, // Required validator
//                         ),
//                         SizedBox(height: screenHeight * 0.07),
//                         SizedBox(
//                           width: screenWidth * 0.8,
//                           height: screenHeight * 0.07,
//                           child: CustomMaterialButton(
//                               label: "Register",
//                               onPressed: () {
//                                 signup();
//                               }
//                               // onPressed: () {Navigator.pushReplacement(context,
//                               //     MaterialPageRoute(builder: (BuildContext context) => const HomePage()));},
//                               ),
//                         ),
//                         // SizedBox(height: screenHeight * 0.04),
//                         // Center(
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.center,
//                         //     crossAxisAlignment: CrossAxisAlignment.center,
//                         //     children: [
//                         //       Text("Already have an account?",
//                         //           style: TextStyle(
//                         //               fontSize: 25,
//                         //               fontWeight: FontWeight.w100,
//                         //               fontStyle: FontStyle.italic,
//                         //               color: Colors.blueGrey)),
//                         //       TextButton(
//                         //         onPressed: () {},
//                         //         child: Text("Login",
//                         //             style: TextStyle(
//                         //               color:
//                         //                   const Color.fromARGB(255, 2, 6, 247),
//                         //               fontSize: 20,
//                         //               fontStyle: FontStyle.italic,
//                         //               fontWeight: FontWeight.bold,
//                         //             )),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // )
//                       ]),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
