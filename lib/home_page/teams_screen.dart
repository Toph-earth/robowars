import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  bool isTeamsSelected = true;

  final List<Map<String, dynamic>> teamsData = List.generate(
    10,
        (_) => {
      'name': 'Team Orcus',
      'bots': [
        {'name': 'Raven', 'weight': '60 kg'},
        {'name': 'Vulcan', 'weight': '15 kg'},
      ],
      'description':
      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout...',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Column(
          children: [
            _buildAppBar(),
            _buildFadingLine(),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          _buildToggle(),
          const SizedBox(height: 24),
          Expanded(child: _buildAnimatedBody()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
      title: Text(
        isTeamsSelected ? 'Teams' : 'Table',
        style: const TextStyle(
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
              color: Color(0xFFB84BFF),
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFadingLine() {
    return Container(
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
    );
  }

  Widget _buildToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 240,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              _toggleButton(label: 'Teams', selectTeams: true),
              _toggleButton(label: 'Table', selectTeams: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _toggleButton({required String label, required bool selectTeams}) {
    final selected = isTeamsSelected == selectTeams;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          isTeamsSelected = selectTeams;
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
              colors: [Color(0xFF9D3AE7), Color.fromARGB(255, 200, 141, 245)],
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

  Widget _buildAnimatedBody() => AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    child: isTeamsSelected ? _buildTeamsList() : _buildTableView(),
  );

  Widget _buildTeamsList() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: ListView.builder(
      itemCount: teamsData.length,
      itemBuilder: (context, index) {
        final team = teamsData[index];
        return GestureDetector(
          onTap: () => _showTeamPopup(context, team),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF9D3AE7), width: 1.5),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...team['bots'].map<Widget>((bot) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${bot['name']} (${bot['weight']})',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    ),
  );

  Widget _buildTableView() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: ListView.builder(
      itemCount: teamsData.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF9D3AE7), width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0x1AFFCCFF), Color(0x1A9D3AE7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade400, width: 1),
                        color: Colors.black12,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                colors: [Colors.grey, Colors.black],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Matches", style: TextStyle(color: Colors.white)),
                                    Text("Won", style: TextStyle(color: Colors.white)),
                                    Text("Lost", style: TextStyle(color: Colors.white)),
                                    Text("Points", style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("3", style: TextStyle(color: Color(0xFF9D3AE7))),
                                    Text("1", style: TextStyle(color: Color(0xFF9D3AE7))),
                                    Text("2", style: TextStyle(color: Color(0xFF9D3AE7))),
                                    Text("2", style: TextStyle(color: Color(0xFF9D3AE7))),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  void _showTeamPopup(BuildContext context, Map<String, dynamic> team) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(team['name'], style: const TextStyle(color: Colors.white)),
        content: Text(
          team['description'],
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Color(0xFF9D3AE7))),
          ),
        ],
      ),
    );
  }
}
