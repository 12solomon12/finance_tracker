import 'package:finance_tracker/features/auth/repository/auth_repository.dart';
import 'package:finance_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/features/auth/screens/sign_up_screen.dart';
import 'package:finance_tracker/features/home/screens/home_screen.dart';
import 'package:finance_tracker/features/profile/screens/profile_screen.dart';
import 'package:finance_tracker/features/splash/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) {
          return MaterialApp(
            title: 'Finance Tracker',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            routes: {
              HomeScreen.routeName: (context) => const HomeScreen(),
              SignUpScreen.routeName: (context) => const SignUpScreen(),
              ProfileScreen.routeName: (context) => const ProfileScreen(),
            },
            home: data != null ? const HomeScreen() : const SplashScreen(),
          );
        },
        error: (error, strackrace) => Text(error.toString()),
        loading: () => Builder(builder: (context) {
              return const CircularProgressIndicator();
            }));
  }
}
