import 'package:finance_tracker/core/commons/custom_button.dart';
import 'package:finance_tracker/core/commons/custom_textformfield.dart';
import 'package:finance_tracker/features/auth/controller/auth_controller.dart';
import 'package:finance_tracker/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const routeName = '/profilescreen';
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController controller = TextEditingController();

  signOutFromApp() {
    ref.read(authControllerProvider.notifier).googleSignOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/images/person1.jpeg'),
              ),
              Container(
                width: 500,
                child: CustomTextFormField(
                  hintText: 'Addae Owusu',
                  controller: controller,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 500,
                child: CustomTextFormField(
                  hintText: '04356543256',
                  controller: controller,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 500,
                child: CustomTextFormField(
                  hintText: 'addaeowusu@gmail.com',
                  controller: controller,
                ),
              ),
              CustomButton(
                onPressed: signOutFromApp,
                text: 'Sign Out',
                color: Pallete.blueColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
