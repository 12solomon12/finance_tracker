import 'package:finance_tracker/core/commons/custom_button.dart';
import 'package:finance_tracker/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = '/signupscreen';

  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.watch(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/person1.jpeg',
                  height: 400,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onPressed: () {
                    signInWithGoogle(context, ref);
                    navigateToHomeScreen(context);
                    setState(() {});
                  },
                  text: 'Continue with Google',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
