import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../providers/student_provider.dart';
import '../models/student.dart';
import '../data/student_data.dart';

class ParentSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const ParentSidebar({
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
          // ============================================
          // LOGO
          // ============================================
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
                _sectionTitle('HOME'),

                _menuItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  title: 'Parent Dashboard',
                ),

                const SizedBox(height: 20),

                // ============================================
                // STUDENT SELECTOR
                // ============================================
                _studentSelector(),

                const SizedBox(height: 24),

                // ============================================
                // FINANCE
                // ============================================
                _sectionTitle('FINANCE'),

                _menuItem(
                  index: 1,
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Smart Card',
                ),

                _menuItem(
                  index: 2,
                  icon: Icons.receipt_long_outlined,
                  title: 'Online Transactions',
                ),

                _menuItem(
  index: 3,
  icon: Icons.currency_rupee,
  title: 'Fee Payment',
),


                const SizedBox(height: 20),

                // ============================================
                // ACADEMICS
                // ============================================
                _sectionTitle('ACADEMICS'),

                _menuItem(
  index: 4,
  icon: Icons.calendar_month_outlined,
  title: 'Attendance',
),

_menuItem(
  index: 5,
  icon: Icons.menu_book_outlined,
  title: 'Homework',
),

_menuItem(
  index: 6,
  icon: Icons.workspace_premium_outlined,
  title: 'Exam Results',
),

_menuItem(
  index: 7,
  icon: Icons.chat_bubble_outline,
  title: 'Teacher Remarks',
),
                const SizedBox(height: 20),

                // ============================================
                // COMMUNICATION
                // ============================================
                _sectionTitle('COMMUNICATION'),

               _menuItem(
  index: 8,
  icon: Icons.forum_outlined,
  title: 'Conversations',
),

                const SizedBox(height: 20),

                // ============================================
                // SERVICES
                // ============================================
                _sectionTitle('SERVICES'),

                _menuItem(
  index: 9,
  icon: Icons.local_library_outlined,
  title: 'Library',
),

_menuItem(
  index: 10,
  icon: Icons.restaurant_outlined,
  title: 'Canteen',
),

_menuItem(
  index: 11,
  icon: Icons.directions_bus_outlined,
  title: 'Transport',
),

_menuItem(
  index: 12,
  icon: Icons.campaign_outlined,
  title: 'Notices',
),

                const SizedBox(height: 20),

                // ============================================
                // REWARDS
                // ============================================
                _sectionTitle('REWARDS'),

                _menuItem(
  index: 13,
  icon: Icons.emoji_events_outlined,
  title: 'School Rewards',
),

_menuItem(
  index: 14,
  icon: Icons.star_outline,
  title: 'CamNex Rewards',
),

                const SizedBox(height: 20),

                // ============================================
                // SETTINGS
                // ============================================
                _sectionTitle('SETTINGS'),

               _menuItem(
  index: 15,
  icon: Icons.settings_outlined,
  title: 'Settings',
),

_menuItem(
  index: 16,
  icon: Icons.logout,
  title: 'Logout',
),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // CAMNEX LOGO
  // ============================================

  Widget _buildLogo() {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          // Logo Icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.analytics_outlined,
              color: AppTheme.primaryBlue,
              size: 28,
            ),
          ),

          const SizedBox(width: 10),

          // CamNex Text
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Cam',
                  style: TextStyle(
                    color:
                        AppTheme.primaryBlue,
                    fontSize: 25,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                TextSpan(
                  text: 'Nex',
                  style: TextStyle(
                    color:
                        AppTheme.primaryOrange,
                    fontSize: 25,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // SECTION TITLE
  // ============================================

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

  // ============================================
  // MENU ITEM
  // ============================================

  Widget _menuItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final bool isSelected =
        selectedIndex == index;

    return InkWell(
      onTap: () =>
          onItemSelected(index),

      borderRadius:
          BorderRadius.circular(10),

      child: Container(
        margin:
            const EdgeInsets.only(
          bottom: 4,
        ),

        padding:
            const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),

        decoration:
            BoxDecoration(
          // BLUE ACTIVE BACKGROUND
          color: isSelected
              ? AppTheme.lightBlue
              : Colors.transparent,

          borderRadius:
              BorderRadius.circular(10),
        ),

        child: Row(
          children: [
            Icon(
              icon,
              size: 21,

              // BLUE ACTIVE ICON
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

                  fontWeight:
                      isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,

                  // BLUE ACTIVE TEXT
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

  // ============================================
  // STUDENT SELECTOR
  // ============================================

 Widget _studentSelector() {
  return Consumer<StudentProvider>(
    builder: (context, provider, child) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: List.generate(
            students.length,
            (index) {
              final student = students[index];

              return Column(
                children: [
                  _studentTile(student),
                  if (index != students.length - 1)
                    const Divider(
                      height: 1,
                      color: AppTheme.border,
                    ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}

  // ============================================
  // STUDENT TILE
  // ============================================

  Widget _studentTile(Student student) {
  return Consumer<StudentProvider>(
    builder: (context, provider, child) {

      final bool isSelected =
          provider.selectedStudent.id == student.id;

      return InkWell(
        onTap: () {

          context
              .read<StudentProvider>()
              .selectStudent(student);

        },

        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.lightBlue.withOpacity(.15)
                : Colors.white,
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),

          child: Row(
            children: [

              CircleAvatar(
                radius: 17,

                backgroundColor: isSelected
                    ? AppTheme.primaryBlue
                    : AppTheme.lightBlue,

                child: Icon(
                  Icons.person_outline,
                  color: isSelected
                      ? Colors.white
                      : AppTheme.primaryBlue,
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      student.name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w600,
                        color: isSelected
                            ? AppTheme.primaryBlue
                            : AppTheme.textPrimary,
                      ),
                    ),

                    Text(
                      student.studentClass,
                      style: const TextStyle(
                        fontSize: 11,
                        color:
                            AppTheme.textSecondary,
                      ),
                    ),

                  ],
                ),
              ),

              Icon(
                Icons.check_circle,
                color: isSelected
                    ? AppTheme.primaryBlue
                    : Colors.transparent,
              ),

            ],
          ),
        ),
      );
    },
  );
}
}
