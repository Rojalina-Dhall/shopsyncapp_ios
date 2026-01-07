import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopsync_app/Models/store.dart';

class CategorySection extends StatelessWidget {
  final String categoryId;

  const CategorySection({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    if (categoryId == 'all') {
      return _buildAllStoresSection();
    }

    return _buildCategoryStoresSection();
  }

  /// 🔹 ALL STORES (grocery-first)
  Widget _buildAllStoresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            "ALL STORES",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 80, // small height for logos
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('stores').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.docs;

              if (docs.isEmpty) {
                return const Center(child: Text("No stores found"));
              }

              // Grocery-first sorting
              docs.sort((a, b) {
                if (a['categoryId'] == 'groceries' &&
                    b['categoryId'] != 'groceries') return -1;
                if (a['categoryId'] != 'groceries' &&
                    b['categoryId'] == 'groceries') return 1;
                return 0;
              });

              final stores = docs
                  .map((doc) =>
                      StoreModel.fromJson(doc.data() as Map<String, dynamic>))
                  .toList();

              return _buildStoreList(stores);
            },
          ),
        ),
      ],
    );
  }

  /// 🔹 SINGLE CATEGORY STORES
  Widget _buildCategoryStoresSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('stores')
          .where('categoryId', isEqualTo: categoryId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(child: Text("No stores found"));
        }

        final stores = docs
            .map((doc) => StoreModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                categoryId.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 80, child: _buildStoreList(stores)),
          ],
        );
      },
    );
  }
Widget _buildStoreList(List<StoreModel> stores) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: stores.length,
    itemBuilder: (context, index) {
      final store = stores[index];

      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: CircleAvatar(
          radius: 33,
          backgroundImage: NetworkImage(store.logoUrl),
          backgroundColor: Colors.transparent,
        ),
      );
    },
  );
}
}