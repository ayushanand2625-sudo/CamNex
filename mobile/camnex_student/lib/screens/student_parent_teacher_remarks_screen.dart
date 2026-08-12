import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/student_parent_teacher_remarks_data.dart';
import '../models/student_parent_teacher_remarks.dart';
import '../providers/student_provider.dart';
import '../widgets/student_parent_teacher_remarks_list_card.dart';
import '../widgets/student_parent_teacher_remarks_search_card.dart';

class TeacherRemarksScreen extends StatefulWidget {
  const TeacherRemarksScreen({super.key});

  @override
  State<TeacherRemarksScreen> createState() =>
      _TeacherRemarksScreenState();
}

class _TeacherRemarksScreenState
    extends State<TeacherRemarksScreen> {
  late List<TeacherRemark> filteredRemarks;

  String selectedTeacher = "All Teachers";
  String selectedSubject = "All Subjects";

  DateTime? fromDate;
  DateTime? toDate;

  // =============================================================
  // INIT
  // =============================================================

  @override
  void initState() {
    super.initState();

    filteredRemarks = List.from(teacherRemarks);

    _sortRemarks();

    if (filteredRemarks.length > 7) {
      filteredRemarks =
          filteredRemarks.take(7).toList();
    }
  }

  // =============================================================
  // DATE PARSER
  // =============================================================

  DateTime _parseDate(String value) {
    final parts = value.split(" ");

    final day = int.parse(parts[0]);

    final monthMap = {
      "Jan": 1,
      "Feb": 2,
      "Mar": 3,
      "Apr": 4,
      "May": 5,
      "Jun": 6,
      "Jul": 7,
      "Aug": 8,
      "Sep": 9,
      "Oct": 10,
      "Nov": 11,
      "Dec": 12,
    };

    final month = monthMap[parts[1]]!;
    final year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  // =============================================================
  // SORT
  // =============================================================

  void _sortRemarks() {
    filteredRemarks.sort(
      (a, b) => _parseDate(b.date).compareTo(
        _parseDate(a.date),
      ),
    );
  }

  // =============================================================
  // FILTER
  // =============================================================

  void filterRemarks() {
    setState(() {
      filteredRemarks =
          teacherRemarks.where((remark) {
        bool match = true;

        if (selectedTeacher != "All Teachers") {
          match =
              match &&
              remark.teacherName == selectedTeacher;
        }

        if (selectedSubject != "All Subjects") {
          match =
              match &&
              remark.subject == selectedSubject;
        }

        final date = _parseDate(remark.date);

        if (fromDate != null) {
          match =
              match &&
              !date.isBefore(fromDate!);
        }

        if (toDate != null) {
          match =
              match &&
              !date.isAfter(toDate!);
        }

        return match;
      }).toList();

      _sortRemarks();
    });
  }

  // =============================================================
  // RESET
  // =============================================================

  void resetFilters() {
    setState(() {
      selectedTeacher = "All Teachers";
      selectedSubject = "All Subjects";

      fromDate = null;
      toDate = null;

      filteredRemarks =
          List.from(teacherRemarks);

      _sortRemarks();

      if (filteredRemarks.length > 7) {
        filteredRemarks =
            filteredRemarks.take(7).toList();
      }
    });
  }

  // =============================================================
  // BUILD
  // =============================================================

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    final total = filteredRemarks.length;

    final positive = filteredRemarks
        .where(
          (e) =>
              e.remark
                  .toLowerCase()
                  .contains("excellent") ||
              e.remark
                  .toLowerCase()
                  .contains("good"),
        )
        .length;

    final attention = filteredRemarks
        .where(
          (e) =>
              e.remark
                  .toLowerCase()
                  .contains("improve") ||
              e.remark
                  .toLowerCase()
                  .contains("attention"),
        )
        .length;

    final thisMonth = filteredRemarks.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Remarks"),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final bool isMobile = width < 600;
          final bool isTablet =
              width >= 600 && width < 1000;

          final horizontalPadding =
              isMobile ? 14.0 : isTablet ? 20.0 : 28.0;

          final verticalPadding =
              isMobile ? 18.0 : 24.0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // =================================================
                // HEADER
                // =================================================

                _buildPageHeader(isMobile),

                SizedBox(
                  height: isMobile ? 18 : 25,
                ),

                // =================================================
                // STUDENT INFORMATION
                // =================================================

                _buildStudentInfoCard(
                  student,
                  isMobile,
                ),

                SizedBox(
                  height: isMobile ? 24 : 30,
                ),

                // =================================================
                // SUMMARY
                // =================================================

                const Text(
                  "Remarks Summary",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff172033),
                  ),
                ),

                const SizedBox(height: 15),

                _buildSummaryGrid(
                  total: total,
                  thisMonth: thisMonth,
                  positive: positive,
                  attention: attention,
                  isMobile: isMobile,
                ),

                SizedBox(
                  height: isMobile ? 25 : 35,
                ),

                // =================================================
                // REMARKS + SEARCH
                // =================================================

                _buildMainContent(
                  isMobile: isMobile,
                  isTablet: isTablet,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // =============================================================
  // PAGE HEADER
  // =============================================================

  Widget _buildPageHeader(bool isMobile) {
    return Row(
      children: [
        Container(
          width: isMobile ? 44 : 52,
          height: isMobile ? 44 : 52,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            Icons.rate_review_outlined,
            size: isMobile ? 22 : 26,
            color: Colors.blue.shade700,
          ),
        ),

        const SizedBox(width: 12),

        const Expanded(
          child: Text(
            "Teacher Remarks",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff172033),
            ),
          ),
        ),
      ],
    );
  }

  // =============================================================
  // STUDENT INFO CARD
  // =============================================================

  Widget _buildStudentInfoCard(
    dynamic student,
    bool isMobile,
  ) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          isMobile ? 16 : 20,
        ),
        child: isMobile
            ? Column(
                children: [
                  _info(
                    "Student",
                    student.name,
                  ),

                  const Divider(height: 24),

                  _info(
                    "Class",
                    student.studentClass,
                  ),

                  const Divider(height: 24),

                  _info(
                    "Academic Year",
                    "2026-2027",
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _info(
                      "Student",
                      student.name,
                    ),
                  ),

                  Expanded(
                    child: _info(
                      "Class",
                      student.studentClass,
                    ),
                  ),

                  Expanded(
                    child: _info(
                      "Academic Year",
                      "2026-2027",
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // =============================================================
  // SUMMARY GRID
  // =============================================================

  Widget _buildSummaryGrid({
    required int total,
    required int thisMonth,
    required int positive,
    required int attention,
    required bool isMobile,
  }) {
    final cards = [
      _SummaryData(
        title: "Total",
        value: total.toString(),
        color: Colors.blue,
        icon: Icons.rate_review_outlined,
      ),
      _SummaryData(
        title: "This Month",
        value: thisMonth.toString(),
        color: Colors.indigo,
        icon: Icons.calendar_month_outlined,
      ),
      _SummaryData(
        title: "Positive",
        value: positive.toString(),
        color: Colors.green,
        icon: Icons.thumb_up_alt_outlined,
      ),
      _SummaryData(
        title: "Needs Attention",
        value: attention.toString(),
        color: Colors.red,
        icon: Icons.warning_amber_rounded,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int columns;

        if (width < 400) {
          columns = 1;
        } else if (width < 750) {
          columns = 2;
        } else {
          columns = 4;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent:
                isMobile ? 105 : 120,
          ),
          itemBuilder: (context, index) {
            final item = cards[index];

            return _summary(
              item.title,
              item.value,
              item.color,
              item.icon,
            );
          },
        );
      },
    );
  }

  // =============================================================
  // MAIN CONTENT
  // =============================================================

  Widget _buildMainContent({
    required bool isMobile,
    required bool isTablet,
  }) {
    final listCard = TeacherRemarkListCard(
      remarks: filteredRemarks,
    );

    final searchCard =
        TeacherRemarkSearchCard(
      selectedTeacher: selectedTeacher,
      selectedSubject: selectedSubject,

      onTeacherChanged: (value) {
        selectedTeacher = value;
        filterRemarks();
      },

      onSubjectChanged: (value) {
        selectedSubject = value;
        filterRemarks();
      },

      onFromDateChanged: (date) {
        fromDate = date;
        filterRemarks();
      },

      onToDateChanged: (date) {
        toDate = date;
        filterRemarks();
      },

      onReset: resetFilters,
    );

    // ===========================================================
    // MOBILE
    // ===========================================================

    if (isMobile) {
      return Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          searchCard,

          const SizedBox(height: 18),

          listCard,
        ],
      );
    }

    // ===========================================================
    // TABLET
    // ===========================================================

    if (isTablet) {
      return Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          searchCard,

          const SizedBox(height: 20),

          listCard,
        ],
      );
    }

    // ===========================================================
    // DESKTOP
    // ===========================================================

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: listCard,
        ),

        const SizedBox(width: 20),

        Expanded(
          flex: 3,
          child: searchCard,
        ),
      ],
    );
  }

  // =============================================================
  // SUMMARY CARD
  // =============================================================

  Widget _summary(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 13,
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .10),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 21,
              ),
            ),

            const SizedBox(width: 11),

            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 23,
                      color: color,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // STUDENT INFO
  // =============================================================

  Widget _info(
    String title,
    String value,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: Color(0xff172033),
          ),
        ),
      ],
    );
  }
}

// =============================================================
// SUMMARY DATA
// =============================================================

class _SummaryData {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryData({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });
}