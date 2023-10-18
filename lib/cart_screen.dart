import 'package:flutter/material.dart';
import '../my_widgets/appbar_title.dart';

import 'my_widgets/yellow_button.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({this.back, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CartScreenState();
  }
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: widget.back,
            title: const AppBarTitle(title: 'Cart'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: IconButton(
                  color: Colors.black,
                  onPressed: () {},
                  icon: const Icon(Icons.delete_forever),
                ),
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your Cart is Empty',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 20),
                Material(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.lightBlueAccent,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * .6,
                    onPressed: () {
                      Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : Navigator.pushReplacementNamed(
                              context, '/customer_home_screen');
                    },
                    child: const Text(
                      'Continue Shopping',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      'Total: \$ ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '00:00',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ],
                ),
                YellowButton(
                  name: 'Continue',
                  onPressed: () {},
                  width: .45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
