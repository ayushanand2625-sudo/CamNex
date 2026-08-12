import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TeacherDashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String buttonText;
  final VoidCallback? onTap;
  final String? suffix;

  const TeacherDashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.buttonText,
    this.onTap,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppTheme.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: .06),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //------------------------------------------------
          // ICON + TITLE
          //------------------------------------------------

          Row(
            children: [

              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xffEEF4FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryBlue,
                  size: 28,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          //------------------------------------------------
          // VALUE
          //------------------------------------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Text(
                value,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),

              if (suffix != null) ...[
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    suffix!,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 20),

          //------------------------------------------------
          // BUTTON
          //------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: const Icon(
                Icons.arrow_forward,
                size: 18,
              ),
              label: Text(buttonText),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}