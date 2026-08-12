import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

 @override
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final bool isSmallScreen = width < 1200;

  return Container(
    height: 90,
    padding: const EdgeInsets.symmetric(
      horizontal: 25,
    ),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 250, 239, 228),
      boxShadow: [
        BoxShadow(
          blurRadius: 8,
          color: Colors.black12,
        ),
      ],
    ),

    child: LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              child: Text(
                "Bright Future School",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 30,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF224EEC),
                ),
              ),
            ),

            if (!isSmallScreen)
              SizedBox(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

            const SizedBox(width: 10),

            const Icon(Icons.notifications),

            const SizedBox(width: 10),

            const CircleAvatar(
              child: Icon(Icons.person),
            ),

            if (!isSmallScreen)
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Ayush",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    ),
  );
}
}