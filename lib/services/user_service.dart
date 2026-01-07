
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 1️⃣ Default categories
  static const Map<String, Map<String, dynamic>> defaultCategories = {
    "electronics": {"name": "Electronics", "order": 1},
    "groceries": {"name": "Groceries", "order": 2},
    "pharmacy": {"name": "Pharmacy", "order": 3},
  };

  // 2️⃣ Default stores
  static const Map<String, Map<String, dynamic>> defaultStores = {
    "99887": {"name": "Best Buy", "categoryId": "electronics", "address": "123 Cupertino St","logoUrl":"https://firebasestorage.googleapis.com/v0/b/flutter-shopsync-app.firebasestorage.app/o/store_logologos%2Fbestbuy.png?alt=media&token=e9ea1780-8f1f-43c9-8a07-7f61ab939429"},
    "99891": {"name": "Apple Store", "categoryId": "electronics", "address": "1 Infinite Loop","logoUrl":"https://firebasestorage.googleapis.com/v0/b/flutter-shopsync-app.firebasestorage.app/o/store_logologos%2Fwholefoods.png?alt=media&token=2dc14915-efbd-42a6-94c6-9a9d0764b5a1"},
    "99888": {"name": "Whole Foods", "categoryId": "groceries", "address": "456 Market St","logoUrl":"https://firebasestorage.googleapis.com/v0/b/flutter-shopsync-app.firebasestorage.app/o/store_logologos%2Fwholefoods.png?alt=media&token=2dc14915-efbd-42a6-94c6-9a9d0764b5a1"},
    "99889": {"name": "Trader Joe's", "categoryId": "groceries", "address": "789 Main St","logoUrl":"https://firebasestorage.googleapis.com/v0/b/flutter-shopsync-app.firebasestorage.app/o/store_logologos%2Fwholefoods.png?alt=media&token=2dc14915-efbd-42a6-94c6-9a9d0764b5a1"},
    "99890": {"name": "CVS Pharmacy", "categoryId": "pharmacy", "address": "101 Elm St","logoUrl":"https://firebasestorage.googleapis.com/v0/b/flutter-shopsync-app.firebasestorage.app/o/store_logologos%2Fcvs.png?alt=media&token=5243bfd1-0b9b-43d9-934b-903e31908cec"},
  };

  /// Seed global categories collection
  Future<void> seedCategories() async {
    for (final entry in defaultCategories.entries) {
      final docRef = _db.collection('categories').doc(entry.key);
      final snapshot = await docRef.get();
      if (!snapshot.exists) {
        await docRef.set(entry.value);
        print("Category created: ${entry.value['name']}");
      }
    }
  }

  /// Seed global stores collection
  Future<void> seedStores() async {
    for (final entry in defaultStores.entries) {
      final docRef = _db.collection('stores').doc(entry.key);
      final snapshot = await docRef.get();
      if (!snapshot.exists) {
        await docRef.set({
          ...entry.value,
          "createdAt": FieldValue.serverTimestamp(),
        });
        print("Store created: ${entry.value['name']}");
      }
    }
  }

  /// Create user document with default category usage
  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
    required String city,
  }) async {
    if (uid.isEmpty) throw ArgumentError("UID cannot be empty");

    final userRef = _db.collection('users').doc(uid);

    // Initialize category usage with 0
    final defaultCategoryUsage = {for (var key in defaultCategories.keys) key: 0};
    final defaultCategoryId = defaultCategories.keys.first;

    await userRef.set({
      "id": uid,
      "name": name,
      "email": email,
      "city": city,
      "categoryUsage": defaultCategoryUsage,
      "defaultCategoryId": defaultCategoryId, // first category to show
      "createdAt": FieldValue.serverTimestamp(),
    });

    print("User created with UID: $uid");
  }

  Future<void> seedIfNeeded() async {
  final configRef = _db.collection('config').doc('app');
  final snapshot = await configRef.get();

  if (!snapshot.exists || snapshot.data()?['seeded'] != true) {
    await seedCategories();
    await seedStores();
    await configRef.set({'seeded': true});
    print("✅ Categories & stores seeded once");
  } else {
    print("ℹ️ Seeding already done");
  }
}


  /// High-level method: seed categories, stores, and create user
  Future<void> createUserProfile({
  required String uid,
  required String name,
  required String email,
  required String city,
}) async {
  print("🔥 Starting createUserWithDefaults for UID: $uid");
  await seedIfNeeded(); // Ensure categories and stores are seeded
  await createUser(uid: uid, name: name, email: email, city: city);
  print("✅ User created successfully!");
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
      final usage = Map<String, dynamic>.from(data['categoryUsage'] ?? {});
      usage[categoryId] = (usage[categoryId] ?? 0) + incrementBy;

      transaction.update(userRef, {
        'categoryUsage': usage,
        // Optionally update defaultCategoryId to most used category
        'defaultCategoryId': usage.entries
            .reduce((a, b) => a.value >= b.value ? a : b)
            .key,
      });
    });
  }

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
    final usage = Map<String, dynamic>.from(data['storeUsage'] ?? {});

    usage[storeId] = (usage[storeId] ?? 0) + incrementBy;

    transaction.update(userRef, {
      'storeUsage': usage,
    });
  });
}


  /// Get the most used category for a user
  Future<String?> getMostUsedCategory(String uid) async {
    final userRef = _db.collection('users').doc(uid);
    final snapshot = await userRef.get();
    if (!snapshot.exists) return null;

    final data = snapshot.data()!;
    final usage = Map<String, dynamic>.from(data['categoryUsage'] ?? {});
    if (usage.isEmpty) return null;

    // Return categoryId with highest count
    return usage.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }
}
