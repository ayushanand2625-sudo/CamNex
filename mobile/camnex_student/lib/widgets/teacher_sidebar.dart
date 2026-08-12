import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TeacherSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const TeacherSidebar({
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
          //============================================
          // LOGO
          //============================================

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
                // =========================
                // HOME
                // =========================

                _sectionTitle("HOME"),

                _menuItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  title: "Teacher Dashboard",
                ),

                const SizedBox(height: 20),

                // =========================
                // ACADEMICS
                // =========================

                _sectionTitle("ACADEMICS"),

                _menuItem(
                  index: 1,
                  icon: Icons.groups_outlined,
                  title: "Class Hub",
                ),

                _menuItem(
                  index: 2,
                  icon: Icons.menu_book_outlined,
                  title: "Homework",
                ),

                _menuItem(
                  index: 3,
                  icon: Icons.fact_check_outlined,
                  title: "Attendance",
                ),

                _menuItem(
                  index: 4,
                  icon: Icons.assignment_outlined,
                  title: "Exam Results",
                ),

                const SizedBox(height: 20),

                // =========================
                // COMMUNICATION
                // =========================

                _sectionTitle("COMMUNICATION"),

                _menuItem(
                  index: 5,
                  icon: Icons.rate_review_outlined,
                  title: "Teacher Remarks",
                ),

                _menuItem(
                  index: 6,
                  icon: Icons.campaign_outlined,
                  title: "Class Notices",
                ),

                _menuItem(
                  index: 7,
                  icon: Icons.forum_outlined,
                  title: "Parent Messages",
                ),

                // NEW TEACHER HUB
                _menuItem(
                  index: 8,
                  icon: Icons.hub_outlined,
                  title: "Teacher Hub",
                ),

                _menuItem(
                  index: 9,
                  icon: Icons.groups_2_outlined,
                  title: "Teacher Group",
                ),

                const SizedBox(height: 20),

                // =========================
                // ACCOUNT
                // =========================

                _sectionTitle("ACCOUNT"),

                _menuItem(
                  index: 10,
                  icon: Icons.person_outline,
                  title: "Profile",
                ),

                _menuItem(
                  index: 11,
                  icon: Icons.settings_outlined,
                  title: "Settings",
                ),

                const SizedBox(height: 20),

                // =========================
                // LOGOUT
                // =========================

                _menuItem(
                  index: 12,
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

  //=================================================
  // CAMNEX LOGO
  //=================================================

  Widget _buildLogo() {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
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

  //=================================================
  // TEACHER PROFILE CARD
  //=================================================

  Widget _teacherCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.lightBlue,
            child: const Icon(
              Icons.person_outline,
              color: AppTheme.primaryBlue,
              size: 26,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Mr. Rajesh Kumar",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "Mathematics Teacher",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  "Class Teacher • 10-A",
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //=================================================
  // SECTION TITLE
  //=================================================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        bottom: 10,
        top: 6,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: AppTheme.textSecondary,
        ),
      ),
    );
  }

  //=================================================
  // SIDEBAR MENU ITEM
  //=================================================

  Widget _menuItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final bool isSelected = selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 6,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onItemSelected(index),
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 220,
          ),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
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
                size: 22,
                color: isSelected
                    ? AppTheme.primaryBlue
                    : AppTheme.textSecondary,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: isSelected
                        ? AppTheme.primaryBlue
                        : AppTheme.textPrimary,
                  ),
                ),
              ),

              if (isSelected)
                Container(
                  width: 5,
                  height: 26,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryOrange,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}