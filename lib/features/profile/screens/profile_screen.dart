import 'package:finance_tracker/core/commons/custom_button.dart';
import 'package:finance_tracker/core/constants/loader.dart';
import 'package:finance_tracker/features/auth/controller/auth_controller.dart';
import 'package:finance_tracker/features/auth/repository/auth_repository.dart';
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

  void toogleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toogleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 10,
            ),
            child: ref.watch(currentUserProvider).when(
                data: (data) {
                  return Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'Email and Name are displayed here',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(data.profilePic),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              data.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // ListTile(
                      //   title: const Text('Change Theme'),
                      //   trailing: Switch.adaptive(
                      //       value: ref
                      //                   .watch(themeNotifierProvider.notifier)
                      //                   .mode ==
                      //               ThemeMode.dark
                      //           ? true
                      //           : false,
                      //       onChanged: (value) => toogleTheme(ref)),
                      // ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              onPressed: signOutFromApp,
                              color: Pallete.blueColor,
                              child: isLoading
                                  ? const Loader()
                                  : const Text(
                                      'Sign Out',
                                      style: TextStyle(
                                        color: Pallete.whiteColor,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                error: (error, trace) {
                  return Center(
                    child: Text(error.toString()),
                  );
                },
                loading: () => const Loader())

            // Column(
            //   // crossAxisAlignment: CrossAxisAlignment.center,
            //   // mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Row(
            //       children: [

            //         // Container(
            //         //   width: 100,
            //         //   child: CustomTextFormField(
            //         //     hintText: 'Addae Owusu',
            //         //     controller: controller,
            //         //   ),
            //         // ),
            //         // const SizedBox(height: 10),
            //         // Container(
            //         //   width: 100,
            //         //   child: CustomTextFormField(
            //         //     hintText: '04356543256',
            //         //     controller: controller,
            //         //   ),
            //         // ),
            //         // const SizedBox(height: 10),
            //         // Container(
            //         //   width: 100,
            //         //   child: CustomTextFormField(
            //         //     hintText: 'addaeowusu@gmail.com',
            //         //     controller: controller,
            //         //   ),
            //         // ),
            //       ],
            //     ),

            //   ],
            // ),
            ),
      ),
    );
  }
}
