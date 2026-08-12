import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ParentHeader extends StatelessWidget {
  final String parentName;
  final VoidCallback onNotificationTap;

  const ParentHeader({
    super.key,
    required this.parentName,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
     decoration: BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFCFA),
      Color(0xFFFFF4EA),
    ],
  ),
  border: Border(
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
          const Text(
            'Bright Future School',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: AppTheme.textPrimary,
            ),
          ),

          const Spacer(),

          // Notification
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

          // Profile Circle
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
  child: const Center(
    child: Text(
      "MS",
      style: TextStyle(
        color: AppTheme.primaryOrange,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

          const SizedBox(width: 10),

          // Parent Name
          Text(
            parentName,
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
}