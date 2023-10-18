import 'package:flutter/material.dart';
import 'package:udemycopy/my_widgets/fake_search_bar.dart';

import '../all_cat_pages/dairy.dart';
import '../all_cat_pages/hardware.dart';
import '../all_cat_pages/kirana.dart';
import '../all_cat_pages/medical.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<Category> {
  PageController myPage = PageController();
  List<ItemData> items = [
    ItemData(label: 'Kirana Store'),
    ItemData(label: 'Dairy Shop'),
    ItemData(label: 'Medical Store'),
    ItemData(label: 'Hardware House'),
    ItemData(label: 'Restaurant'),
    ItemData(label: 'Hotel'),
    ItemData(label: 'Hospital'),
  ];
  @override
  void initState() {
//jb jb user page change krke, vapis isi page pe aaye, jaye, usko by default kaun
    // sa page dikhe, iske liye ye ititState() use kiya, wo bhi poora page build krne ke baad
    for (var myItem in items) {
      myItem.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: FakeSearchBar(),
      ),
      body: Stack(
        children: [
          Positioned(
            child: sideContainer(size),
            bottom: 0,
            left: 0,
          ),
          Positioned(
            child: categoryView(size),
            bottom: 0,
            right: 0,
          ),
        ],
      ),
    );
  }

  Widget sideContainer(Size size) {
    return SizedBox(
      width: size.width * .23,
      height: size.height * .83,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // below oneLiner Code PageController ka function hai;
                // isse us PageController ki functionality yahan connect ho gayi hai

                myPage.jumpToPage(index);
                // Below commented code ListView.builder se belong krta hai
                // lekin isko PageConroller mein likha; functinality connect krne ke liye
                // for (var myItem in items) {
                //   myItem.isSelected = false;
                // }
                // setState(() {
                //   items[index].isSelected = true;
                // });
              },
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                height: 100,
                color: items[index].isSelected == true
                    ? Colors.white
                    : Colors.grey.shade300,
                child: Center(child: Text(items[index].label)),
              ),
            );
          }),
    );
  }

  Widget categoryView(Size size) {
    return Container(
      color: Colors.white,
      width: size.width * .77,
      height: size.height * .83,
      child: PageView(
        controller: myPage,
        // yahan se--------
        // ye poora code sideContainer ke ListView.builder function ka hai;
        // is page ko wahan se connect krne ke liye aise kiya;
        // aur yahan ka connection wahan banane ke liye; wahan pe pageController ki functionlity de di.
        onPageChanged: (value) {
          for (var myItem in items) {
            myItem.isSelected = false;
          }
          setState(() {
            items[value].isSelected = true;
          });
          // ------yahan tk;
        },
        scrollDirection: Axis.vertical,
        children: [
          Kirana(),
          Dairy(),
          Medical(),
          Hardware(),
          const Center(
            child: Text("Restaurant"),
          ),
          const Center(
            child: Text("Hotels"),
          ),
          const Center(
            child: Text("Hospital"),
          ),
        ],
      ),
    );
  }
}

class ItemData {
  String label;
  bool isSelected;
  ItemData({required this.label, this.isSelected = false});
}
