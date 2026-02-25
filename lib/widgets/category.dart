import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopsync_app/Models/store.dart';

class CategorySection extends StatelessWidget {
  final String categoryId;

  const CategorySection({
    super.key,
    required this.categoryId,
  });

  String _formatCategory(String value) {
  return value
      .replaceAll('_', ' ')
      .split(' ')
      .map((word) =>
          word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : '')
      .join(' ');
}


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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Text(
            "All Stores",
            style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      color: Color(0xFF1F1F1F),
    ),
          )
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
                    b['categoryId'] != 'groceries') {
                  return -1;
                }
                if (a['categoryId'] != 'groceries' &&
                    b['categoryId'] == 'groceries') {
                  return 1;
                }
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Text(
  _formatCategory(categoryId),
  style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade800,
  ),
),
            ),
            SizedBox(height: 60, child: _buildStoreList(stores)),
          ],
        );
      },
    );
  }
Widget _buildStoreList(List<StoreModel> stores) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    itemCount: stores.length,
    itemBuilder: (context, index) {
      final store = stores[index];

      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(store.logoUrl),
          backgroundColor: Colors.transparent,
        ),
      );
    },
  );
}
}