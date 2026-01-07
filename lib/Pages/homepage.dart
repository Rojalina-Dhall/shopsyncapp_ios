import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsync_app/services/user_service.dart';
import 'package:shopsync_app/widgets/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'all';

  final LinearGradient _chipGradient = const LinearGradient(
  colors: [
    Color(0xFF6A5AE0),
    Color(0xFF8E7BFF),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);


  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
     
        color: Colors.grey.shade50,// ✅ Material ancestor for chips and other Material widgets
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar replacement
            

            const SizedBox(height: 8),

            // Category Chips
            SizedBox(
              height: 56,
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: userStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.deepPurple));
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(child: Text("User data not found"));
                  }

                  final userData = snapshot.data!.data()!;
                  final categoryUsage =
                      Map<String, int>.from(userData['categoryUsage'] ?? {});

                  final sortedCategoryIds = categoryUsage.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value));

                  final categoryIds = ['all', ...sortedCategoryIds.map((e) => e.key)];

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: categoryIds.map((categoryId) {
                      final isAll = categoryId == 'all';

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(isAll ? 'All' : categoryId),
                          selected: selectedCategory == categoryId,
                          selectedColor: Colors.deepPurple.shade400,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: selectedCategory == categoryId
                                ? Colors.white
                                // : Colors.deepPurple.shade700,
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: StadiumBorder(
                            side: BorderSide(color: Colors.deepPurple.shade400, width: 2),
                          ),
                          onSelected: (_) async {
                            setState(() => selectedCategory = categoryId);

                            if (!isAll) {
                              final uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              await UserService().incrementCategoryUsage(
                                uid: uid,
                                categoryId: categoryId,
                              );
                            }
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Stores Section
            Expanded(
              child: CategorySection(categoryId: selectedCategory),
            ),
          ],
        ),
      );
    
  }
}
