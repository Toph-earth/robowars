import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robowars_app/home_page/home_screen.dart';
import 'package:robowars_app/home_page/provider/nav_provider.dart';
import 'package:robowars_app/home_page/schedule_screen.dart';
import 'package:robowars_app/home_page/teams_screen.dart';
import 'package:robowars_app/home_page/updates_screen.dart';
import 'package:robowars_app/home_page/widgets/fluid_nav_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/services.dart';

class MainLayout extends ConsumerWidget {
  MainLayout({super.key});

  final icons = [
    Icons.home_outlined,
    Icons.calendar_month,
    Icons.group,
    Icons.campaign,
  ];

  final labels = [
    'Home',
    'Schedule',
    'Teams',
    'Updates',
  ];

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(

        child: PageView(

          controller: pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            ref.read(navigationProvider.notifier).setIndex(index);
          },
          children: _pages,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        
          index: currentIndex,
          onTap: (index) {
            pageController.animateToPage(index, duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          },
          //context: context,
        
        
          backgroundColor: Colors.black,
          color: const Color(0xFF212121),
          buttonBackgroundColor: Colors.transparent,
          height: 60,
          items: List.generate(
            icons.length,
                (index) {
              final bool isSelected = index == currentIndex;
              return CurvedNavigationBarItem(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: isSelected
                      ? const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF7532CC),
                        Color(0xFF8764B5),
                        Color(0xFFBA9BE2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  )
                      : null,
                  alignment: Alignment.center,
                  child: Icon(
                    icons[index],
                    color: isSelected ? Colors.black : Colors.white,
                    size: 30,
                  ),
                ),
                label: isSelected ? labels[index] : '',
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              );
            },
          ),
          //onTap: (index) {
            //ref.read(navigationProvider.notifier).setIndex(index);
        
          //},
        ),

    );
  }
}
