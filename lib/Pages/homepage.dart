import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsync_app/widgets/category.dart';
import 'package:shopsync_app/widgets/categorychips.dart';
import 'package:shopsync_app/pages/fetchusername.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'all';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          // 🔹 Gradient SliverAppBar
         SliverAppBar(
  pinned: true,
  expandedHeight: 180,
  backgroundColor: Colors.transparent,

  flexibleSpace: FlexibleSpaceBar(
    background: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A5AE0), Color(0xFF8E7BFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeUserText(),
              const SizedBox(height: 12),
              _buildSearchField(),
            ],
          ),
        ),
      ),
    ),
  ),

  // 👇 CATEGORY CHIPS NOW LIVE HERE
  bottom: PreferredSize(
  preferredSize: const Size.fromHeight(56),
  child: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF6A5AE0),
          Color(0xFF8E7BFF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: CategoryChips(
      selectedCategory: selectedCategory,
      onChanged: (cat) {
        setState(() => selectedCategory = cat);
      },
    ),
  ),
),

),


          // 🔹 Stores Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CategorySection(categoryId: selectedCategory),
            ),
          ),
        ],
      ),
    );
  }

  // Circular compact search field
  Widget _buildSearchField() {
  return Align(
    alignment: Alignment.center, // 👈 keeps it left-aligned
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.75, // 👈 smaller length
      height: 42, // 👈 slimmer height
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search stores...',
          hintStyle: const TextStyle(fontSize: 14,color: Colors.black87),
          prefixIcon: const Icon(Icons.search, size: 20),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // 👈 pill shape
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
  );
}
}

// SliverPersistentHeader delegate for sticky category chips
class _CategoryChipsDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _CategoryChipsDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: overlapsContent ? 2 : 0,
      child: Container(
        color: Colors.grey.shade50,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => 60;
  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
