import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udemycopy/my_widgets/appbar_title.dart';
import 'package:udemycopy/supp_dashboard_components/supp_balance.dart';
import 'package:udemycopy/supp_dashboard_components/supp_edit_profile.dart';
import 'package:udemycopy/supp_dashboard_components/supp_manage_products.dart';
import 'package:udemycopy/supp_dashboard_components/supp_my_store.dart';
import 'package:udemycopy/supp_dashboard_components/supp_orders.dart';
import 'package:udemycopy/supp_dashboard_components/supp_statics.dart';

import 'my_widgets/alert_dialog.dart';

List<String> cardNames = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statics',
];
List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

List<Widget> pageList = [
  const MyStore(),
  const Orders(),
  const EditProfile(),
  const ManageProducts(),
  const Balance(),
  const Statics()
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'DashBoard',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            color: Colors.black,
            onPressed: () {
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
                    Navigator.pushReplacementNamed(context, '/welcome_screen');
                  });
              //Navigator.pushReplacementNamed(context, '/welcome_screen');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            crossAxisCount: 2,
            children: List.generate(
              cardNames.length,
              (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pageList[index],
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.blueGrey.withOpacity(.6),
                    elevation: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icons[index],
                          size: 40,
                        ),
                        Text(
                          cardNames[index].toUpperCase(),
                          style: const TextStyle(
                              letterSpacing: 1.2,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Acme'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
