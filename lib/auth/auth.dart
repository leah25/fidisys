import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fidigames/screens/home_page.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<void> submitForm(
      String email, String password, BuildContext context) async {
    var result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', '${result.user!.uid}');
    Navigator.pushNamed(context, HomePage.routeName);
  }
}
