import 'package:flutter/material.dart';

import '../widgets/teacher_sidebar.dart';
import '../widgets/teacher_header.dart';
import '../widgets/teacher_dashboard_content.dart';

// Screens
import 'teacher_class_hub_screen.dart';
import 'teacher_homework_screen.dart';
import 'teacher_students_attendance_screen.dart';
import 'teacher_exam_results_screen.dart';
import 'teacher_remarks_screen.dart';
import 'teacher_notice_screen.dart';
import 'teacher_parent_messages_screen.dart';
import 'teacher_hub_screen.dart';
import 'teacher_group_screen.dart';
import 'teacher_profile_screen.dart';
import 'settings_screen.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() =>
      _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState
    extends State<TeacherDashboardScreen> {
  int selectedIndex = 0;

  void _handleSidebarSelection(int index) {
    // Logout
    if (index == 12) {
      _showLogoutDialog();
      return;
    }

    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      // =====================================================
      // DASHBOARD
      // =====================================================

      case 0:
        return;

      // =====================================================
      // MY CLASSES
      // =====================================================

      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherClassHubScreen(),
          ),
        );
        break;

      // =====================================================
      // HOMEWORK
      // =====================================================

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherHomeworkScreen(),
          ),
        );
        break;

      // =====================================================
      // ATTENDANCE
      // =====================================================

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherAttendanceScreen(),
          ),
        );
        break;

      // =====================================================
      // EXAM RESULTS
      // =====================================================

      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherExamResultsScreen(),
          ),
        );
        break;

      // =====================================================
      // TEACHER REMARKS
      // =====================================================

      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherRemarksScreen(),
          ),
        );
        break;

      // =====================================================
      // COMMUNICATION
      // =====================================================

      // Notice
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherNoticeScreen(),
          ),
        );
        break;

      // Parent Messages
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const TeacherParentMessagesScreen(),
          ),
        );
        break;

      // =====================================================
      // TEACHER HUB
      // =====================================================

      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherHubScreen(),
          ),
        );
        break;

      // =====================================================
      // TEACHER GROUP
      // =====================================================

      case 9:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherGroupScreen(),
          ),
        );
        break;

      // =====================================================
      // PROFILE
      // =====================================================

      case 10:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const TeacherProfileScreen(
              name: "Rahul Sharma",
              subject: "Senior Mathematics Teacher",
              degree: "M.Sc. Mathematics, B.Ed.",
            ),
          ),
        );
        break;

      // =====================================================
      // SETTINGS
      // =====================================================

      case 11:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SettingsScreen(),
          ),
        );
        break;

      // =====================================================
      // DEFAULT
      // =====================================================

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "This feature will be available soon.",
            ),
          ),
        );
    }
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text(
          "Are you sure you want to logout?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Logged out successfully",
                  ),
                ),
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ===================================================
          // SIDEBAR
          // ===================================================

          TeacherSidebar(
            selectedIndex: selectedIndex,
            onItemSelected: _handleSidebarSelection,
          ),

          // ===================================================
          // MAIN CONTENT
          // ===================================================

          Expanded(
            child: Column(
              children: [
                // =============================================
                // HEADER
                // =============================================

                TeacherHeader(
                  schoolName: "Bright Future School",
                  teacherName: "Rahul Sharma",

                  onNotificationTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "You have 5 new notifications",
                        ),
                      ),
                    );
                  },

                  onCalendarTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Calendar Opened",
                        ),
                      ),
                    );
                  },
                ),

                // =============================================
                // DASHBOARD CONTENT
                // =============================================

                const Expanded(
                  child: TeacherDashboardContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}