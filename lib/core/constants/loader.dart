import 'package:finance_tracker/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      color: Pallete.whiteColor,
    );
  }
}
