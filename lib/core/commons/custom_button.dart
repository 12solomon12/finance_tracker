// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finance_tracker/theme/pallete.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 45),
        maximumSize: const Size(double.infinity, 45),
        backgroundColor: color,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Pallete.whiteColor,
        ),
      ),
    );
  }
}
