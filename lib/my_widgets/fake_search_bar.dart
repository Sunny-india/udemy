import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FakeSearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FakeSearchBarState();
  }
}

class FakeSearchBarState extends State<FakeSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(top: 10),
      height: 45,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(18)),
      child: rowInContainer(),
    );
  }

  Widget rowInContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Looking for Something??",
          style: TextStyle(color: Colors.black12),
          // TextStyle(fontSize: 35),
        ),
        InkWell(
            child: const Icon(
              CupertinoIcons.search,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.pushNamed(context, "searchScreen");
            }),
      ],
    );
  }
}
