import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemycopy/my_widgets/snackbar.dart';
import 'package:udemycopy/utilities/categ_list.dart';
import 'package:uuid/uuid.dart';

// List<String> categ = ['select category', 'men', 'women', 'kids'];
//
// List<String> categMen = ['sub category', 'shirt', 'jacket', 'T-shirt'];
//
// List<String> categWomen = ['sub category', 'w shirt', 'w jacket', 'w T-shirt'];
//
// List<String> categKids = ['sub category', 'k shirt', 'k jacket', 'k T-shirt'];

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UploadProductScreenState();
  }
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;

  late double quantity;

  late String proName;

  late String proDes;

  String mainCategValue = 'select category';

  String subCategValue = 'sub category';

  final ImagePicker _pickMe = ImagePicker();

  List<XFile>? imagesFileList = [];

  List<String> imagesUrlList = [];

  List<String> alteredList = [];

  late String proId;

  void pickProducts() async {
    try {
      final imagesPicked = await _pickMe.pickMultiImage(
          imageQuality: 95, maxHeight: 300, maxWidth: 300);
      setState(() {
        imagesFileList = imagesPicked!;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void selectYourCategory(String value) {
    if (value == 'select category') {
      alteredList = [];
    } else if (value == 'kirana') {
      alteredList = MyList.kirana;
    } else if (value == 'dairy') {
      alteredList = MyList.dairy;
    } else if (value == 'hardware') {
      alteredList = MyList.hardware;
    } else if (value == 'medical') {
      alteredList = MyList.medical;
    }
  }

  Future<void> uploadImages() async {
    if (mainCategValue != 'select category' &&
        subCategValue != 'sub category') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imagesFileList!.isNotEmpty) {
          try {
            for (var image in imagesFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');

              await ref.putFile(File(image.path)).whenComplete(() async {
                ref.getDownloadURL().then((value) {
                  imagesUrlList.add(value);
                });
              });
            }
          } catch (e) {
            print(e.toString());
          }
        } else {
          MyMessageHandler.mySnackBar(
              _scaffoldKey, 'Please choose at least one image ');
        }
      } else {
        MyMessageHandler.mySnackBar(_scaffoldKey, 'Please fill all the fields');
      }
    } else {
      MyMessageHandler.mySnackBar(
          _scaffoldKey, 'Please choose a category/subcategory first');
    }
  }

  void uploadData() async {
    if (imagesUrlList.isNotEmpty) {
      CollectionReference productReference =
          FirebaseFirestore.instance.collection('products');

      proId = const Uuid().v4();
      await productReference.doc(proId).set({
        'proid': proId,
        'maincateg': mainCategValue,
        'subcateg': subCategValue,
        'price': price,
        'instock': quantity,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'prodimages': imagesUrlList,
        'discount': 0,
      }).whenComplete(() {
        setState(() {
          imagesFileList = [];
          mainCategValue = 'select category';
          alteredList = [];
          imagesUrlList = [];
        });
        _formKey.currentState!.reset();
      });
    } else {
      MyMessageHandler.mySnackBar(_scaffoldKey, 'No Image Chosen');
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() {
      uploadData();
    });
  }

  Widget previewImages() {
    if (imagesFileList!.isNotEmpty) {
      return ListView.builder(
        itemCount: imagesFileList!.length,
        itemBuilder: ((context, index) {
          return Image.file(File(imagesFileList![index].path));
        }),
      );
    } else {
      return const Center(
        child: Text(
          'You have not\n\npicked images yet.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //---Images-picking container----//
                      Container(
                        color: Colors.blueGrey.shade100,
                        width: MediaQuery.of(context).size.width * .5,
                        height: MediaQuery.of(context).size.height * .5,
                        child: previewImages(),
                      ),

                      //--category-picking SizedBox-//
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        height: MediaQuery.of(context).size.height * .5,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    '*Select Main Category',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  DropdownButton(
                                      menuMaxHeight: 500,
                                      iconSize: 40,
                                      iconEnabledColor: Colors.red,
                                      dropdownColor: Colors.yellow.shade400,
                                      // initial value to be shown to the user..//
                                      value: mainCategValue,
                                      items: MyList.mainCategory
                                          .map<DropdownMenuItem<String>>((e) {
                                        return DropdownMenuItem(
                                            value: e, child: Text(e));
                                      }).toList(),
                                      // const [
                                      //   DropdownMenuItem(
                                      //     value: 'men',
                                      //     child: Text('men'),
                                      //   )
                                      // ],
                                      onChanged: (String? value) {
                                        selectYourCategory(value!);
                                        setState(() {
                                          mainCategValue = value;
                                          print(value);
                                        });
                                      }),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('*Select Sub Category',
                                      style: TextStyle(color: Colors.red)),
                                  DropdownButton(
                                    menuMaxHeight: 500,
                                    iconSize: 40,
                                    iconEnabledColor: Colors.red,
                                    dropdownColor: Colors.yellow.shade400,
                                    iconDisabledColor: Colors.black,
                                    disabledHint: const Text('select category'),
                                    //-the initial value for the user to be seen-//
                                    value: subCategValue,
                                    items: alteredList
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        subCategValue = value!;
                                        // print(subCategValue);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                    child: Divider(
                      thickness: 1.5,
                      color: Colors.yellow,
                    ),
                  ),

                  //----price textformfield----//
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter Price';
                          } else if (val.isPriceValid() != true) {
                            return 'Enter valid price only';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                        keyboardType: TextInputType.number,
                        decoration: textFormDecoration.copyWith(
                            labelText: 'price', hintText: 'price..\$'),
                      ),
                    ),
                  ),

                  //----quantity textformfield----//
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .45,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter Quantity';
                          } else if (val.isQuantityValid() != true) {
                            return 'Invalid Quantity';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          quantity = double.parse(value!);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: textFormDecoration.copyWith(
                            labelText: 'Quantity', hintText: 'Add quantity..'),
                      ),
                    ),
                  ),

                  //----product name textformfield----//
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter Product Name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proName = value!;
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecoration.copyWith(
                            labelText: 'Product Name',
                            hintText: 'Enter product name..'),
                      ),
                    ),
                  ),

                  //----product description textformfield----//
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please describe the product';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          proDes = value!;
                        },
                        maxLength: 800,
                        maxLines: 5,
                        decoration: textFormDecoration.copyWith(
                            labelText: 'Product Description',
                            hintText: 'Describe Product here..'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: FloatingActionButton(
                backgroundColor: Colors.yellow,
                onPressed: imagesFileList!.isEmpty
                    ? () {
                        pickProducts();
                      }
                    : () {
                        setState(() {
                          imagesFileList = [];
                        });
                      },
                child: imagesFileList!.isEmpty
                    ? const Icon(
                        Icons.photo_album,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ),
              ),
            ),
            FloatingActionButton(
              backgroundColor: Colors.yellow,
              onPressed: () {
                uploadProduct();
              },
              child: const Icon(
                Icons.upload,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: '',
  hintText: '',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.yellow, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
    borderRadius: BorderRadius.circular(10),
  ),
);

extension QuantityValidator on String {
  bool isQuantityValid() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isPriceValid() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
