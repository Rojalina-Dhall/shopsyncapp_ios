import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopsync_app/services/seed_service.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final SeedService _seedService = SeedService();

  /// Create user document with default category usage
  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
    required String city,
  }) async {
    if (uid.isEmpty) {
      throw ArgumentError("UID cannot be empty");
    }

    final userRef = _db.collection('users').doc(uid);

    // Initialize category usage with 0
    final defaultCategoryUsage = {
      for (final key in SeedService.defaultCategories.keys) key: 0,
    };

    final defaultCategoryId =
        SeedService.defaultCategories.keys.first;

    await userRef.set({
      "id": uid,
      "name": name,
      "email": email,
      "city": city,
      "categoryUsage": defaultCategoryUsage,
      "defaultCategoryId": defaultCategoryId,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  /// High-level method: seed categories & stores, then create user
  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
    required String city,
  }) async {
    await _seedService.seedIfNeeded();
    await createUser(
      uid: uid,
      name: name,
      email: email,
      city: city,
    );
  }

  /// Increment category usage for a user
  Future<void> incrementCategoryUsage({
    required String uid,
    required String categoryId,
    int incrementBy = 1,
  }) async {
    final userRef = _db.collection('users').doc(uid);

    await _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      if (!snapshot.exists) return;

      final data = snapshot.data()!;
      final Map<String, int> usage =
          Map<String, int>.from(data['categoryUsage'] ?? {});

      usage[categoryId] = (usage[categoryId] ?? 0) + incrementBy;

      transaction.update(userRef, {
        'categoryUsage': usage,
        'defaultCategoryId': usage.entries
            .reduce((a, b) => a.value >= b.value ? a : b)
            .key,
      });
    });
  }

  /// Increment store usage for a user
  Future<void> incrementStoreUsage({
    required String uid,
    required String storeId,
    int incrementBy = 1,
  }) async {
    final userRef = _db.collection('users').doc(uid);

    await _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      if (!snapshot.exists) return;

      final data = snapshot.data()!;
      final Map<String, int> usage =
          Map<String, int>.from(data['storeUsage'] ?? {});

      usage[storeId] = (usage[storeId] ?? 0) + incrementBy;

      transaction.update(userRef, {
        'storeUsage': usage,
      });
    });
  }

  /// Get the most used category for a user
  Future<String?> getMostUsedCategory(String uid) async {
    final snapshot = await _db.collection('users').doc(uid).get();
    if (!snapshot.exists) return null;

    final Map<String, int> usage =
        Map<String, int>.from(snapshot.data()?['categoryUsage'] ?? {});

    if (usage.isEmpty) return null;

    return usage.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }

  Stream<Map<String, dynamic>> userStream() {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((doc) => doc.data()!);
}
List<String> getSortedCategoryIds(Map<String, dynamic> userData) {
final categoryUsage =
    Map<String, int>.from(userData['categoryUsage'] ?? {});

final sortedCategoryIds = categoryUsage.entries.toList()
  ..sort((a, b) => b.value.compareTo(a.value));
  return ['all', ...sortedCategoryIds.map((e) => e.key)];

}
}