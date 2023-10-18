import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  String name;
  Function() onPressed;
  double width;
  YellowButton({
    required this.name,
    required this.onPressed,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(22),
      color: Colors.yellow,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * width,
        onPressed: onPressed,
        child: Text(
          name,
          style: TextStyle(fontSize: 23),
        ),
      ),
    );
  }
}
