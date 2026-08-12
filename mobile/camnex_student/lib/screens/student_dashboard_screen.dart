import 'package:flutter/material.dart';

import 'class_screen.dart';
import 'card_screen.dart';
import 'attendance_screen.dart';
import 'homework_screen.dart';
import 'student_parent_teacher_remarks_screen.dart';
import 'library_screen.dart';
import 'canteen_screen.dart';
import 'transport_screen.dart';
import 'notice_screen.dart';
import 'school_rewards_screen.dart';
import 'camnex_rewards_screen.dart';
import 'settings_screen.dart';

import '../widgets/student_sidebar.dart';
import '../widgets/student_header.dart';
import '../widgets/student_dashboard_content.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

 @override
  State<StudentDashboardScreen> createState() =>
      _StudentDashboardScreenState();
}

class _StudentDashboardScreenState
    extends State<StudentDashboardScreen> {
  int selectedIndex = 0;

  void _onMenuSelected(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      // Home
      case 0:
        break;

      // Attendance
      case 1:
              Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AttendanceScreen(),
        ),
      );
      break;

    // Homework
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeworkScreen(
  isStudent: true,
),
        ),
      );
      break;

    // Exam Results
    case 3:
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Exam Results coming soon."),
        ),
      );
      break;

      // Teacher Remarks
      case 4:
 Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const TeacherRemarksScreen(),
    ),
  );
  break;

      // My Class
case 5:
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const ClassScreen(),
    ),
  );
  break;

     // Smart Card
    case 6:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CardScreen(
  isStudent: true,
),
        ),
      );
      break;

    // Library
    case 7:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LibraryScreen(),
        ),
      );
      break;

      // Canteen
      case 8:
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CanteenScreen(),
        ),
      );
      break;

    // Transport
    case 9:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TransportScreen(),
        ),
      );
      break;

    // Notices
    case 10:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const NoticeScreen(),
        ),
      );
      break;

      // School Rewards
      case 11:
             Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SchoolRewardsScreen(),
        ),
      );
      break;

    // CamNex Rewards
    case 12:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CamnexRewardsScreen(),
        ),
      );
      break;

    // Settings
    case 13:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        ),
      );
      break;

      // Logout
      case 14:
        _showLogoutDialog();
        break;
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text(
          "Are you sure you want to logout?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              Navigator.pop(context);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          StudentSidebar(
            selectedIndex: selectedIndex,
            onItemSelected: _onMenuSelected,
          ),

          Expanded(
            child: Column(
              children: [
                StudentHeader(
  schoolName: "Bright Future School",
  studentName: "Rahul Sharma",
  onNotificationTap: () {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "You have 2 new notifications",
        ),
      ),
    );
  },
),

                const Expanded(
                  child: StudentDashboardContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}