import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String? header;
  const CategoryHeader({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Text(
        header!,
        style: const TextStyle(fontSize: 15, letterSpacing: 1.3),
      ),
    );
  }
}
