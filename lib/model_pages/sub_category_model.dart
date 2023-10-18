import 'package:flutter/material.dart';

import '../sub_category_pages/sub_cat_kirana.dart';

class SubCategoryModel extends StatelessWidget {
  String mainCategName;
  String subCategName;
  String assetName;
  String subCategLabel;
  SubCategoryModel(
      {Key? key,
      required this.mainCategName,
      required this.subCategName,
      required this.assetName,
      required this.subCategLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (
                context,
              ) =>
                  SubKirana(
                      subCatName: subCategName, mainCatName: mainCategName),
            ));
        //Navigator.pushNamed(context, 'subKirana');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            width: 80,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(assetName),
            ),
          ),
          Center(
            child: Text(
              subCategLabel,
              //style: TextStyle(fontSize: 12.3),
            ),
          ),
          // Text(allList.kirana[index]),
        ],
      ),
    );
  }
}
