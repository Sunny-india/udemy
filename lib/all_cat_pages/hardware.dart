import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:udemycopy/utilities/categ_list.dart';
import '../model_pages/sub_category_model.dart';
import '../my_widgets/category_header.dart';
import '../my_widgets/slider_bar.dart';

class Hardware extends StatelessWidget {
  Hardware({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategoryHeader(header: "Hardware Packing-Items"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .68,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 60,
                      crossAxisCount: 3,
                      // jb children mein List.generate dete hain, to [] brackets nahi lagate.;;
                      children:
                          List.generate(MyList.hardware.length - 1, (index) {
                        return SubCategoryModel(
                          mainCategName: 'Hardware',
                          subCategName: MyList.hardware[index + 1],
                          assetName: 'images/hardware/hard$index.JPG',
                          subCategLabel: MyList.hardware[index + 1],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            // The sliderBar
            bottom: 0,
            right: 0,
            child: SliderBar(
              mainCategName: 'Hardware',
            ),
          ),
        ],
      ),
    );
  }
}
