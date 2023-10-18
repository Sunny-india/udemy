import 'package:flutter/material.dart';

import '../my_widgets/appbar_title.dart';
import '../my_widgets/my_back_button.dart';

class SubKirana extends StatelessWidget {
  final String subCatName;
  final String mainCatName;
  const SubKirana(
      {Key? key, required this.subCatName, required this.mainCatName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const MyBackButton(),
        centerTitle: true,
        title: AppBarTitle(title: subCatName),
      ),
      body: Center(
        child: Text(
          mainCatName,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
