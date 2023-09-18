import 'package:finance_tracker/features/auth/controller/auth_controller.dart';
import 'package:finance_tracker/features/auth/repository/auth_repository.dart';
import 'package:finance_tracker/firebase_options.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/router.dart';
import 'package:finance_tracker/theme/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/features/auth/screens/sign_up_screen.dart';
import 'package:finance_tracker/features/home/screens/home_screen.dart';
import 'package:finance_tracker/features/profile/screens/profile_screen.dart';
import 'package:finance_tracker/features/splash/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref) async {
    userModel =
        await ref.watch(authControllerProvider.notifier).getUserData().first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) {
          return MaterialApp.router(
            title: 'Finance Tracker',
            debugShowCheckedModeBanner: false,
            theme: ref.watch(themeNotifierProvider),
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (data != null) {
                getData(ref);
                return loggedInRoute;
              }
              return loggedOutRoute;
            }),
            routeInformationParser: const RoutemasterParser(),
            //   home: const HomeScreen(),
            // routes: {
            //   HomeScreen.routeName: (context) {
            //     if (data != null) {
            //       getData(ref);
            //       if (userModel != null) {
            //         return const HomeScreen();
            //       }
            //     }
            //     return const SignUpScreen();
            //   },
            //   SignUpScreen.routeName: (context) => const SignUpScreen(),
            //   ProfileScreen.routeName: (context) => const ProfileScreen(),
            // },
          );
        },
        error: (error, strackrace) => Text(error.toString()),
        loading: () => Builder(builder: (context) {
              return const CircularProgressIndicator();
            }));
  }
}
