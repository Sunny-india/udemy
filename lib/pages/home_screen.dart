import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:udemycopy/pages/search_screen.dart';

import '../my_widgets/fake_search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0,
          title: FakeSearchBar(),
          bottom: TabBar(
            indicatorColor: Colors.teal,
            indicatorWeight: 3.3,
            isScrollable: true,
            tabs: [
              RepeatedTab(label: "Men"),
              RepeatedTab(label: "Women"),
              RepeatedTab(label: "Shoes"),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              Text("Men's Screen"),
              Text("Women's Screen"),
              Text("Shoes Screen"),
            ],
          ),
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  RepeatedTab({required this.label});
  String? label;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label!,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
      ),
    );
  }
}
