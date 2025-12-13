import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Sign up user and create Firestore document with default categories
  Future<void> signupUser({
    required String email,
    required String password,
    required String name,
    required String city,
    required BuildContext context,
  }) async {
    try {
      // 1️⃣ Create user in Firebase Auth
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final uid = cred.user!.uid;

      // 2️⃣ Create Firestore document with default categories
      final defaultCategories = {
        "electronics": ["99887", "99891"],
        "groceries": ["99888", "99889"],
        "pharmacy": ["99890"],
      };

      await _db.collection('users').doc(uid).set({
        "id": uid,
        "name": name.trim(),
        "email": email.trim(),
        "city": city.trim(),
        "categories": defaultCategories,
        "createdAt": FieldValue.serverTimestamp(),
      });

      // 3️⃣ Optional: print for debug
      print("🔥 User created with UID: $uid and default categories.");

    } on FirebaseAuthException catch (e) {
      print("❌ Auth Error: ${e.code} - ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Auth Error: ${e.message}")),
      );
      rethrow;
    } catch (e) {
      print("❌ Unknown Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong. Please try again.")),
      );
      rethrow;
    }
  }
}
