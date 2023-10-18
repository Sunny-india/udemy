import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../my_widgets/auth_widgets.dart';
import '../my_widgets/snackbar.dart';

class SupplierLogIn extends StatefulWidget {
  const SupplierLogIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SupplierLogInState();
  }
}

class SupplierLogInState extends State<SupplierLogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String email;

  late String password;

  bool passwordVisible = false;

  bool isProcessing = false;

  void logIn() async {
    setState(() {
      isProcessing = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        _formKey.currentState!.reset();

        Navigator.pushReplacementNamed(context, '/supplier_screen');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            isProcessing = false;
          });

          MyMessageHandler.mySnackBar(_scaffoldKey, 'User not found');
        } else if (e.code == 'wrong-password') {
          setState(() {
            isProcessing = false;
          });

          MyMessageHandler.mySnackBar(_scaffoldKey, 'password does not match');
        }
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AuthHeaderLabel(headerLabel: 'Log In'),
                        const SizedBox(height: 50),
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
                        //-Forgot Password-//
                        TextButton(
                          child: const Text(
                            'Forgot Password? ',
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          ),
                          onPressed: () {},
                        ),
                        //--Don't have account? Sign Up-//
                        HaveAccount(
                            haveAccount: 'Don\'t have account? ',
                            actionLabel: 'Sign Up',
                            press: () {
                              Navigator.pushReplacementNamed(
                                  context, '/supplier_sign_up');
                            }),

                        /*---Main Button to authorise textFormFields---

                        because we needed to validate the whole fields in TextFormField with one button, we
                        / needed a global key, That's why we wrapped this whole column a Form, assigned
                        / a GlobalKey of <FormState> type there. and get that used here.*/
                        isProcessing == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.purple,
                              ))
                            : AuthMainButton(
                                mainButtonLabel: 'Log In',
                                press: () {
                                  logIn();
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
