import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:robowars_app/home_page/guess_game.dart';
import 'package:robowars_app/home_page/live_match.dart';
import 'package:robowars_app/home_page/key_contenders.dart';
import 'package:robowars_app/home_page/quick_stats.dart';
import 'package:robowars_app/home_page/widgets/fluid_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final Widget logo = SvgPicture.asset(
    'assets/images/robovitics logo.svg',
    height: 40,
    width: 40,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          // Scrollable AppBar section
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: false,
            expandedHeight: 0, // No expanded state
            backgroundColor: Colors.black,
            elevation: 0,
            leading: Padding(padding: const EdgeInsets.all(10), child: logo),
            centerTitle: true,
            title: const Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Trajan Pro',
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(
                  Icons.account_circle_outlined,
                  color: Color(0xFF9C49E2),
                  size: 35,
                ),
              ),
            ],
          ),

          // Gradient line (fixed position)
          SliverToBoxAdapter(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Color(0xFFB84BFF),
                    Colors.transparent,
                  ],
                  stops: [0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Main content (non-scrollable, stays fixed)
          SliverPadding(
            padding: EdgeInsets.only(
              bottom:
                  MediaQuery.of(context).padding.bottom +
                  kBottomNavigationBarHeight +
                  16,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GuessGame(),
                      SizedBox(height: 20),
                      LiveMatch(),
                      SizedBox(height: 20),
                      KeyContenders(
                        contenders: [
                          Contender(
                            name: "Raven (60 kg)",
                            team: "Team Orcus",
                            result: "Wins",
                          ),
                          Contender(
                            name: "Vulcan (15 kg)",
                            team: "Team Orcus",
                            result: "Wins",
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      QuickStats(
                        stats: {
                          "Matches": "6",
                          "Wins": "4",
                          "Losses": "2",
                          "KOs": "3",
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FluidNavBar(
        icons: [
          Icons.home_filled,
          Icons.calendar_month,
          Icons.groups,
          Icons.campaign,
        ],
        labels: ['Home', 'Schedule', 'Teams', 'Updates'],
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        context: context,
        activeGradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 117, 50, 240),
            Color.fromARGB(255, 135, 100, 181),
            Color.fromARGB(255, 186, 155, 226),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        inactiveColor: Colors.grey,
        barBackgroundColor: Color.fromARGB(255, 33, 33, 33),
        bubbleSize: 50.0,
      ),
    );
  }
}
