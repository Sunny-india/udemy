import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemycopy/cart_screen.dart';
import 'package:udemycopy/my_widgets/my_back_button.dart';

import 'customers_screen/customers_orders.dart';
import 'customers_screen/customers_wish_list.dart';
import 'my_widgets/alert_dialog.dart';

class CustomerProfileScreen extends StatefulWidget {
  final String documentId;

  const CustomerProfileScreen({Key? key, required this.documentId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CustomerProfileScreenState();
  }
}

class CustomerProfileScreenState extends State<CustomerProfileScreen> {
  @override
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  Widget build(BuildContext context) {
    String myTempImage =
        'https://sb.kaleidousercontent.com/67418/800x533/9e7eebd2c6/animals-0b6addc448f4ace0792ba4023cf06ede8efa67b15e748796ef7765ddeb45a6fb-removebg.png';
    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return
              //Text("Full Name: ${data['full_name']} ${data['last_name']}",);
              Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  expandedHeight: 140,
                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: constraints.biggest.height <= 120 ? 1 : 0,
                        child: const Center(
                          child: Text(
                            'Account',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.yellow, Colors.brown]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, top: 10),
                          child: Row(
                            children: [
                              data['profileimage'] == ''
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          NetworkImage(myTempImage),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          NetworkImage(data['profileimage']),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  data['name'] == ''
                                      ? 'guest'.toUpperCase()
                                      : data['name'].toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .9,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //--Cart container-//
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30))),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartScreen(
                                        back: MyBackButton(),
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width * .2,
                                  child: const Center(
                                    child: Text(
                                      'Cart',
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //--Orders Container-//
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                // borderRadius: BorderRadius.only(
                                //   topLeft: Radius.circular(30),
                                //   bottomLeft: Radius.circular(30),
                                // ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const CustomersOrders();
                                    },
                                  ));
                                },
                                child: SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width * .2,
                                  child: const Center(
                                    child: Text(
                                      'Orders',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //--wishList container-//
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CustomersWishList(),
                                      ));
                                },
                                child: SizedBox(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * .20,
                                  child: const Center(
                                    child: Text(
                                      'WishList',
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: Image.network(myTempImage),
                      ),
                      ProfileHeader(
                        profileLabel: '  Account Info  ',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 260,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white),
                          child: Column(
                            children: [
                              //-------- Email Address Tile---------//
                              RepeatedListTile(
                                title: 'Email Address',
                                subTitle: data['email'] == ''
                                    ? 'Signed in anonymously'
                                    : data['email'],
                                icon: Icons.email,
                                // onPressed: () {},
                              ),

                              const YellowDivider(),

                              //-------- Phone number Tile---------//
                              RepeatedListTile(
                                  title: 'Phone No.',
                                  subTitle: data['phone'] == ''
                                      ? 'No number provided'
                                      : data['phone'],
                                  icon: Icons.phone),

                              const YellowDivider(),

                              //-------- Address Tile---------//
                              RepeatedListTile(
                                  title: 'Address',
                                  subTitle: data['address'] == ''
                                      ? 'No Addess was filled-in'
                                      : data['address'],
                                  icon: Icons.location_pin),
                            ],
                          ),
                        ),
                      ),
                      ProfileHeader(
                        profileLabel: '  Account Settings  ',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 260,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white),
                          child: Column(
                            children: [
                              RepeatedListTile(
                                title: 'Edit Profile',
                                subTitle: '',
                                icon: Icons.edit,
                                onPressed: () {},
                              ),
                              const YellowDivider(),
                              RepeatedListTile(
                                title: 'Change Password',
                                subTitle: '',
                                icon: Icons.lock,
                                onPressed: () {},
                              ),
                              const YellowDivider(),
                              RepeatedListTile(
                                  title: 'Logout',
                                  subTitle: '',
                                  icon: Icons.logout,
                                  onPressed: () async {
                                    MyAlertDialog.myDialog(
                                        context: context,
                                        title: 'LogOut',
                                        content: 'Are you sure to log out?',
                                        tabNo: () {
                                          Navigator.pop(context);
                                        },
                                        tabYes: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Navigator.pop(context);
                                          Navigator.pushReplacementNamed(
                                              context, '/welcome_screen');
                                        });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(
            child: CircularProgressIndicator(
          color: Colors.purple,
        ));
      },
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.yellow,
        thickness: 1.4,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;
  RepeatedListTile({
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subTitle),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  String? profileLabel;
  ProfileHeader({
    required this.profileLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(color: Colors.grey, thickness: 1),
          ),
          Text(
            profileLabel!,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(color: Colors.grey, thickness: 1),
          ),
        ],
      ),
    );
  }
}
