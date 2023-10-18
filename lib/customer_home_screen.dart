import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemycopy/pages/category.dart';
import 'package:udemycopy/pages/home_screen.dart';
import 'package:udemycopy/stores_screen.dart';

import 'cart_screen.dart';
import 'customer_profile_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomerHomeScreenState();
  }
}

class CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int current = 0;

  //--List directly responsive to the bottomNavigationBar items---//
  List<Widget> pages = [
    HomeScreen(),
    const Category(),
    const StoresScreen(),
    const CartScreen(),
    CustomerProfileScreen(
      documentId: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: pages[current],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: current,
        selectedItemColor: Colors.green.shade400,
        unselectedItemColor: Colors.red.shade400,
        onTap: (index) {
          setState(() {
            current = index;
          });
        },
        items: const [
          //-----1st item----//
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),

          //-----2nd item----//
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chevron_left_slash_chevron_right),
            label: "Categories",
          ),

          //----3rd item----//
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Store",
          ),

          //----4th item----//
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),

          //----5th item----//
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
