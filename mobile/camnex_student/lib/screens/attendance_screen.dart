import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/attendance_data.dart';
import '../providers/student_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/attendance_details_dialog.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student = context.watch<StudentProvider>().selectedStudent;

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.darkBlue,
        title: const Text(
          "Attendance",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final horizontalPadding = isMobile ? 16.0 : 28.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                20,
                horizontalPadding,
                35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =====================================================
                  // PAGE HEADER
                  // =====================================================

                  _buildPageHeader(
                    context,
                    student.name,
                    student.studentClass,
                    isMobile,
                  ),

                  const SizedBox(height: 22),

                  // =====================================================
                  // STUDENT INFORMATION
                  // =====================================================

                  _buildStudentInfoCard(
                    context,
                    student.name,
                    student.studentClass,
                    isMobile,
                  ),

                  const SizedBox(height: 28),

                  // =====================================================
                  // ATTENDANCE SUMMARY
                  // =====================================================

                  _buildSectionTitle(
                    "Attendance Summary",
                    "Your overall attendance performance",
                  ),

                  const SizedBox(height: 16),

                  _buildSummaryGrid(
                    context,
                    isMobile,
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // MONTHLY ATTENDANCE
                  // =====================================================

                  _buildSectionTitle(
                    "Monthly Attendance",
                    "View your attendance month by month",
                  ),

                  const SizedBox(height: 16),

                  _buildMonthlyAttendanceCard(
                    context,
                    isMobile,
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // OVERALL PROGRESS
                  // =====================================================

                  _buildSectionTitle(
                    "Overall Attendance Progress",
                    "Your attendance performance for the academic year",
                  ),

                  const SizedBox(height: 16),

                  _buildOverallProgressCard(
                    context,
                    isMobile,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ================================================================
  // PAGE HEADER
  // ================================================================

  Widget _buildPageHeader(
    BuildContext context,
    String studentName,
    String studentClass,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Attendance",
          style: TextStyle(
            fontSize: isMobile ? 25 : 30,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkBlue,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          "Track your attendance and monthly performance",
          style: TextStyle(
            fontSize: isMobile ? 13 : 15,
            color: AppTheme.textSecondary,
          ),
        ),

        const SizedBox(height: 14),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppTheme.lightBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.person_outline,
                size: 17,
                color: AppTheme.primaryBlue,
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  "$studentName • $studentClass",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================================================================
  // STUDENT INFORMATION CARD
  // ================================================================

  Widget _buildStudentInfoCard(
    BuildContext context,
    String studentName,
    String studentClass,
    bool isMobile,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              children: [
                _studentInfo(
                  "Student",
                  studentName,
                  icon: Icons.person_outline,
                ),
                const Divider(height: 24),
                _studentInfo(
                  "Class",
                  studentClass,
                  icon: Icons.school_outlined,
                ),
                const Divider(height: 24),
                _studentInfo(
                  "Academic Year",
                  "2026-2027",
                  icon: Icons.calendar_month_outlined,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _studentInfo(
                    "Student",
                    studentName,
                    icon: Icons.person_outline,
                  ),
                ),
                _verticalDivider(),
                Expanded(
                  child: _studentInfo(
                    "Class",
                    studentClass,
                    icon: Icons.school_outlined,
                  ),
                ),
                _verticalDivider(),
                Expanded(
                  child: _studentInfo(
                    "Academic Year",
                    "2026-2027",
                    icon: Icons.calendar_month_outlined,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: AppTheme.border,
    );
  }

  // ================================================================
  // SECTION TITLE
  // ================================================================

  Widget _buildSectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkBlue,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  // ================================================================
  // SUMMARY GRID
  // ================================================================

  Widget _buildSummaryGrid(
    BuildContext context,
    bool isMobile,
  ) {
    final cards = [
      _SummaryData(
        icon: Icons.check_circle_outline,
        color: Colors.green,
        title: "Present",
        value: "144 Days",
        subtitle: "Days attended",
      ),
      _SummaryData(
        icon: Icons.cancel_outlined,
        color: Colors.red,
        title: "Absent",
        value: "6 Days",
        subtitle: "Days missed",
      ),
      _SummaryData(
        icon: Icons.menu_book_outlined,
        color: Colors.orange,
        title: "Total Classes",
        value: "150",
        subtitle: "Working days",
      ),
      _SummaryData(
        icon: Icons.show_chart,
        color: AppTheme.primaryBlue,
        title: "Attendance",
        value: "96%",
        subtitle: "Overall percentage",
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int columns;

        if (width >= 1000) {
          columns = 4;
        } else if (width >= 600) {
          columns = 2;
        } else {
          columns = 1;
        }

        final cardWidth =
            (width - ((columns - 1) * 14)) / columns;

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: cards.map((data) {
            return SizedBox(
              width: cardWidth,
              child: _summaryCard(
                data.icon,
                data.color,
                data.title,
                data.value,
                data.subtitle,
                isMobile,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // ================================================================
  // SUMMARY CARD
  // ================================================================

  Widget _summaryCard(
    IconData icon,
    Color color,
    String title,
    String value,
    String subtitle,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 17 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: AppTheme.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isMobile ? 48 : 52,
            height: isMobile ? 48 : 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .11),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: isMobile ? 24 : 27,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isMobile ? 21 : 23,
                    color: color,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // MONTHLY ATTENDANCE
  // ================================================================

  Widget _buildMonthlyAttendanceCard(
    BuildContext context,
    bool isMobile,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          if (!isMobile) _buildDesktopTableHeader(),

          ...monthlyAttendance.map(
            (month) {
              if (isMobile) {
                return _buildMobileMonthCard(
                  context,
                  month,
                );
              }

              return _buildDesktopMonthRow(
                context,
                month,
              );
            },
          ),
        ],
      ),
    );
  }

  // ================================================================
  // DESKTOP TABLE HEADER
  // ================================================================

  Widget _buildDesktopTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffF5F7FA),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "Month",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Working Days",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Attendance",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Details",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // DESKTOP MONTH ROW
  // ================================================================

  Widget _buildDesktopMonthRow(
    BuildContext context,
    dynamic month,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.border,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                _monthIcon(),
                const SizedBox(width: 10),
                Text(
                  month.month,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 3,
            child: Text(
              "${month.workingDays} Working Days",
              style: const TextStyle(
                color: AppTheme.textSecondary,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: _percentageBadge(
              month.percentage,
            ),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  showAttendanceDetails(
                    context,
                    month,
                  );
                },
                child: const Text(
                  "View Details",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // MOBILE MONTH CARD
  // ================================================================

  Widget _buildMobileMonthCard(
    BuildContext context,
    dynamic month,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xffFAFBFD),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _monthIcon(),

              const SizedBox(width: 11),

              Expanded(
                child: Text(
                  month.month,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),

              _percentageBadge(
                month.percentage,
              ),
            ],
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              const Icon(
                Icons.event_available_outlined,
                size: 17,
                color: AppTheme.textSecondary,
              ),

              const SizedBox(width: 7),

              Expanded(
                child: Text(
                  "${month.workingDays} Working Days",
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  showAttendanceDetails(
                    context,
                    month,
                  );
                },
                child: const Text(
                  "View Details",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================================================================
  // MONTH ICON
  // ================================================================

  Widget _monthIcon() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppTheme.lightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.calendar_month_outlined,
        size: 20,
        color: AppTheme.primaryBlue,
      ),
    );
  }

  // ================================================================
  // PERCENTAGE BADGE
  // ================================================================

  Widget _percentageBadge(double percentage) {
    final isGood = percentage >= 75;

    final color = isGood
        ? Colors.green
        : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "${percentage.toStringAsFixed(0)}%",
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  // ================================================================
  // OVERALL PROGRESS
  // ================================================================

  Widget _buildOverallProgressCard(
    BuildContext context,
    bool isMobile,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 20 : 28,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: isMobile ? 92 : 105,
            height: isMobile ? 92 : 105,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.withValues(alpha: .08),
              border: Border.all(
                color: Colors.green.withValues(alpha: .25),
                width: 7,
              ),
            ),
            child: Center(
              child: Text(
                "96%",
                style: TextStyle(
                  fontSize: isMobile ? 25 : 29,
                  fontWeight: FontWeight.w800,
                  color: Colors.green,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "Excellent Attendance 🎉",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            "You are maintaining an excellent attendance record.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),

          const SizedBox(height: 22),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: .96,
              minHeight: 12,
            ),
          ),

          const SizedBox(height: 10),

          const Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0%",
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                "96% Attendance",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                "100%",
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================================================================
  // STUDENT INFO ITEM
  // ================================================================

  Widget _studentInfo(
    String title,
    String value, {
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.lightBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppTheme.primaryBlue,
          ),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==================================================================
// SUMMARY DATA MODEL
// ==================================================================

class _SummaryData {
  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final String subtitle;

  const _SummaryData({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.subtitle,
  });
}