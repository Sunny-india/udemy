import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemycopy/pages/category.dart';
import 'package:udemycopy/pages/home_screen.dart';
import 'package:udemycopy/stores_screen.dart';
import 'package:udemycopy/upload_product.dart';

import 'dashboard.dart';

class SupplierScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SupplierScreenState();
  }
}

class SupplierScreenState extends State<SupplierScreen> {
  int current = 0;
  List<Widget> pages = [
    HomeScreen(),
    const Category(),
    const StoresScreen(),
    const DashboardScreen(),
    const UploadProductScreen(),
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
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chevron_left_slash_chevron_right),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Store",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "DashBoard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: "Upload",
          ),
        ],
      ),
    );
  }
}
