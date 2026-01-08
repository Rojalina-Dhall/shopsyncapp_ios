import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/user.dart' as model;


class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getter to access _firestore
  FirebaseFirestore get firestore => _firestore;

  // get user details
  // Future<model.User> getUserDetails() async {
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot userSnapshot =
  //       await _firestore.collection('users').doc(currentUser.uid).get();

  //   return model.User.fromSnap(userSnapshot);
  // }

  // Future<String> userExists() async {
  //   User currentUser = _auth.currentUser!;

  //   print(currentUser.uid);

  //   DocumentSnapshot userSnapshot =
  //       await _firestore.collection('users').doc(currentUser.uid).get();

  //   if (userSnapshot.exists) {
  //     return "Success";
  //   } else {
  //     return "doc does not exist";
  //   }
  // }

  // Method to get current user UID
  String getCurrentUserUid() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    } else {
      throw Exception("No user is currently signed in.");
    }
  }

// Function to handle authentication state and navigation
  // Widget authWrapper(BuildContext context) {
  //   print("Auth wrapper called");
  //   return StreamBuilder<User?>(
  //     stream: _auth.authStateChanges(),
  //     builder: (context, snapshot) {
  //       // If the connection is still in progress (e.g., waiting state)
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(
  //             child: CircularProgressIndicator()); // Loading indicator
  //       }

  //       // If the user is logged in, navigate to the correct home page
  //       if (snapshot.hasData) {
  //         //User? user = snapshot.data;

  //         return FutureBuilder<String>(
  //           future: userExists(), // Call userExists to get the user role
  //           builder: (context, roleSnapshot) {
  //             // While the role is being fetched, show a loading indicator
  //             if (roleSnapshot.connectionState == ConnectionState.waiting) {
  //               return const Center(child: CircularProgressIndicator());
  //             }

  //             // Check the role once it's fetched
  //             if (roleSnapshot.hasData) {
  //               String role = roleSnapshot.data!;
  //               if (role == "Success") {
  //                 return const UserHome(); // Navigate to Hotel Owner Home Page
  //               } else {
  //                 // Navigate to Customer Home Page
  //                 // return const RestaurantHome();
  //                 return const CreateStripeAccPage();
  //               }
  //             } else {
  //               // If the role isn't found, return to Login page
  //               return const LoginPage();
  //             }
  //           },
  //         );
  //       } else {
  //         // If the user is not logged in, show the login page
  //         return const LoginPage();
  //       }
  //     },
  //   );
  // }

// Assume addCategoryIfNotExists is defined earlier in the code
  // Future<void> addCategoryIfNotExists(String id, String newCategory) async {
  //   try {
  //     DocumentReference docRef = _firestore.collection('menu').doc(id);
  //     DocumentSnapshot snapshot = await docRef.get();

  //     // Check if the document exists
  //     if (!snapshot.exists) {
  //       // If the document does not exist, create it with the initial category
  //       print(
  //           'Document does not exist, creating a new document with the category');

  //       // If the document doesn't exist, initialize the 'category' field with the new category
  //       await docRef.set({
  //         'category': [
  //           newCategory
  //         ], // Add the first category to the 'category' field
  //       });

  //       print('New document created and category added successfully');
  //       return; // Exit the function after creating the document
  //     }

  //     List<dynamic> categories = snapshot.get('category') ?? [];
  //     List<String> stringCategories = List<String>.from(categories);

  //     if (stringCategories.contains(newCategory)) {
  //       print('Category already exists');
  //       return;
  //     }

  //     stringCategories.add(newCategory);
  //     await docRef.update({'category': stringCategories});

  //     print('Category added successfully');
  //   } catch (e) {
  //     print('Error adding category: $e');
  //   }
  // }

  // Future<int> getCountWithoutHotelId(String userId, String hotelId) async {
  //   try {
  //     // Get the reference to the Firestore collection
  //     CollectionReference itemsCollection =
  //         _firestore.collection('users').doc(userId).collection("cart");

  //     // Query all documents in the collection
  //     final querySnapshot = await itemsCollection.get();

  //     // Filter out the documents where 'hotelId' is equal to the one you want to exclude
  //     final documents = querySnapshot.docs.where((doc) {
  //       return doc['hotelId'] != hotelId;
  //     }).toList();

  //     // Return the count of the remaining documents
  //     return documents.length;
  //   } catch (e) {
  //     print("Error fetching documents: $e");
  //     return -1; // Return 0 in case of an error
  //   }
  // }

  // Future<String> incrementPriceCount(String userId, String itemId,
  //     String selectedPriceType, int incrementCount) async {
  //   try {
  //     // Reference to the Firestore collection
  //     final cartRef = FirebaseFirestore.instance
  //         .collection('users') // Replace with your specific collection name
  //         .doc(userId) // Replace with the current user's document ID
  //         .collection(
  //             'cart'); // Assuming the cart items are in a subcollection named 'cart'

  //     // Query to find the document where itemId is 'abc' and selectedPriceType is 'def'
  //     final querySnapshot = await cartRef
  //         .where('itemId', isEqualTo: itemId)
  //         .where('selectedPriceType', isEqualTo: selectedPriceType)
  //         .limit(1) // Make sure you only get one document
  //         .get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       // Document found
  //       final docId = querySnapshot.docs[0].id; // Get the document ID
  //       final currentPriceCount =
  //           querySnapshot.docs[0]['priceCounts'] ?? 0; // Get current priceCount

  //       // Increment the priceCounts by the given increment count
  //       await cartRef.doc(docId).update({
  //         'priceCounts': currentPriceCount + incrementCount,
  //       });

  //       print("Price count incremented successfully.");
  //       return "success";
  //     } else {
  //       print("No matching document found.");
  //       return "failed";
  //     }
  //   } catch (e) {
  //     print("Error incrementing price count: $e");
  //     return "failed";
  //   }
  // }

// Standalone method to add CartItem to Firestore
  // Future<String> addItemToCart(
  //   String userId,
  //   String hotelId,
  //   String itemId,
  //   String selectedPriceType,
  //   int priceCounts,
  //   String instructionText,
  // ) async {
  //   try {
  //     int itemCountWithoutHotel = await getCountWithoutHotelId(userId, hotelId);
  //     if (itemCountWithoutHotel != 0) {
  //       return "Existing cart item doesn't match with given restaurant, Please clear the cart";
  //     }
  //     String ret = await incrementPriceCount(
  //         userId, itemId, selectedPriceType, priceCounts);
  //     if (ret == "success") {
  //       return "success";
  //     }
  //     // Reference to the 'cart' collection in Firestore with userId as the docId
  //     CollectionReference itemsCollection =
  //         _firestore.collection('users').doc(userId).collection("cart");
  //     DocumentReference cartDocRef =
  //         itemsCollection.doc(); // Generates a unique ID for the new item
  //     String uniqueSerialNum = cartDocRef.id; // The generated unique item ID
  //     CartItem cartItem = CartItem(
  //         selectedPriceType: selectedPriceType,
  //         priceCounts: priceCounts,
  //         instructionText: instructionText,
  //         userId: userId,
  //         itemId: itemId,
  //         hotelId: hotelId,
  //         cartSerialNum: uniqueSerialNum);
  //     // Directly set the CartItem data in the document
  //     await cartDocRef.set(cartItem.toMap());

  //     print('Item added to cart successfully');
  //     return "success";
  //   } catch (e) {
  //     print('Failed to add item to cart: $e');
  //     return "Failed to add item to cart, unknown reason";
  //   }
  // }
// Add item to the menu and validate the category

  // Future<void> addItemToMenu(String name, String category, String desc,
  //     Uint8List file, Map<String, dynamic> priceData) async {
  //   try {
  //     // Store the file in storage and get the URL
  //     String menuPicsURL =
  //         await StorageMethods().uploadImage2('menuPics', file, true);

  //     // Get the current user from Firebase Authentication
  //     User currentUser = _auth.currentUser!;

  //     // Get the restaurant document snapshot using the current user's UID
  //     // DocumentSnapshot ownerSnapshot =
  //     // await _firestore.collection('restaurants').doc(currentUser.uid).get();

  //     // First, validate and add the category if not exists
  //     // await addCategoryIfNotExists(currentUser.uid, item.category);

  //     // Reference to the menu document
  //     DocumentReference menuDocRef =
  //         _firestore.collection('menu').doc(currentUser.uid);

  //     // Reference to the "items" subcollection for that specific menu document
  //     CollectionReference itemsCollection = menuDocRef.collection('items');

  //     // Generate a unique itemId dynamically using Firestore's document() method
  //     DocumentReference newItemRef =
  //         itemsCollection.doc(); // Generates a unique ID for the new item
  //     String uniqueItemId = newItemRef.id; // The generated unique item ID

  //     // // Create a new MenuItem with the unique itemId
  //     MenuItem newItemWithId = MenuItem(
  //       itemId: uniqueItemId,
  //       price: priceData,
  //       name: name,
  //       desc: desc,
  //       photoUrl: menuPicsURL,
  //       category: category,
  //       hotelId: currentUser.uid,
  //     );

  //     await addCategoryIfNotExists(currentUser.uid, newItemWithId.category);

  //     // Add the new item to the subcollection
  //     await newItemRef.set(newItemWithId.toMap());

  //     print('Item added successfully with itemId: $uniqueItemId');
  //   } catch (e) {
  //     print('Error adding item: $e');
  //   }
  // }

// sign up new user
  // Future<String> signUpUser({
  //   required String email,
  //   required String password,
  //   required String name,
  //   // required Uint8List file,
  //   required String city,
  // }) async {
  //   UserCredential cred = await _auth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );

  //   // String photoUrl =
  //   //     await StorageMethods().uploadImage2('profilePics', file, false);

  //   model.User user1 = model.User(
  //     name: name,
  //     id: cred.user!.uid,
  //     // photoUrl: photoUrl,
  //     email: email,
  //     city: city,
  //   );

  //   Map<String, dynamic> userJson = user1.toJson();

  //   //  adding user in our database
  //   await _firestore.collection("users").doc(cred.user!.uid).set(userJson);

  //   return "Success";
  // }

  //  logging in user
//   Future<String> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return "Success";
//   }
// }


}
