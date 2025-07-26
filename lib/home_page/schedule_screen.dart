import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String selectedTab = 'Upcoming';

  List<List> Teams = [
    ['Team Shadow', 'Team Xenon'],
    ['Team Shadow', 'Team Xenon'],
    ['Team Shadow', 'Team Xenon'],
    ['Team Shadow', 'Team Xenon'],
    ['Team Shadow', 'Team Xenon']
  ];

  List<List> BotNames = [
    ['Name of bot', 'Name of bot'],
    ['Name of bot', 'Name of bot'],
    ['Name of bot', 'Name of bot'],
    ['Name of bot', 'Name of bot'],
    ['Name of bot', 'Name of bot']
  ];

  List<String> Winners = [
    'Team Shadow',
    'Team Shadow',
    'Team Shadow',
    'Team Shadow',
    'Team Shadow'
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/images/robovitics logo.svg',
              height: 40,
              width: 40,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Schedule",
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
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/teams');
                },
                child: const Icon(
                  Icons.groups,
                  color: Color(0xFF9C49E2),
                  size: 35,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // 🔹 Gradient line below AppBar
            Container(
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

            // 🔸 Tabs
            Container(
              width: 240,
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  _scheduleToggleButton(label: 'Upcoming', isUpcoming: true),
                  _scheduleToggleButton(label: 'Completed', isUpcoming: false),
                ],
              ),
            ),

            // 🔸 Match List
            Expanded(
              child: selectedTab == 'Upcoming'
                  ? buildMatchList(showWinner: false)
                  : buildMatchList(showWinner: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scheduleToggleButton({required String label, required bool isUpcoming}) {
    final selected = (selectedTab == 'Upcoming') == isUpcoming;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          selectedTab = isUpcoming ? 'Upcoming' : 'Completed';
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
              colors: [Color(0xFF9D3AE7), Color(0xFFC88DF5)],
              begin: Alignment.centerLeft,
              end: Alignment.bottomCenter,
            )
                : null,
            color: selected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMatchList({required bool showWinner}) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: Teams.length,
      itemBuilder: (context, index) {
        return Container(
          height: 184,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.purpleAccent),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 130,
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x73000000), Color(0x73A74FEF)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(150),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Teams[index][0]}\n(${BotNames[index][0]})",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        showWinner
                            ? const Text(
                          "WINNERS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat',
                          ),
                        )
                            : const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Starts at",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "3:30 p.m",
                              style: TextStyle(
                                color: Color(0xFFB84BFF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text.rich(
                          TextSpan(
                            text: 'V',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: '/',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB84BFF),
                                ),
                              ),
                              TextSpan(
                                text: 'S',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (showWinner)
                        Transform.translate(
                          offset: const Offset(0, -20),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              Winners[index],
                              style: const TextStyle(
                                color: Color(0xFFBA9BE2),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Teams[index][1]}\n(${BotNames[index][1]})",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.purpleAccent),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFFFFFFF),
                                Color(0xFF8F8F8F),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            "Category (15 kg)",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
