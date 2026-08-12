import 'package:camnex_student/screens/student_parent_teacher_remarks_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import '../theme/app_theme.dart';

import 'parent_dashboard_card.dart';
import 'parent_recent_transactions.dart';
import 'parent_teacher_remarks.dart';
import 'school_notices.dart';
import 'parent_remarks.dart';

import '../screens/recharge_screen.dart';
import '../screens/fee_payment_screen.dart';
import '../screens/attendance_screen.dart';
import '../screens/homework_screen.dart';
import '../data/homework_data.dart';
import '../screens/notice_screen.dart';
import '../screens/transaction_screen.dart';

class ParentDashboardContent extends StatelessWidget {
  const ParentDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    final pendingHomework = homeworkList
        .where((hw) => hw.status == "Pending")
        .length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final bool isMobile = width < 600;
        final bool isTablet = width >= 600 && width < 1000;
        final bool isDesktop = width >= 1000;

        final double horizontalPadding = isMobile
            ? 16
            : isTablet
                ? 22
                : 30;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            isMobile ? 20 : 30,
            horizontalPadding,
            30,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // =====================================================
              // WELCOME SECTION
              // =====================================================

              _buildWelcomeSection(
                isMobile: isMobile,
              ),

              SizedBox(
                height: isMobile ? 18 : 28,
              ),

              // =====================================================
              // CURRENT STUDENT
              // =====================================================

              _buildCurrentStudent(
                student: student,
                isMobile: isMobile,
              ),

              SizedBox(
                height: isMobile ? 20 : 28,
              ),

              // =====================================================
              // DASHBOARD CARDS
              // =====================================================

              _buildDashboardCards(
                context: context,
                student: student,
                pendingHomework: pendingHomework,
                width: width,
                isMobile: isMobile,
                isTablet: isTablet,
              ),

              SizedBox(
                height: isMobile ? 20 : 25,
              ),

              // =====================================================
              // TRANSACTIONS + TEACHER REMARKS
              // =====================================================

              _buildTransactionsAndRemarks(
                context: context,
                student: student,
                isMobile: isMobile,
              ),

              SizedBox(
                height: isMobile ? 20 : 25,
              ),

              // =====================================================
              // NOTICES + PARENT REMARKS
              // =====================================================

              _buildNoticesAndRemarks(
                context: context,
                student: student,
                isMobile: isMobile,
              ),
            ],
          ),
        );
      },
    );
  }

  // ===============================================================
  // WELCOME
  // ===============================================================

  Widget _buildWelcomeSection({
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Text(
          'Welcome, Mr. Sharma',
          style: TextStyle(
            fontSize: isMobile ? 24 : 30,
            fontWeight: FontWeight.w700,
            color: AppTheme.darkBlue,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          'Here is an overview of your child\'s academic activity.',
          style: TextStyle(
            fontSize: isMobile ? 13 : 15,
            color: AppTheme.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // CURRENT STUDENT
  // ===============================================================

  Widget _buildCurrentStudent({
    required dynamic student,
    required bool isMobile,
  }) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(
        isMobile ? 14 : 18,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
            width: isMobile ? 42 : 48,
            height: isMobile ? 42 : 48,

            decoration: BoxDecoration(
              color: AppTheme.lightBlue,
              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Icon(
              Icons.person_outline,
              color: AppTheme.primaryBlue,
              size: isMobile ? 22 : 25,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  'Currently Viewing',
                  style: TextStyle(
                    fontSize:
                        isMobile ? 12 : 13,
                    color:
                        AppTheme.textSecondary,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '${student.name} (${student.studentClass})',
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:
                        isMobile ? 14 : 15,
                    fontWeight:
                        FontWeight.w700,
                    color:
                        AppTheme.textPrimary,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Admission No. ${student.admissionNo}',
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:
                        isMobile ? 12 : 13,
                    color:
                        AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          const Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.textSecondary,
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // DASHBOARD CARDS
  // ===============================================================

  Widget _buildDashboardCards({
    required BuildContext context,
    required dynamic student,
    required int pendingHomework,
    required double width,
    required bool isMobile,
    required bool isTablet,
  }) {
    final cards = [

      ParentDashboardCard(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Card Balance',
        value:
            '₹${student.cardBalance.toStringAsFixed(2)}',
        buttonText: 'Recharge Card',

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const RechargeScreen(),
            ),
          );
        },
      ),

      ParentDashboardCard(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Fee Due',
        value: '₹4,200.00',
        buttonText: 'Pay Now',

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const FeePaymentScreen(),
            ),
          );
        },
      ),

      ParentDashboardCard(
        icon: Icons.calendar_month_outlined,
        title: 'Attendance',
        value:
            '${student.attendance.toStringAsFixed(0)}%',
        buttonText: 'View Details',

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AttendanceScreen(),
            ),
          );
        },
      ),

      ParentDashboardCard(
        icon: Icons.menu_book_outlined,
        title: 'Homework',
        value: pendingHomework == 0
            ? 'No Pending Homework'
            : '$pendingHomework Pending',
        buttonText: 'View Homework',

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const HomeworkScreen(
                isStudent: false,
              ),
            ),
          );
        },
      ),
    ];

    // ============================================================
    // MOBILE
    // ============================================================

    if (isMobile) {
      return Column(
        children: cards
            .map(
              (card) => Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 14,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: card,
                ),
              ),
            )
            .toList(),
      );
    }

    // ============================================================
    // TABLET / DESKTOP
    // ============================================================

    final int columns = width >= 1200 ? 4 : 2;

    return GridView.builder(
      shrinkWrap: true,

      physics:
          const NeverScrollableScrollPhysics(),

      itemCount: cards.length,

      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,

        crossAxisSpacing: 16,
        mainAxisSpacing: 16,

        mainAxisExtent:
            width >= 1200 ? 190 : 200,
      ),

      itemBuilder: (context, index) {
        return cards[index];
      },
    );
  }

  // ===============================================================
  // TRANSACTIONS + TEACHER REMARKS
  // ===============================================================

  Widget _buildTransactionsAndRemarks({
    required BuildContext context,
    required dynamic student,
    required bool isMobile,
  }) {
    final transactions =
        ParentRecentTransactions(
      onViewAll: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                TransactionScreen(
              studentName: student.name,
              studentClass:
                  student.studentClass,
            ),
          ),
        );
      },
    );

    final remarks =
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
    );

    if (isMobile) {
      return Column(
        children: [
          transactions,

          const SizedBox(height: 16),

          remarks,
        ],
      );
    }

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Expanded(
          child: transactions,
        ),

        const SizedBox(width: 18),

        Expanded(
          child: remarks,
        ),
      ],
    );
  }

  // ===============================================================
  // NOTICES + PARENT REMARKS
  // ===============================================================

  Widget _buildNoticesAndRemarks({
    required BuildContext context,
    required dynamic student,
    required bool isMobile,
  }) {
    final notices =
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
    );

    final remarks =
        ParentRemarks(
      studentName: student.name,
    );

    if (isMobile) {
      return Column(
        children: [

          notices,

          const SizedBox(height: 16),

          remarks,
        ],
      );
    }

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Expanded(
          child: notices,
        ),

        const SizedBox(width: 18),

        Expanded(
          child: remarks,
        ),
      ],
    );
  }
}