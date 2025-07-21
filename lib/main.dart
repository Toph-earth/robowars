import 'package:flutter/material.dart';
import 'package:robowars_app/home_page/home_screen.dart';
import 'package:robowars_app/home_page/schedule_screen.dart';
import 'package:robowars_app/home_page/teams_screen.dart';
import 'package:robowars_app/home_page/updates_screen.dart';
import 'package:robowars_app/home_page/widgets/test_screen.dart';

void main() {
  runApp(const MyApp());
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
        '/home': (context) => HomeScreen(),
        '/schedule' : (context) => Schedule(),
        '/teams': (context) => TeamScreen(),
        '/updates' : (context) => UpdatesPage(),
      }
    );
  }
}
