import 'package:finance_tracker/features/auth/screens/sign_up_screen.dart';
import 'package:finance_tracker/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedInRoute = RouteMap(
    routes: {'/': (context) => const MaterialPage(child: HomeScreen())});
final loggedOutRoute = RouteMap(
    routes: {'/': (context) => const MaterialPage(child: SignUpScreen())});
