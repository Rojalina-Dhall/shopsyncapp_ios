import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String city;
  final Map<String, List<String>> categories; // category name → list of store_ids

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    this.categories = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'city': city,
      'categories': categories,
    };
  }

  static User fromSnap(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    Map<String, List<String>> categoriesMap = {};
    if (data['categories'] != null) {
      data['categories'].forEach((key, value) {
        categoriesMap[key] = List<String>.from(value);
      });
    }
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      city: data['city'],
      categories: categoriesMap,
    );
  }
}
