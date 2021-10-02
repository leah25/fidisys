import 'package:fidigames/screens/home_page.dart';
import 'package:fidigames/widgets/inputForm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fidigames/screens/utils/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          Center(
            child: Text('Fidigames', style: AppTheme.textDisplayedStyleLarge),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
          ),
          Center(
            child: Text('Log in', style: AppTheme.textDisplayedStyleSmall),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          InputForm(),
        ],
      )),
    );
  }
}
