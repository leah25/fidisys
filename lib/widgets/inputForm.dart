import 'package:fidigames/auth/auth.dart';
import 'package:flutter/material.dart';

import 'package:fidigames/screens/utils/constants.dart';
import 'package:fidigames/widgets/FidiGameForm.dart';

class InputForm extends StatefulWidget {
  InputForm({Key? key}) : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              FidiForm("Email", _emailController, 48.0, 369.0, 1, (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address.';
                }
                return "";
              }, false),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              FidiForm("Password", _passController, 48.0, 369.0, 1, (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'Please enter at least 6 characters';
                }
                return '';
              }, true),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: 200,
                height: 48,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
                child: TextButton(
                    onPressed: () async {
                      await Auth().submitForm(
                          _emailController.text, _passController.text, context);
                    },
                    style: TextButton.styleFrom(
                        primary: AppTheme.backgroundColor,
                        backgroundColor: AppTheme.buttonColor),
                    child: Text(
                      "Sign In",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
              )
            ],
          )),
    );
  }
}
