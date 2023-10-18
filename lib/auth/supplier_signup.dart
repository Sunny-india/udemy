import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../my_widgets/auth_widgets.dart';
import '../my_widgets/snackbar.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SupplierRegister extends StatefulWidget {
  const SupplierRegister({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SupplierRegisterState();
  }
}

class SupplierRegisterState extends State<SupplierRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String storeName;

  late String email;

  late String password;

  late String storeLogo;

  bool passwordVisible = false;

  final ImagePicker _pickMe = ImagePicker();

  XFile? myFile;

  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

  late String _uid;

  bool isProcessing = false;

  void pickImageFromGallery() async {
    try {
      final imagePicked = await _pickMe.pickImage(
          source: ImageSource.gallery,
          imageQuality: 95,
          maxHeight: 300,
          maxWidth: 300);
      setState(() {
        myFile = imagePicked;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void pickImageFromCamera() async {
    try {
      final imagePicked = await _pickMe.pickImage(
          source: ImageSource.camera,
          imageQuality: 95,
          maxHeight: 300,
          maxWidth: 300);
      setState(() {
        myFile = imagePicked;
      });
    } catch (e) {
      print('Image was not picked from Camera..!');
    }
  }

  void signUp() async {
    setState(() {
      isProcessing = true;
    });

    if (_formKey.currentState!.validate()) {
      if (myFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('supp-images/$email.jpg');

          await ref.putFile(File(myFile!.path));

          storeLogo = await ref.getDownloadURL();

          _uid = FirebaseAuth.instance.currentUser!.uid;

          await suppliers.doc(_uid).set({
            'storename': storeName,
            'email': email,
            'storelogo': storeLogo,
            'phone': '',
            'address': '',
            'sid': _uid,
            'coverimage': '',
          });

          _formKey.currentState!.reset();
          setState(() {
            myFile = null;
          });

          Navigator.pushReplacementNamed(context, '/customer_login');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              isProcessing = false;
            });

            MyMessageHandler.mySnackBar(_scaffoldKey, 'Weak Password.');
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              isProcessing = false;
            });

            MyMessageHandler.mySnackBar(_scaffoldKey, 'Email Already In Use');
          }
        }
      } else {
        setState(() {
          isProcessing = false;
        });

        MyMessageHandler.mySnackBar(
            _scaffoldKey, 'Please provide an Image of yours.');
      }
    } else {
      setState(() {
        isProcessing = false;
      });

      /**
       * ScaffoldMessanger function ko multiple usable banane ke liye,
       * isko globalKey bana ke re_usabale banaya. globalKeys class ki
       * tarah hi behave krti hain. us class mein ek function bana ke, re-use kiya.
       * isliye yahan se comment out kr diya. lekin reference ke liya rakaha hua hai .
       */

      /**
          ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
          backgroundColor: Colors.yellow,
          duration: Duration(seconds: 2),
          content: Text(
          'Please fill all the fields',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
          ),
          ));

       */

      MyMessageHandler.mySnackBar(_scaffoldKey, 'Please Fill all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key:
              _scaffoldKey, // ye key ab is ScaffoldMessenger class ki tarah behave karegi.
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const AuthHeaderLabel(headerLabel: 'Sign Up'),

                        //-- circleAvatar and ImagePicker----//
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 40),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.purpleAccent,
                                backgroundImage: myFile == null
                                    ? null
                                    : FileImage(File(myFile!.path)),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // print('Take pictures from Camera');
                                      pickImageFromCamera();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      pickImageFromGallery();
                                      // print('Pick images from Gallery');
                                    },
                                    icon: const Icon(
                                      Icons.photo,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //-----textFormField to get full name----//
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your full-name';
                              } else if (value.isValidName() == false) {
                                return 'Please provide us a correct name';
                              } else {
                                return null;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              storeName = value;
                            },
                            decoration: textFormDecoration,
                          ),
                        ),

                        //-----textFormField to get Email----//
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your Email';
                              } else if (value.isValidEmail() == false) {
                                return 'Email is not valid';
                              } else if (value.isValidEmail() == true) {
                                return null;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: textFormDecoration.copyWith(
                                labelText: 'Email',
                                hintText: 'Enter Your Email'),
                          ),
                        ),

                        //-----textFormField to get Password----//
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your Password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            obscureText: passwordVisible,
                            decoration: textFormDecoration.copyWith(
                              labelText: 'Password',
                              hintText: 'Enter Your password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                color: Colors.black,
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),

                        //--already have account and login-//
                        HaveAccount(
                            haveAccount: 'already have account? ',
                            actionLabel: 'Log In',
                            press: () {
                              Navigator.pushReplacementNamed(
                                  context, '/supplier_login');
                            }),

                        /*---Main Button to authorise textFormFields---

                        because we needed to validate the whole fields in TextFormField with one button, we
                        / needed a global key, That's why we wrapped this whole column a Form, assigned
                        / a GlobalKey of <FormState> type there. and get that used here.*/
                        isProcessing == true
                            ? const CircularProgressIndicator(
                                color: Colors.purple,
                              )
                            : AuthMainButton(
                                mainButtonLabel: 'Sign Up',
                                press: () {
                                  signUp();
                                }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
