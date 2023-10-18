import 'package:flutter/material.dart';
import 'package:udemycopy/my_widgets/appbar_title.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Stores',
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
