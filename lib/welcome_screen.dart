import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemycopy/supplier_screen.dart';

import 'my_widgets/yellow_button.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  late String _uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/medical/me0.JPG'),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //--1st child of the very first Column--//
              const Text(
                'Welcome',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),

              //--2nd child of the very first Column--//
              const SizedBox(
                height: 120,
                width: 200,
                child: Image(
                  image: AssetImage('images/mix/7067.png'),
                ),
              ),

              //--3rd child of the very first Column--//
              // const Text(
              //   'Shop',
              //   style: TextStyle(color: Colors.black, fontSize: 30),
              // ),

              //--4th child, a column itself, of the very first Column--//
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Supplier Only Container
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50))),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Supplier Only',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //--Logo, Login, and Sign In a Row.---//
                  //--That is children of this Column---//
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: const BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //----Image, the first child of this row-----//
                          const Image(
                            image: AssetImage('images/mix/7067.png'),
                          ),
                          // ---Second Child, a Login Button taking you to SupplierScreen------//
                          YellowButton(
                            name: 'Login',
                            width: .25,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/supplier_login');
                              print('Taking you to the Supplier Screen');
                            },
                          ),
                          //--Third child, a SignIn Button taking you Nowhere-----//
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: YellowButton(
                              name: 'Sign Up',
                              width: .25,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/supplier_sign_up');
                                print('Taking you to the Supplier Screen');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //--5th child, a Row, of the very first Column--//
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: const BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      // Repeated Logo, Login, and Sign In a Row,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //---- Login Button taking you to CustomerHomeScreen----//
                          YellowButton(
                            name: 'Login',
                            width: .25,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/customer_login');
                            },
                          ),

                          //---- SignUp Button taking you to CustomerRegister page----//
                          YellowButton(
                            name: 'Sign Up',
                            width: .25,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/customer_sign_up');
                            },
                          ),

                          //----Image, the third child of this row---//
                          const Image(image: AssetImage('images/mix/7067.png')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //--6th child of the very first Column--//
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white38),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //---Button for signup through your Google Account---//
                      GoogleFacebookLoginButton(
                          label: 'Google',
                          child: Image.asset(
                            'images/mix/googl-removebg1.png',
                          ),
                          onPressed: () {}),

                      //---Button for signup through your FaceBook---//
                      GoogleFacebookLoginButton(
                          label: 'FaceBook',
                          child: Image.asset(
                            'images/mix/fb-removebg.png',
                          ),
                          onPressed: () {}),
                      //----Guest Login Button---//
                      GoogleFacebookLoginButton(
                          label: 'Guest',
                          child: const Icon(
                            Icons.person,
                            size: 55,
                            color: Colors.lightBlueAccent,
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance
                                .signInAnonymously()
                                .whenComplete(() async {
                              _uid = FirebaseAuth.instance.currentUser!.uid;
                              await customers.doc(_uid).set({
                                'name': '',
                                'email': '',
                                'profileimage': '',
                                'phone': '',
                                'address': '',
                                'cid': _uid,
                              });
                            });

                            Navigator.pushReplacementNamed(
                                context, '/customer_home_screen');
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//---Model class created for Login Buttons, used on this page only---//
class GoogleFacebookLoginButton extends StatelessWidget {
  String label;
  Function() onPressed;
  Widget child;
  GoogleFacebookLoginButton({
    required this.label,
    required this.onPressed,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: child,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
