import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopsync_app/Models/user.dart';


class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserWithDefaults({
    required String uid,
    required String name,
    required String email,
    required String city,
  }) async {
    final userRef = _db.collection('users').doc(uid);

    final defaultCategories = {
      "electronics": ["99887", "99891"],
      "groceries": ["99888", "99889"],
      "pharmacy": ["99890"],
    };

    await userRef.set(User(
      id: uid,
      name: name,
      email: email,
      city: city,
      categories: defaultCategories,
    ).toJson());
  }
}
