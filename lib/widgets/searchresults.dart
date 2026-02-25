import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopsync_app/Models/store.dart';

class SearchResults extends StatelessWidget {
  final String query;

  const SearchResults({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('stores').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final stores = snapshot.data!.docs
            .map((doc) =>
                StoreModel.fromJson(doc.data() as Map<String, dynamic>))
            .where((store) =>
                store.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (stores.isEmpty) {
          return const Center(child: Text("No results found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: stores.length,
          itemBuilder: (context, index) {
            final store = stores[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(store.logoUrl),
              ),
              title: Text(store.name),
              onTap: () {
                // Navigate to store page later
              },
            );
          },
        );
      },
    );
  }
}
