import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StudentProfileScreen extends StatelessWidget {
  final String name;
  final String className;
  final String section;
  final String admissionNo;
  final String rollNo;

  const StudentProfileScreen({
    super.key,
    required this.name,
    required this.className,
    required this.section,
    required this.admissionNo,
    required this.rollNo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(
        title: const Text("Student Profile"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            //==============================
            // PROFILE PHOTO
            //==============================

            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppTheme.lightBlue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryBlue,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  _getInitials(name),
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Student",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            //==============================
            // DETAILS CARD
            //==============================

            _infoCard(
              icon: Icons.class_,
              title: "Class",
              value: className,
            ),

            const SizedBox(height: 14),

            _infoCard(
              icon: Icons.groups_outlined,
              title: "Section",
              value: section,
            ),

            const SizedBox(height: 14),

            _infoCard(
              icon: Icons.badge_outlined,
              title: "Admission Number",
              value: admissionNo,
            ),

            const SizedBox(height: 14),

            _infoCard(
              icon: Icons.confirmation_number_outlined,
              title: "Roll Number",
              value: rollNo,
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [

          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryBlue,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(" ");

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}