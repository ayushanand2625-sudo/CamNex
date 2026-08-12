import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/homework_data.dart';
import '../models/homework.dart';
import '../providers/student_provider.dart';
import '../widgets/homework_list_card.dart';
import '../widgets/homework_search_card.dart';

class HomeworkScreen extends StatefulWidget {
  final bool isStudent;

  const HomeworkScreen({
    super.key,
    this.isStudent = false,
  });

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  late List<Homework> filteredHomework;

  String selectedTeacher = "All Teachers";
  String selectedSubject = "All Subjects";
  String selectedStatus = "All";

  DateTime? assignedFrom;
  DateTime? assignedTo;
  DateTime? dueFrom;
  DateTime? dueTo;

  @override
  void initState() {
    super.initState();

    filteredHomework = List.from(homeworkList);

    _sortHomework();
  }

  // ============================================================
  // DATE PARSER
  // ============================================================

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

  // ============================================================
  // SORT
  // ============================================================

  void _sortHomework() {
    filteredHomework.sort(
      (a, b) {
        return _parseDate(b.assignedDate).compareTo(
          _parseDate(a.assignedDate),
        );
      },
    );
  }

  // ============================================================
  // FILTER HOMEWORK
  // ============================================================

  void filterHomework() {
    setState(() {
      filteredHomework = homeworkList.where((hw) {
        bool match = true;

        // Teacher
        if (selectedTeacher != "All Teachers") {
          match = match && hw.teacher == selectedTeacher;
        }

        // Subject
        if (selectedSubject != "All Subjects") {
          match = match && hw.subject == selectedSubject;
        }

        // Status
        if (selectedStatus != "All") {
          match = match && hw.status == selectedStatus;
        }

        final assigned = _parseDate(hw.assignedDate);
        final due = _parseDate(hw.dueDate);

        // Assigned From
        if (assignedFrom != null) {
          match = match && !assigned.isBefore(assignedFrom!);
        }

        // Assigned To
        if (assignedTo != null) {
          match = match && !assigned.isAfter(assignedTo!);
        }

        // Due From
        if (dueFrom != null) {
          match = match && !due.isBefore(dueFrom!);
        }

        // Due To
        if (dueTo != null) {
          match = match && !due.isAfter(dueTo!);
        }

        return match;
      }).toList();

      _sortHomework();
    });
  }

  // ============================================================
  // RESET FILTERS
  // ============================================================

  void resetFilters() {
    setState(() {
      selectedTeacher = "All Teachers";
      selectedSubject = "All Subjects";
      selectedStatus = "All";

      assignedFrom = null;
      assignedTo = null;

      dueFrom = null;
      dueTo = null;

      filteredHomework = List.from(homeworkList);

      _sortHomework();
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    final total = filteredHomework.length;

    final pending = filteredHomework
        .where((e) => e.status == "Pending")
        .length;

    final submitted = filteredHomework
        .where((e) => e.status == "Submitted")
        .length;

    final overdue = filteredHomework
        .where((e) => e.status == "Overdue")
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Homework"),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final isMobile = width < 600;
            final isTablet = width >= 600 && width < 1000;

            final horizontalPadding =
                isMobile
                    ? 16.0
                    : isTablet
                        ? 22.0
                        : 30.0;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 18 : 28,
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
                    height: isMobile ? 20 : 28,
                  ),

                  // =================================================
                  // STUDENT INFORMATION
                  // =================================================

                  _buildStudentInfo(
                    student,
                    isMobile,
                  ),

                  SizedBox(
                    height: isMobile ? 24 : 32,
                  ),

                  // =================================================
                  // SUMMARY TITLE
                  // =================================================

                  Text(
                    "Homework Summary",
                    style: TextStyle(
                      fontSize: isMobile ? 21 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // =================================================
                  // SUMMARY CARDS
                  // =================================================

                  _buildSummaryGrid(
                    total: total,
                    pending: pending,
                    submitted: submitted,
                    overdue: overdue,
                    isMobile: isMobile,
                  ),

                  SizedBox(
                    height: isMobile ? 24 : 32,
                  ),

                  // =================================================
                  // HOMEWORK + FILTER
                  // =================================================

                  if (isMobile)

                    Column(
                      children: [

                        // Homework list
                        HomeworkListCard(
                          homeworkList:
                              filteredHomework,
                          isStudent:
                              widget.isStudent,
                        ),

                        const SizedBox(height: 20),

                        // Filters
                        HomeworkSearchCard(
                          selectedTeacher:
                              selectedTeacher,

                          selectedSubject:
                              selectedSubject,

                          selectedStatus:
                              selectedStatus,

                          onTeacherChanged:
                              (value) {
                            selectedTeacher =
                                value;
                            filterHomework();
                          },

                          onSubjectChanged:
                              (value) {
                            selectedSubject =
                                value;
                            filterHomework();
                          },

                          onStatusChanged:
                              (value) {
                            selectedStatus =
                                value;
                            filterHomework();
                          },

                          onAssignedFromChanged:
                              (date) {
                            assignedFrom =
                                date;
                            filterHomework();
                          },

                          onAssignedToChanged:
                              (date) {
                            assignedTo =
                                date;
                            filterHomework();
                          },

                          onDueFromChanged:
                              (date) {
                            dueFrom = date;
                            filterHomework();
                          },

                          onDueToChanged:
                              (date) {
                            dueTo = date;
                            filterHomework();
                          },

                          onReset:
                              resetFilters,
                        ),
                      ],
                    )

                  else

                    // =================================================
                    // TABLET + DESKTOP
                    // =================================================

                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Expanded(
                          flex: 7,
                          child: HomeworkListCard(
                            homeworkList:
                                filteredHomework,
                            isStudent:
                                widget.isStudent,
                          ),
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          flex: 3,
                          child: HomeworkSearchCard(
                            selectedTeacher:
                                selectedTeacher,

                            selectedSubject:
                                selectedSubject,

                            selectedStatus:
                                selectedStatus,

                            onTeacherChanged:
                                (value) {
                              selectedTeacher =
                                  value;
                              filterHomework();
                            },

                            onSubjectChanged:
                                (value) {
                              selectedSubject =
                                  value;
                              filterHomework();
                            },

                            onStatusChanged:
                                (value) {
                              selectedStatus =
                                  value;
                              filterHomework();
                            },

                            onAssignedFromChanged:
                                (date) {
                              assignedFrom =
                                  date;
                              filterHomework();
                            },

                            onAssignedToChanged:
                                (date) {
                              assignedTo =
                                  date;
                              filterHomework();
                            },

                            onDueFromChanged:
                                (date) {
                              dueFrom = date;
                              filterHomework();
                            },

                            onDueToChanged:
                                (date) {
                              dueTo = date;
                              filterHomework();
                            },

                            onReset:
                                resetFilters,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _buildPageHeader(bool isMobile) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Text(
          "Homework",
          style: TextStyle(
            fontSize: isMobile ? 27 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          "View, track and manage assigned homework",
          style: TextStyle(
            fontSize: isMobile ? 13 : 15,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STUDENT INFORMATION
  // ============================================================

  Widget _buildStudentInfo(
    dynamic student,
    bool isMobile,
  ) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: EdgeInsets.all(
          isMobile ? 16 : 22,
        ),

        child: isMobile

            ? Column(
                children: [

                  _info(
                    "Student",
                    student.name,
                  ),

                  const SizedBox(height: 16),

                  _info(
                    "Class",
                    student.studentClass,
                  ),

                  const SizedBox(height: 16),

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

  // ============================================================
  // SUMMARY GRID
  // ============================================================

  Widget _buildSummaryGrid({
    required int total,
    required int pending,
    required int submitted,
    required int overdue,
    required bool isMobile,
  }) {
    final cards = [

      _summary(
        "Total",
        total.toString(),
        Colors.blue,
        Icons.assignment_outlined,
      ),

      _summary(
        "Pending",
        pending.toString(),
        Colors.orange,
        Icons.pending_actions_outlined,
      ),

      _summary(
        "Submitted",
        submitted.toString(),
        Colors.green,
        Icons.check_circle_outline,
      ),

      _summary(
        "Overdue",
        overdue.toString(),
        Colors.red,
        Icons.warning_amber_rounded,
      ),
    ];

    if (isMobile) {
      return Column(
        children: [

          Row(
            children: [

              Expanded(
                child: cards[0],
              ),

              const SizedBox(width: 12),

              Expanded(
                child: cards[1],
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Expanded(
                child: cards[2],
              ),

              const SizedBox(width: 12),

              Expanded(
                child: cards[3],
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [

        Expanded(
          child: cards[0],
        ),

        const SizedBox(width: 15),

        Expanded(
          child: cards[1],
        ),

        const SizedBox(width: 15),

        Expanded(
          child: cards[2],
        ),

        const SizedBox(width: 15),

        Expanded(
          child: cards[3],
        ),
      ],
    );
  }

  // ============================================================
  // SUMMARY CARD
  // ============================================================

  Widget _summary(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),

        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Row(
          children: [

            Container(
              width: 44,
              height: 44,

              decoration: BoxDecoration(
                color:
                    color.withValues(alpha: 0.12),
                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: Icon(
                icon,
                color: color,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,

                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 23,
                      color: color,
                      fontWeight:
                          FontWeight.bold,
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

  // ============================================================
  // INFORMATION ITEM
  // ============================================================

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
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          maxLines: 2,
          overflow:
              TextOverflow.ellipsis,

          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}