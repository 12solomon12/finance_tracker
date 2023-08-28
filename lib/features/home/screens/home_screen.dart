import 'package:finance_tracker/features/add_finance/screens/add_finance_screen.dart';
import 'package:finance_tracker/features/show_finance/screens/show_finance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/screens/profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/homescreen';
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Widget> screens = const [
    ShowFinanceScreen(),
    AddFinanceScreen(),
    ProfileScreen(),
  ];
  int page = 0;
  onTap(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[page],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: page,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Person'),
          ]),
    );
  }
}
