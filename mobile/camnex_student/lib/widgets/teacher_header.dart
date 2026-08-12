import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TeacherHeader extends StatelessWidget {
  final String schoolName;
  final String teacherName;

  final VoidCallback onCalendarTap;
  final VoidCallback onNotificationTap;

  const TeacherHeader({
    super.key,
    required this.schoolName,
    required this.teacherName,
    required this.onCalendarTap,
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
            offset: Offset(0, 4),
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

          // ===========================
          // Calendar
          // ===========================

          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: onCalendarTap,
              icon: const Icon(
                Icons.calendar_month_outlined,
                color: AppTheme.primaryBlue,
                size: 26,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ===========================
          // Notifications
          // ===========================

          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: onNotificationTap,
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: AppTheme.primaryOrange,
                size: 26,
              ),
            ),
          ),

          const SizedBox(width: 15),

          // ===========================
          // Teacher Avatar
          // ===========================

          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFEAF2FF),
                  Color(0xFFF7FAFF),
                ],
              ),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                _getInitials(teacherName),
                style: const TextStyle(
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ===========================
          // Teacher Name
          // ===========================

          Text(
            teacherName,
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