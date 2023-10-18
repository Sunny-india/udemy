import 'package:flutter/material.dart';
import 'package:udemycopy/my_widgets/appbar_title.dart';

import '../my_widgets/my_back_button.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const MyBackButton(),
        title: const AppBarTitle(
          title: 'Manage Products',
        ),
      ),
    );
  }
}
