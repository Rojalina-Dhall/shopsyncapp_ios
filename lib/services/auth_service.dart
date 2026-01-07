// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // class AuthService {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _db = FirebaseFirestore.instance;

// //   /// Sign up user and create Firestore document with default categories
// //   Future<void> signupUser({
// //     required String email,
// //     required String password,
// //     required String name,
// //     required String city,
// //     required BuildContext context,
// //   }) async {
// //     try {
// //       // 1️⃣ Create user in Firebase Auth
// //       UserCredential cred = await _auth.createUserWithEmailAndPassword(
// //         email: email.trim(),
// //         password: password.trim(),
// //       );
// //       final uid = cred.user!.uid;

// //       // 2️⃣ Create Firestore document with default categories
// //       final defaultCategories = {
// //         "electronics": ["99887", "99891"],
// //         "groceries": ["99888", "99889"],
// //         "pharmacy": ["99890"],
// //       };

// //       await _db.collection('users').doc(uid).set({
// //         "id": uid,
// //         "name": name.trim(),
// //         "email": email.trim(),
// //         "city": city.trim(),
// //         "categories": defaultCategories,
// //         "createdAt": FieldValue.serverTimestamp(),
// //       });

// //       // 3️⃣ Optional: print for debug
// //       print("🔥 User created with UID: $uid and default categories.");

// //     } on FirebaseAuthException catch (e) {
// //       print("❌ Auth Error: ${e.code} - ${e.message}");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Auth Error: ${e.message}")),
// //       );
// //       rethrow;
// //     } catch (e) {
// //       print("❌ Unknown Error: $e");
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Something went wrong. Please try again.")),
// //       );
// //       rethrow;
// //     }
// //   }
// // }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   /// Sign up user and create Firestore documents with default categories and stores
//   Future<void> signupUser({
//     required String email,
//     required String password,
//     required String name,
//     required String city,
//     required BuildContext context,
//   }) async {
//     try {
//       // 1️⃣ Create user in Firebase Auth
//       UserCredential cred = await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//       final uid = cred.user!.uid;

//       print("🔥 User created in Auth with UID: $uid");

//       // 2️⃣ Create Firestore user document with default categories
//       final defaultCategories = {
//         "electronics": ["99887", "99891"],
//         "groceries": ["99888", "99889"],
//         "pharmacy": ["99890"],
//       };

//       await _db.collection('users').doc(uid).set({
//         "id": uid,
//         "name": name.trim(),
//         "email": email.trim(),
//         "city": city.trim(),
//         "categories": defaultCategories,
//         "createdAt": FieldValue.serverTimestamp(),
//       });

//       print("✅ User document created in Firestore");

//       // 3️⃣ Seed hardcoded stores
//       final defaultStores = {
//   "99887": {"categoryId": "electronics", "name": "Best Buy", "address": "123 Cupertino St"},
//   "99891": {"categoryId": "electronics", "name": "Apple Store", "address": "1 Infinite Loop"},
//   "99888": {"categoryId": "groceries", "name": "Whole Foods", "address": "456 Market St"},
//   "99889": {"categoryId": "groceries", "name": "Trader Joe's", "address": "789 Main St"},
//   "99890": {"categoryId": "pharmacy", "name": "CVS Pharmacy", "address": "101 Elm St"},
// };


//       for (final entry in defaultStores.entries) {
//         final storeId = entry.key;
//         final storeData = entry.value;

//         print("➡ Writing store $storeId: ${storeData['name']}");
//         await _db.collection('stores').doc(storeId).set({
//           ...storeData,
//           "createdAt": FieldValue.serverTimestamp(),
//         });
//         print("✅ Store $storeId written");
//       }

//       print("🔥 User and stores created successfully!");

//     } on FirebaseAuthException catch (e) {
//       print("❌ Auth Error: ${e.code} - ${e.message}");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Auth Error: ${e.message}")),
//       );
//       rethrow;
//     } catch (e) {
//       print("❌ Unknown Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Something went wrong. Please try again.")),
//       );
//       rethrow;
//     }
//   }
// }



import 'package:firebase_auth/firebase_auth.dart';

import 'package:shopsync_app/services/user_service.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  Future<void> signupUser({
    required String email,
    required String password,
    required String name,
    required String city,
  }) async {
    final trimmedEmail = email.trim();

    // 1️⃣ Create user in Firebase Auth
    final cred = await _auth.createUserWithEmailAndPassword(
      email: trimmedEmail,
      password: password.trim(),
    );

    final uid = cred.user!.uid;

    // 2️⃣ Create Firestore profile + seed data
    await _userService.createUserProfile(
      uid: uid,
      name: name.trim(),
      email: trimmedEmail,
      city: city.trim(),
    );
  }

  

  Future<void> logout() async {
    await _auth.signOut();
  }
}


