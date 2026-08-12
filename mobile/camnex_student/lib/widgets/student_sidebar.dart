import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StudentSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const StudentSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: AppTheme.border,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildLogo(),

          const Divider(
            height: 1,
            color: AppTheme.border,
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 20,
              ),
              children: [
                // HOME
                _sectionTitle("HOME"),

                _menuItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  title: "Student Dashboard",
                ),

                const SizedBox(height: 20),

                // =========================
                // ACADEMICS
                // =========================
                _sectionTitle("ACADEMICS"),

                _menuItem(
                  index: 1,
                  icon: Icons.calendar_month_outlined,
                  title: "Attendance",
                ),

                _menuItem(
                  index: 2,
                  icon: Icons.menu_book_outlined,
                  title: "Homework",
                ),

                _menuItem(
                  index: 3,
                  icon: Icons.assignment_outlined,
                  title: "Exam Results",
                ),

                _menuItem(
                  index: 4,
                  icon: Icons.chat_bubble_outline,
                  title: "Teacher Remarks",
                ),

                _menuItem(
                  index: 5,
                  icon: Icons.class_outlined,
                  title: "My Class",
                ),

                const SizedBox(height: 20),

                // =========================
                // SERVICES
                // =========================
                _sectionTitle("SERVICES"),

                _menuItem(
                  index: 6,
                  icon: Icons.credit_card_outlined,
                  title: "Smart Card",
                ),

                _menuItem(
                  index: 7,
                  icon: Icons.local_library_outlined,
                  title: "Library",
                ),

                _menuItem(
                  index: 8,
                  icon: Icons.restaurant_outlined,
                  title: "Canteen",
                ),

                _menuItem(
                  index: 9,
                  icon: Icons.directions_bus_outlined,
                  title: "Transport",
                ),

                _menuItem(
                  index: 10,
                  icon: Icons.campaign_outlined,
                  title: "Notices",
                ),

                const SizedBox(height: 20),

                // =========================
                // REWARDS
                // =========================
                _sectionTitle("REWARDS"),

                _menuItem(
                  index: 11,
                  icon: Icons.emoji_events_outlined,
                  title: "School Rewards",
                ),

                _menuItem(
                  index: 12,
                  icon: Icons.star_outline,
                  title: "CamNex Rewards",
                ),

                const SizedBox(height: 20),

                // =========================
                // SETTINGS
                // =========================
                _sectionTitle("SETTINGS"),

                _menuItem(
                  index: 13,
                  icon: Icons.settings_outlined,
                  title: "Settings",
                ),

                _menuItem(
                  index: 14,
                  icon: Icons.logout,
                  title: "Logout",
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //==================================================
  // CAMNEX LOGO
  //==================================================

  Widget _buildLogo() {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.school_outlined,
              color: AppTheme.primaryBlue,
              size: 28,
            ),
          ),

          const SizedBox(width: 10),

          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Cam",
                  style: TextStyle(
                    color: AppTheme.primaryBlue,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: "Nex",
                  style: TextStyle(
                    color: AppTheme.primaryOrange,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //==================================================
  // SECTION TITLE
  //==================================================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        bottom: 8,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppTheme.textSecondary,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  //==================================================
  // MENU ITEM
  //==================================================

  Widget _menuItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () => onItemSelected(index),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightBlue
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 21,
              color: isSelected
                  ? AppTheme.primaryBlue
                  : AppTheme.textPrimary,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: isSelected
                      ? AppTheme.primaryBlue
                      : AppTheme.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}