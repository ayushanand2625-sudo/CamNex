import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StudentHeader extends StatelessWidget {
  final String schoolName;
  final String studentName;
  final VoidCallback onNotificationTap;

  const StudentHeader({
    super.key,
    required this.schoolName,
    required this.studentName,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFCFA),
            Color(0xFFFFF4EA),
          ],
        ),
        border: const Border(
          bottom: BorderSide(
            color: AppTheme.border,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // School Name
          Text(
            schoolName,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: AppTheme.textPrimary,
            ),
          ),

          const Spacer(),

          // Notification Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: onNotificationTap,
              icon: const Icon(
                Icons.notifications_none_outlined,
                size: 26,
                color: AppTheme.primaryOrange,
              ),
            ),
          ),

          const SizedBox(width: 15),

          // Student Avatar
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFFE8D4),
                  Color(0xFFFFF4EA),
                ],
              ),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                _getInitials(studentName),
                style: const TextStyle(
                  color: AppTheme.primaryOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Student Name
          Text(
            studentName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),

          const SizedBox(width: 8),

          const Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.textPrimary,
          ),
        ],
      ),
    );
  }

  static String _getInitials(String name) {
    final parts = name.trim().split(' ');

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}