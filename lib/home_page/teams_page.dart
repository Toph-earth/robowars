import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OurTeamPage extends StatefulWidget {
  const OurTeamPage({super.key});

  @override
  State<OurTeamPage> createState() => _OurTeamPageState();
}

class _OurTeamPageState extends State<OurTeamPage> {
  final List<Map<String, String>> teamMembers = const [
    {'name': 'Yash Pathak', 'role': 'Kursi'},
    {'name': 'Navaneeth H K', 'role': 'Stool'},
    {'name': 'Ayan Gattani', 'role': 'Sacheev'},
    {'name': 'Harsh Patel', 'role': 'Up - Sacheev'},
    {'name': 'Aakash Gurumurthy', 'role': 'Tent Wala'},
    {'name': 'Pradnya Sharma', 'role': 'Design Pramukh'},
    {'name': 'Arnav Srivastava', 'role': 'Robowars Pramukh'},
    {'name': 'Aakashdip Dey', 'role': 'Sampadak Pramukh'},
    {'name': 'Arnav Oberoi', 'role': 'Hacker'},
    {'name': 'Anirban Haldar', 'role': 'Bengali Dada'},
    {'name': 'Rishabh Paul', 'role': 'Randi saala haramkhor'},
    {'name': 'Aditya Kale', 'role': 'English Randi (whore)'},
    {'name': 'Ujjwal Jha', 'role': 'Mechanic'},
    {'name': 'Arunabh Gupta', 'role': 'App Mukhiya'},
    {'name': 'Kavya Jain', 'role': 'Computer Pramukh'},
    {'name': 'Arjun Venkatesh', 'role': 'Antivirus Pramukh'},
    {'name': 'Paridhi Pawaiya', 'role': 'Bhopal ki Sam Altman'},
    {'name': 'Simran Ahluwalia', 'role': 'Instagram Pramukh'},
    {'name': 'Vivek Chohan', 'role': 'Dusra Mechanic'},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 40,
                  width: 40,
                ),
              ),
              centerTitle: true,
              title: const Text(
                "Team Members",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Trajan Pro',
                ),
              ),

            ),
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
          ],
        ),
      ),

      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: Color(0xFFB84BFF)

            )
        ),


        child: ListView.builder(

          padding: const EdgeInsets.all(16),
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            final member = teamMembers[index];


            return Container(

              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:  Colors.grey,
                  width: 2,


                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white54, width: 1.5),
                    ),
                    child: const Icon(Icons.person, color: Colors.white54),
                    // Replace with `Image.asset()` or `NetworkImage` if you have profile pics
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          member['role']!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}