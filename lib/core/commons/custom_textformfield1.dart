// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFormField1 extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  const CustomTextFormField1({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
