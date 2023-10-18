import 'package:flutter/material.dart';

class AuthMainButton extends StatelessWidget {
  final String mainButtonLabel;
  final Function() press;
  const AuthMainButton(
      {Key? key, required this.mainButtonLabel, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Material(
        borderRadius: BorderRadius.circular(25),
        color: Colors.purple,
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: press,
          child: Text(
            mainButtonLabel,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount;

  final String actionLabel;

  final Function() press;

  const HaveAccount(
      {Key? key,
      required this.actionLabel,
      required this.haveAccount,
      required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount,
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        TextButton(
            child: Text(
              actionLabel,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: press),
      ],
    );
  }
}

class AuthHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const AuthHeaderLabel({
    Key? key,
    required this.headerLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerLabel,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/welcome_screen');
            },
            icon: const Icon(
              Icons.home_work,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Full Name',
  hintText: 'Enter your full name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.purple, width: 1),
    borderRadius: BorderRadius.circular(15),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
);

//--extension ek functionality hoti hai, jisko kisi bhi class pe liye jaye, for example on String,
// aur usme ek method define kiya jaye, to wo method us class ke native method ki tarah use kr
// skte hain; jaise is case mein isEmailValid() method ko TextFormField ke value, jo ki String type
// hai, uspe direct use kiya;
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^[a-zA-Z0-9]+[\-\_\.]*[a-zA-Z0-9]*[@][a-zA-Z0-9]{2,}[\.][a-zA-Z]{2,}$')
        .hasMatch(this);
  }

  bool isValidName() {
    return RegExp(r'^[a-zA-Z]{2,}[a-zA-Z]*$').hasMatch(this);
  }
}
