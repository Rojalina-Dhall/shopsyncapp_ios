import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


//for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

//for displaying snackbars
// void showSnackBar(BuildContext context, String text) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//       duration: Duration(
//           seconds: 5), // Optional: You can specify how long the Snackbar shows
//     ),
//   );
// }

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 18), // Adjust the font size for larger text
      ),
      duration: Duration(seconds: 1), // Snackbar duration
      backgroundColor: Colors.black38, // Optional: Customize background color
      padding: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 12.0), // Adjust padding for more space
      behavior: SnackBarBehavior
          .floating, // Optional: Makes the Snackbar float above the content
      shape: RoundedRectangleBorder(
        // Optional: You can make the corners rounded
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   // Fetch the list of restaurants with pagination
//   Future<Map<String, dynamic>> fetchRestaurants_old(
//       {DocumentSnapshot? lastDocument}) async {
//     Query query =
//         _firestore.collection('restaurants').orderBy('name').limit(10);
//     if (lastDocument != null) {
//       query = query.startAfterDocument(lastDocument);
//     }

//     QuerySnapshot snapshot = await query.get();

//     print(snapshot.size);
//     print("-----------------");
//     // Log the data of each document
//     snapshot.docs.forEach((doc) {
//       print(doc.data()); // This will log the data of each document
//     });

//     List<Owner> restaurants = snapshot.docs
//         .where((doc) => doc.data() != null) // Filter out docs with null data
//         .map((doc) => Owner.fromSnap(doc.data() as Map<String, dynamic>))
//         .toList();

//     print(restaurants.length);
//     print(restaurants);
//     print("One-----------------");
//     // Return both the list of restaurants and the last document snapshot
//     return {
//       'restaurants': restaurants,
//       'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
//     };
//   }
// }

// class FirestoreService_new {
//   final FirebaseFirestore _firestorenew = FirebaseFirestore.instance;
// // Fetch the list of restaurants with pagination
//   Future<Map<String, dynamic>> fetchRestaurants_new(
//       {DocumentSnapshot? lastDocument}) async {
//     Query query =
//         _firestorenew.collection('restaurants_new').orderBy('name').limit(10);
//     if (lastDocument != null) {
//       query = query.startAfterDocument(lastDocument);
//     }

//     QuerySnapshot snapshot = await query.get();

//     print(snapshot.size);
//     print("-----------------");
//     // Log the data of each document
//     snapshot.docs.forEach((doc) {
//       print(doc.data()); // This will log the data of each document
//     });

//     List<RestaurantclassNew> restaurants = snapshot.docs
//         .where((doc) => doc.data() != null) // Filter out docs with null data
//         .map((doc) =>
//             RestaurantclassNew.fromSnap(doc.data() as Map<String, dynamic>))
//         .toList();

//     print(restaurants.length);
//     print(restaurants);
//     print("One-----------------");
//     // Return both the list of restaurants and the last document snapshot
//     return {
//       'restaurants_new': restaurants,
//       'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
//     };
//   }
// }
