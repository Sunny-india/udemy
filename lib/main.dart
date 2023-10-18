import 'package:flutter/material.dart';
import 'package:udemycopy/auth/customer_login.dart';
import 'package:udemycopy/auth/supplier_login.dart';
import 'package:udemycopy/auth/supplier_signup.dart';
import 'package:udemycopy/customer_home_screen.dart';
import '../supp_dashboard_components/supp_statics.dart';
import '../supp_dashboard_components/supp_balance.dart';
import '../supp_dashboard_components/supp_edit_profile.dart';
import '../supp_dashboard_components/supp_manage_products.dart';
import '../supp_dashboard_components/supp_orders.dart';
import '../supplier_screen.dart';
import '../welcome_screen.dart';

import 'auth/customer_signup.dart';
import 'supp_dashboard_components/supp_my_store.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: '/welcome_screen',
      routes: {
        // "/": (context) => const WelcomeScreen(),
        '/welcome_screen': (context) => WelcomeScreen(),

        '/customer_sign_up': (context) => const CustomerRegister(),
        '/customer_login': (context) => const CustomerLogIn(),
        '/customer_home_screen': (context) => const CustomerHomeScreen(),

        '/supplier_sign_up': (context) => const SupplierRegister(),
        '/supplier_login': (context) => const SupplierLogIn(),
        '/supplier_screen': (context) => SupplierScreen(),
        '/supplier_my_store': (context) => const MyStore(),
        '/supplier_orders': (context) => const Orders(),
        '/supplier_edit_profile': (context) => const EditProfile(),
        '/supplier_manage_product': (context) => const ManageProducts(),
        '/supplier_balance': (context) => const Balance(),
        '/supplier_statics': (context) => const Statics()
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
