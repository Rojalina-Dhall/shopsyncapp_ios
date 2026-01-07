import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get user categories
  Future<Map<String, List<String>>> getUserCategories(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    final data = doc.data()!;

    return Map<String, List<String>>.from(
      (data['categories'] as Map).map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }

  /// Get stores by storeIds
  Future<List<QueryDocumentSnapshot>> getStoresByIds(
      List<String> storeIds) async {
    if (storeIds.isEmpty) return [];

    final snapshot = await _db
        .collection('stores')
        .where(FieldPath.documentId, whereIn: storeIds)
        .get();

    return snapshot.docs;
  }
}
