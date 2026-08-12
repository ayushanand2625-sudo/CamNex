import 'package:flutter/material.dart';

class NoticeSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const NoticeSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: Container(
        width: 250,
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // Icon
            Icon(
              icon,
              size: 35,
              color: const Color(0xff2563EB),
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 8),

            // Value
            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xff2563EB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}