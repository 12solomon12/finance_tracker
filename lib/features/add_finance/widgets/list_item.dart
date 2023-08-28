// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:finance_tracker/core/commons/custom_textformfield.dart';

class ListItem extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const ListItem({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 15,
        backgroundImage: AssetImage('assets/images/person1.jpeg'),
      ),
      title: CustomTextFormField(hintText: hintText, controller: controller),
    );
  }
}
