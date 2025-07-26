import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robowars_app/home_page/home_screen.dart';
import 'package:robowars_app/home_page/provider/nav_provider.dart';
import 'package:robowars_app/home_page/schedule_screen.dart';
import 'package:robowars_app/home_page/teams_screen.dart';
import 'package:robowars_app/home_page/updates_screen.dart';
import 'package:robowars_app/home_page/widgets/fluid_nav_bar.dart';

class MainLayout extends ConsumerWidget {
  final List<Widget> _pages = const [
    HomeScreen(),
    Schedule(),
    TeamScreen(),
    UpdatesPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);
    final pageController = PageController(initialPage: currentIndex);

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          ref.read(navigationProvider.notifier).setIndex(index);
        },
        children: _pages,
      ),
      bottomNavigationBar: FluidNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        context: context,
        icons: const [
          Icons.home_filled,
          Icons.calendar_month,
          Icons.groups,
          Icons.campaign,
        ],
        labels: const ['Home', 'Schedule', 'Teams', 'Updates'],
        activeGradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 117, 50, 240),
            Color.fromARGB(255, 135, 100, 181),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        barBackgroundColor: const Color.fromARGB(255, 33, 33, 33),
        // Include all other required parameters
        activeColor: Colors.white,
        inactiveColor: Colors.grey,
        iconSize: 24.0,
        barHeight: 65.0,
        bubbleSize: 52.0,
      ),
    );
  }
}
