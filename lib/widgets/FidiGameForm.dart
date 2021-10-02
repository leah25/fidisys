import 'package:fidigames/screens/utils/constants.dart';
import 'package:flutter/material.dart';

class FidiForm extends StatelessWidget {
  const FidiForm(this.hint, this.controller, this.height, this.width,
      this.maxLines, this.validator, this.isObsecure);
  final String hint;
  final double height;
  final double width;
  final int maxLines;
  final TextEditingController controller;
  final String Function(String?)? validator;
  final bool isObsecure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        style: TextStyle(color: AppTheme.mainTextColor),
        cursorColor: AppTheme.mainTextColor,
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        obscureText: isObsecure,
        decoration: InputDecoration(
            fillColor: AppTheme.formColor,
            filled: true,
            hintText: hint,
            hintStyle: AppTheme.textDisplayedStyleSmallest
                .copyWith(color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
