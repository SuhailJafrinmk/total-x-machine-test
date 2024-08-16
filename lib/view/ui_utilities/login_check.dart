 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:totelx_machine_test/view/screens/authentication/number_input_screen.dart';
import 'package:totelx_machine_test/view/screens/user/home_screen.dart';

Widget handleAuth() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const HomeScreen(); 
    } else {
      return const PhoneNumberVerificationScreen();
    }
  }