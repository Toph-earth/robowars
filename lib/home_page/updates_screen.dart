import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: Container(
        color: const Color(0xFF1C1C1C),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.calendar_month, color: Colors.white),
            Icon(Icons.group, color: Colors.white), // active icon
          ],
        ),
      ),

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
          "Updates",
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
              child: Icon(
                Icons.groups,
                color: Color(0xFF9C49E2),
                size: 35,
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Gradient Line like HomeScreen
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

            // 🔹 Main Content
            Expanded(
              child: Stack(
                children: [
                  // Watermark Background
                  Center(
                    child: Opacity(
                      opacity: 0.04,
                      child: SvgPicture.asset(
                        'assets/logo.svg',
                        width: 300,
                      ),
                    ),
                  ),

                  // Message List
                  ListView(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    children: [
                      buildUpdateCard(
                        name: "John Doe",
                        message:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                        time: "9:00 am",
                      ),
                      buildUpdateCard(
                        name: "Jane Doe",
                        message:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
                        time: "9:00 am",
                      ),
                      buildDateDivider("Yesterday"),
                      buildUpdateCard(
                        name: "John Doe",
                        message:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.",
                        time: "9:00 am",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Update Card Widget
  static Widget buildUpdateCard({
    required String name,
    required String message,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFD9D9D9),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF8439F9).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  //  Background Watermark
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.05,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/chat_watermark.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  //  Foreground Content
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Color(0xFFD9D9D9),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            time,
                            style: const TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  Date Divider with Gradient Line
  static Widget buildDateDivider(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
      child: Row(
        children: [
          // Left Gradient Line
          Expanded(
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Color(0xFFB84BFF),
                  ],
                ),
              ),
            ),
          ),

          // Text Label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFD9D9D9),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Right Gradient Line
          Expanded(
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.transparent,
                    Color(0xFFB84BFF),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
