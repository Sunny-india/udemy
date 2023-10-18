import 'package:flutter/material.dart';

class SliderBar extends StatelessWidget {
  String mainCategName;
  SliderBar({required this.mainCategName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      width: MediaQuery.of(context).size.width * .03,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Container(
          //alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(.4),
            border: Border.all(),
            borderRadius: BorderRadius.circular(100),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                mainCategName == 'Hardware'
                    ? Text('')
                    : Text(
                        "<<",
                        style: myStyle(),
                      ),
                Text(
                  mainCategName.toUpperCase(),
                  style: myStyle(),
                ),
                mainCategName == 'kirana'
                    ? Text("")
                    : Text(
                        ">>",
                        style: myStyle(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle myStyle() {
    return const TextStyle(
        letterSpacing: 10,
        color: Colors.brown,
        fontSize: 16,
        fontWeight: FontWeight.w400);
  }
}
