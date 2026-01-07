import 'package:flutter/material.dart';
import 'package:shopsync_app/Pages/HomePage.dart';
import 'package:shopsync_app/Pages/fetchusername.dart';
import 'package:shopsync_app/Pages/rewardspage.dart';
import 'package:shopsync_app/Pages/purchasespage.dart';
import 'package:shopsync_app/Pages/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




class HomeNavigationScreen extends StatefulWidget {
  const HomeNavigationScreen({super.key});

  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  int _currentIndex = 0;
  String? _userName;
bool _loadingUser = true;


  final List<Widget> _pages = const [
    HomePage(),
    RewardsPage(),
    PurchasesPage(),
    ProfilePage(),
  ];

final List<String> _titles = [
  'Welcome back',
  'My Rewards',
  'My Purchases',
  'Profile',
];


Future<void> _loadUserName() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return;

  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();

  if (doc.exists) {
    setState(() {
      _userName = doc['name'];
      _loadingUser = false;
    });
  }
}

@override
void initState() {
  super.initState();
  _loadUserName();
}

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
  elevation: 0,
  centerTitle: true,
  backgroundColor: Colors.transparent, // IMPORTANT
  flexibleSpace: Container(
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
  ),
  title: Text(
    _currentIndex == 0
        ? (_loadingUser
            ? 'Welcome back'
            : 'Welcome back, $_userName 👋')
        : _titles[_currentIndex],
    style: const TextStyle(color: Colors.black),
  ),
  
),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
//       

bottomNavigationBar: Container(
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [
        Color(0xFF6A5AE0),
        Color(0xFF8E7BFF),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.12),
        blurRadius: 16,
        offset: const Offset(0, -6),
      ),
    ],
  ),
  child: SafeArea(
    top: false, // 👈 IMPORTANT: only respect bottom safe area
    // child: Padding(
    //   // 👇 This visually centers icons + labels
    //   padding: const EdgeInsets.symmetric(vertical: 6),
    child: SizedBox(
      height: 70, // ✅ controls vertical centering
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        // unselectedItemColor: Colors.white70,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,

        // Slim & balanced
        iconSize: 24,
        selectedFontSize: 13,
        unselectedFontSize: 12,

        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            activeIcon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Purchases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    ),
  ),
)
    );
  }
}
