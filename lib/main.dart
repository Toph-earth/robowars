import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robowars_app/home_page/home_screen.dart';
import 'package:robowars_app/home_page/profile_screen.dart';
import 'package:robowars_app/home_page/schedule_screen.dart';
import 'package:robowars_app/home_page/teams_screen.dart';
import 'package:robowars_app/home_page/updates_screen.dart';
import 'package:robowars_app/home_page/widgets/test_screen.dart';

import 'home_page/main_layout.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Robowars App',
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/home',
      routes: {
        '/profile' : (context) => MainLayout(),
        '/home': (context) => MainLayout(),
        '/schedule' : (context) => MainLayout(),
        '/teams': (context) => MainLayout(),
        '/updates' : (context) => MainLayout(),
      }
    );
  }
}
