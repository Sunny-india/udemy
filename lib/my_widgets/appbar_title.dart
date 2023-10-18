import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontFamily: 'Acme',
          color: Colors.black,
          fontSize: 26,
          letterSpacing: 1.5),
    );
  }
}
