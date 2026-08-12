import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';
import '../providers/student_provider.dart';
import '../theme/app_theme.dart';

import '../widgets/parent_dashboard_card.dart';
import '../widgets/parent_recent_transactions.dart';
import '../widgets/parent_teacher_remarks.dart';
import '../widgets/school_notices.dart';

import '../screens/card_screen.dart';
import '../screens/homework_screen.dart';
import '../screens/attendance_screen.dart';
import '../screens/student_parent_teacher_remarks_screen.dart';
import '../screens/notice_screen.dart';
import '../screens/transaction_screen.dart';

import '../data/homework_data.dart';

class StudentDashboardContent extends StatelessWidget {
  const StudentDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    final pendingHomework = homeworkList
        .where((hw) => hw.status == "Pending")
        .length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Welcome, Ayush Kumar",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppTheme.darkBlue,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [

              const Text(
                "Currently Viewing: ",
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.textSecondary,
                ),
              ),

              Text(
                '${student.name} (${student.studentClass}) • Admission No. ${student.admissionNo}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),

              const SizedBox(width: 5),

              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              ),

            ],
          ),

          const SizedBox(height: 28),

          // ==========================
          // SMART CARD + HOMEWORK
          // ==========================

          LayoutBuilder(
            builder: (context, constraints) {

              int crossAxisCount =
                  constraints.maxWidth >= 750 ? 2 : 1;

              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.8,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                children: [

                  ParentDashboardCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: "Smart Card",
                    value:
                        "₹${student.cardBalance.toStringAsFixed(2)}",
                    buttonText: "View Card",
                    onTap: () {
                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const CardScreen(
      isStudent: true,
    ),
  ),
);
                    },
                  ),

                  ParentDashboardCard(
                    icon: Icons.menu_book_outlined,
                    title: "Homework",
                    value: pendingHomework == 0
                        ? "No Pending Homework"
                        : "$pendingHomework Pending",
                    buttonText: "View Homework",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                             const HomeworkScreen(
  isStudent: true,
),
                        ),
                      );
                    },
                  ),

                ],
              );
            },
          ),

          const SizedBox(height: 25),

          // ==========================
          // TRANSACTIONS + REMARKS
          // ==========================

          LayoutBuilder(
            builder: (context, constraints) {

              if (constraints.maxWidth < 800) {
                return Column(
                  children: [

                    ParentRecentTransactions(
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TransactionScreen(
                              studentName:
                                  student.name,
                              studentClass:
                                  student.studentClass,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    ParentTeacherRemarks(
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const TeacherRemarksScreen(),
                          ),
                        );
                      },
                    ),

                  ],
                );
              }

              return Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: ParentRecentTransactions(
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TransactionScreen(
                              studentName:
                                  student.name,
                              studentClass:
                                  student.studentClass,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: ParentTeacherRemarks(
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const TeacherRemarksScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              );
            },
          ),

          const SizedBox(height: 20),

          // ==========================
          // NOTICES + ATTENDANCE
          // ==========================

          LayoutBuilder(
            builder: (context, constraints) {

              if (constraints.maxWidth < 800) {
                return Column(
                  children: [

                    ParentNotices(
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const NoticeScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    _attendanceCard(
                      context,
                      student,
                    ),

                  ],
                );
              }

              return Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: ParentNotices(
                      onViewAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const NoticeScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: _attendanceCard(
                      context,
                      student,
                    ),
                  ),

                ],
              );
            },
          ),
                  ],
      ),
    );
  }

  // ========================================
  // ATTENDANCE CARD
  // ========================================

  Widget _attendanceCard(
    BuildContext context,
    Student student,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppTheme.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.lightBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: AppTheme.primaryBlue,
                  size: 27,
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Text(
                  "Attendance",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              "${student.attendance.toStringAsFixed(0)}%",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryBlue,
              ),
            ),
          ),

          const SizedBox(height: 4),

          const Center(
            child: Text(
              "Present",
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 42,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primaryBlue,
                side: BorderSide(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.20),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AttendanceScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "View Details",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}