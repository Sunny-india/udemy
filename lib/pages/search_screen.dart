import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Icon(
          CupertinoIcons.back,
          color: Colors.black,
        ),
        title: myTitleContainer(),
      ),
    );
  }

  Widget myTitleContainer() {
    return const CupertinoSearchTextField();
  }
}
