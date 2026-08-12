import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import '../widgets/parent_dashboard_content.dart';
import '../widgets/parent_header.dart';
import '../widgets/parent_sidebar.dart';

import 'Card_screen.dart';
import 'online_transactions_screen.dart';
import 'fee_payment_screen.dart';
import 'conversations_screen.dart';
import 'attendance_screen.dart';
import 'homework_screen.dart';
import '../data/homework_data.dart';
import 'student_parent_teacher_remarks_screen.dart';
import '../screens/library_screen.dart';
import '../screens/canteen_screen.dart';
import '../screens/transport_screen.dart';
import '../screens/notice_screen.dart';
import '../screens/school_rewards_screen.dart';
import '../screens/camnex_rewards_screen.dart';
import '../screens/settings_screen.dart';


class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() =>
      _ParentDashboardScreenState();
}

class _ParentDashboardScreenState
    extends State<ParentDashboardScreen> {
  int selectedIndex = 0;

  void _handleSidebarSelection(int index) {
    if (index == 16) {
      _showLogoutDialog();
      return;
    }

    setState(() {
      selectedIndex = index;
    });

    final student =
        context.read<StudentProvider>().selectedStudent;
        final pendingHomework = homeworkList
    .where((hw) => hw.status == "Pending")
    .length;
        

switch (index) {
  // Dashboard
  case 0:
    return;

  // Smart Card
  case 1:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>const CardScreen(
  isStudent: false,
),
      ),
    );
    break;

  // Online Transactions
  case 2:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const OnlineTransactionsScreen(),
      ),
    );
    break;

  // Fee Payment
  case 3:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const FeePaymentScreen(),
      ),
    );
    break;

  // Attendance
  case 4:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AttendanceScreen(),
      ),
    );
    break;
    // Homework
// Homework
case 5:
  Navigator.push(
    context,
    MaterialPageRoute(
     builder: (_) => const HomeworkScreen(
  isStudent: false,
),
    ),
  );
  break;

// Teacher Remarks
case 7:
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const TeacherRemarksScreen(),
    ),
  );
  break;

  // Conversations
  case 8:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConversationsScreen(
          studentName: student.name,
        ),
      ),
    );
    break;

case 9:
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const LibraryScreen(),
    ),
  );
  break;

  case 10:
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const CanteenScreen(),
    ),
  );
  break;
  case 11:
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const TransportScreen(),
    ),
  );
  break;
 
  case 12:
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const NoticeScreen(),
    ),
  );
  break;

  case 13:
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const SchoolRewardsScreen(),
    ),
  );
  break;

  case 14:
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const CamnexRewardsScreen(),
    ),
  );
  break;

  case 15:
 Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SettingsScreen(),
  ),
);
break;

  default:
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "This screen will be available soon.",
        ),
      ),
    );
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

              ScaffoldMessenger.of(context)
                  .showSnackBar(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ParentSidebar(
            selectedIndex: selectedIndex,
            onItemSelected: _handleSidebarSelection,
          ),
          Expanded(
            child: Column(
              children: [
                ParentHeader(
                  parentName: 'Mr. Sharma',
                  onNotificationTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'You have 3 new notifications',
                        ),
                      ),
                    );
                  },
                ),
                const Expanded(
                  child: ParentDashboardContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}