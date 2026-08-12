import 'package:flutter/material.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState
    extends State<TeacherAttendanceScreen> {
  // ==========================================================
  // TEACHER ASSIGNMENT
  //
  // TEMPORARY
  //
  // Later these values will come from the logged-in teacher
  // and backend/database.
  //
  // true  = Class Teacher
  // false = Subject Teacher
  // ==========================================================

  final bool isClassTeacher = true;

  // The class assigned to this class teacher.
  //
  // Example:
  // "VIII-A"
  //
  // Later this will come from backend.
  final String assignedClass = "VIII-A";

  // ==========================================================
  // SELECTED DATE
  // ==========================================================

  DateTime selectedDate = DateTime.now();

  // ==========================================================
  // SAMPLE STUDENTS
  //
  // Later this will come from backend according to the
  // logged-in class teacher's assigned class.
  // ==========================================================

  final Map<String, List<Map<String, dynamic>>> studentsByClass = {
    "V-A": [
      {
        "id": "ST001",
        "name": "Ayush Sharma",
        "rollNumber": "01",
      },
      {
        "id": "ST002",
        "name": "Rahul Kumar",
        "rollNumber": "02",
      },
      {
        "id": "ST003",
        "name": "Priya Singh",
        "rollNumber": "03",
      },
      {
        "id": "ST004",
        "name": "Ananya Verma",
        "rollNumber": "04",
      },
    ],
    "VI-A": [
      {
        "id": "ST005",
        "name": "Rohan Kumar",
        "rollNumber": "01",
      },
      {
        "id": "ST006",
        "name": "Sneha Singh",
        "rollNumber": "02",
      },
      {
        "id": "ST007",
        "name": "Aditya Sharma",
        "rollNumber": "03",
      },
    ],
    "VII-A": [
      {
        "id": "ST008",
        "name": "Arjun Verma",
        "rollNumber": "01",
      },
      {
        "id": "ST009",
        "name": "Neha Kumari",
        "rollNumber": "02",
      },
      {
        "id": "ST010",
        "name": "Karan Singh",
        "rollNumber": "03",
      },
      {
        "id": "ST011",
        "name": "Simran Sharma",
        "rollNumber": "04",
      },
    ],
    "VIII-A": [
      {
        "id": "ST012",
        "name": "Ayush Sharma",
        "rollNumber": "01",
      },
      {
        "id": "ST013",
        "name": "Rahul Kumar",
        "rollNumber": "02",
      },
      {
        "id": "ST014",
        "name": "Priya Singh",
        "rollNumber": "03",
      },
      {
        "id": "ST015",
        "name": "Ankit Verma",
        "rollNumber": "04",
      },
      {
        "id": "ST016",
        "name": "Ananya Gupta",
        "rollNumber": "05",
      },
      {
        "id": "ST017",
        "name": "Riya Sharma",
        "rollNumber": "06",
      },
    ],
    "IX-A": [
      {
        "id": "ST018",
        "name": "Vivek Kumar",
        "rollNumber": "01",
      },
      {
        "id": "ST019",
        "name": "Pooja Singh",
        "rollNumber": "02",
      },
      {
        "id": "ST020",
        "name": "Mohit Sharma",
        "rollNumber": "03",
      },
    ],
  };

  // ==========================================================
  // ATTENDANCE FOR CURRENT SELECTED DATE
  //
  // true  = Present
  // false = Absent
  // ==========================================================

  final Map<String, bool> attendance = {};

  // ==========================================================
  // ATTENDANCE HISTORY
  //
  // TEMPORARY LOCAL DATA
  //
  // Later this will come from backend.
  //
  // studentId -> date -> present/absent
  // ==========================================================

  final Map<String, Map<DateTime, bool>> attendanceHistory = {};

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();

    _initializeSampleAttendance();

    _loadAttendanceForSelectedDate();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    // ========================================================
    // SUBJECT TEACHER / NOT ASSIGNED
    // ========================================================

    if (!isClassTeacher) {
      return _buildNotAssignedScreen();
    }

    // ========================================================
    // GET ASSIGNED CLASS STUDENTS
    // ========================================================

    final students =
        studentsByClass[assignedClass] ?? [];

    final presentCount = students.where((student) {
      return attendance[student["id"]] == true;
    }).length;

    final absentCount =
        students.length - presentCount;

    final canEdit = canEditAttendance;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Students Attendance",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ==================================================
            // HEADER
            // ==================================================

            const Text(
              "Students Attendance",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Manage attendance for your assigned class.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 22),

            // ==================================================
            // ASSIGNED CLASS CARD
            // ==================================================

            _buildAssignedClassCard(),

            const SizedBox(height: 20),

            // ==================================================
            // DATE
            // ==================================================

            const Text(
              "Attendance Date",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            InkWell(
              onTap: _selectDate,

              borderRadius:
                  BorderRadius.circular(14),

              child: Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),

                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),

                  borderRadius:
                      BorderRadius.circular(14),

                  color: Colors.white,
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.calendar_month_outlined,
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        _formatDate(selectedDate),

                        style:
                            const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // LOCK INFORMATION
            // ==================================================

            _buildEditStatusCard(),

            const SizedBox(height: 22),

            // ==================================================
            // CLASS INFORMATION
            // ==================================================

            _buildClassInformation(
              students.length,
              presentCount,
              absentCount,
            ),

            const SizedBox(height: 25),

            // ==================================================
            // STUDENT LIST
            // ==================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  "Student List",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextButton.icon(
                  onPressed:
                      students.isEmpty || !canEdit
                          ? null
                          : _markAllPresent,

                  icon: const Icon(
                    Icons.done_all,
                  ),

                  label: const Text(
                    "All Present",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (students.isEmpty)
              _buildEmptyStudentCard()
            else
              ...students.map(
                (student) =>
                    _buildStudentCard(student),
              ),

            const SizedBox(height: 20),

            // ==================================================
            // SAVE ATTENDANCE
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 56,

              child: ElevatedButton.icon(
                onPressed:
                    students.isEmpty || !canEdit
                        ? null
                        : _saveAttendance,

                icon: const Icon(
                  Icons.save_outlined,
                ),

                label: Text(
                  canEdit
                      ? "Save Attendance"
                      : "Attendance Locked",

                  style:
                      const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                style:
                    ElevatedButton.styleFrom(
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // NOT ASSIGNED SCREEN
  // ==========================================================

  Widget _buildNotAssignedScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Students Attendance",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Container(
            width: double.infinity,

            padding: const EdgeInsets.all(28),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(20),

              border: Border.all(
                color: Colors.orange.shade100,
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withValues(alpha: 0.05),

                  blurRadius: 15,

                  offset:
                      const Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                Container(
                  width: 75,
                  height: 75,

                  decoration: BoxDecoration(
                    color:
                        Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),

                  child: Icon(
                    Icons
                        .person_off_outlined,
                    size: 38,
                    color:
                        Colors.orange.shade700,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "No Class Assigned",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "You are not assigned as a "
                  "Class Teacher to any class.",
                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
                    fontSize: 14,
                    color:
                        Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  "Only Class Teachers can manage "
                  "student attendance.",
                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
                    fontSize: 13,
                    color:
                        Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // ASSIGNED CLASS CARD
  // ==========================================================

  Widget _buildAssignedClassCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.blue.shade50,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.blue.shade100,
        ),
      ),

      child: Row(
        children: [

          Container(
            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.groups_outlined,
              color: Colors.blue,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  "Your Assigned Class",
                  style: TextStyle(
                    fontSize: 13,
                    color:
                        Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "Class $assignedClass",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.verified,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // EDIT STATUS
  // ==========================================================

  Widget _buildEditStatusCard() {
    if (canEditAttendance) {
      return Container(
        width: double.infinity,

        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.green.shade50,

          borderRadius:
              BorderRadius.circular(12),

          border: Border.all(
            color: Colors.green.shade100,
          ),
        ),

        child: Row(
          children: [

            Icon(
              Icons.edit_calendar_outlined,
              color:
                  Colors.green.shade700,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                "Attendance can be edited for "
                "today and yesterday.",
                style: TextStyle(
                  fontSize: 13,
                  color:
                      Colors.green.shade800,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,

        borderRadius:
            BorderRadius.circular(12),

        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Row(
        children: [

          Icon(
            Icons.lock_outline,
            color:
                Colors.grey.shade700,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              "This attendance is locked. "
              "Teachers can only edit today "
              "or yesterday.",
              style: TextStyle(
                fontSize: 13,
                color:
                    Colors.grey.shade700,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CLASS INFORMATION
  // ==========================================================

  Widget _buildClassInformation(
    int total,
    int present,
    int absent,
  ) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.blue.shade50,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.blue.shade100,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color:
                      Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.groups_outlined,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Class $assignedClass",
                      style:
                          const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Attendance for "
                      "${_formatDate(selectedDate)}",
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child:
                    _attendanceSummary(
                  "Total",
                  total.toString(),
                  Colors.blue,
                ),
              ),

              Expanded(
                child:
                    _attendanceSummary(
                  "Present",
                  present.toString(),
                  Colors.green,
                ),
              ),

              Expanded(
                child:
                    _attendanceSummary(
                  "Absent",
                  absent.toString(),
                  Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ATTENDANCE SUMMARY
  // ==========================================================

  Widget _attendanceSummary(
    String title,
    String value,
    Color color,
  ) {
    return Column(
      children: [

        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight:
                FontWeight.bold,
            color: color,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color:
                Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // STUDENT CARD
  //
  // TAPPING THE CARD OPENS THE STUDENT ATTENDANCE DETAILS.
  // ==========================================================

  Widget _buildStudentCard(
    Map<String, dynamic> student,
  ) {
    final studentId = student["id"];

    final isPresent =
        attendance[studentId] ?? false;

    final percentage =
        _getOverallAttendancePercentage(
      studentId,
    );

    return InkWell(
      onTap: () {
        _openStudentAttendance(
          student,
        );
      },

      borderRadius:
          BorderRadius.circular(16),

      child: Container(
        width: double.infinity,

        margin:
            const EdgeInsets.only(
          bottom: 12,
        ),

        padding:
            const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(16),

          border: Border.all(
            color: isPresent
                ? Colors.green.shade200
                : Colors.grey.shade200,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withValues(alpha: 0.04),

              blurRadius: 8,

              offset:
                  const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [

            CircleAvatar(
              radius: 24,

              backgroundColor:
                  isPresent
                      ? Colors.green.shade50
                      : Colors.grey.shade100,

              child: Text(
                student["name"]
                    .toString()
                    .substring(0, 1)
                    .toUpperCase(),

                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,

                  color: isPresent
                      ? Colors.green.shade700
                      : Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    student["name"],
                    style:
                        const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Roll No. "
                    "${student["rollNumber"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Overall: "
                    "${percentage.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          percentage >= 75
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: [

                Switch(
                  value: isPresent,

                  activeThumbColor:
                      Colors.green,

                  onChanged:
                      canEditAttendance
                          ? (value) {
                              setState(() {
                                attendance[
                                        studentId] =
                                    value;
                              });
                            }
                          : null,
                ),

                Text(
                  isPresent
                      ? "Present"
                      : "Absent",

                  style: TextStyle(
                    fontSize: 11,

                    fontWeight:
                        FontWeight.w600,

                    color: isPresent
                        ? Colors.green.shade700
                        : Colors.red.shade700,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 4),

            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY STUDENT CARD
  // ==========================================================

  Widget _buildEmptyStudentCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        children: [

          const Icon(
            Icons.people_outline,
            size: 45,
            color: Colors.grey,
          ),

          const SizedBox(height: 12),

          const Text(
            "No students found",
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CHECK WHETHER ATTENDANCE CAN BE EDITED
  //
  // TODAY     -> EDITABLE
  // YESTERDAY -> EDITABLE
  // OLDER     -> LOCKED
  //
  // This automatically locks attendance after 2 days.
  // ==========================================================

  bool get canEditAttendance {
    final today = DateTime.now();

    final todayOnly = DateTime(
      today.year,
      today.month,
      today.day,
    );

    final selectedOnly = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    final yesterday =
        todayOnly.subtract(
      const Duration(days: 1),
    );

    return selectedOnly == todayOnly ||
        selectedOnly == yesterday;
  }

  // ==========================================================
  // SELECT DATE
  // ==========================================================

  Future<void> _selectDate() async {
    final picked =
        await showDatePicker(
      context: context,

      initialDate: selectedDate,

      // No future attendance.
      firstDate:
          DateTime(2026, 1, 1),

      lastDate:
          DateTime.now(),

      helpText:
          "Select Attendance Date",
    );

    if (picked == null) {
      return;
    }

    setState(() {
      selectedDate = picked;

      _loadAttendanceForSelectedDate();
    });
  }

  // ==========================================================
  // LOAD ATTENDANCE
  // ==========================================================

  void _loadAttendanceForSelectedDate() {
    attendance.clear();

    final students =
        studentsByClass[assignedClass] ?? [];

    for (final student in students) {
      final studentId = student["id"];

      final date =
          _dateOnly(selectedDate);

      final saved =
          attendanceHistory[
              studentId]?[date];

      if (saved != null) {
        attendance[studentId] =
            saved;
      }
    }
  }

  // ==========================================================
  // MARK ALL PRESENT
  // ==========================================================

  void _markAllPresent() {
    if (!canEditAttendance) {
      _showMessage(
        "Attendance is locked for this date.",
      );

      return;
    }

    final students =
        studentsByClass[assignedClass] ??
            [];

    setState(() {
      for (final student in students) {
        attendance[
            student["id"]] = true;
      }
    });
  }

  // ==========================================================
  // SAVE ATTENDANCE
  // ==========================================================

  void _saveAttendance() {
    if (!canEditAttendance) {
      _showMessage(
        "Attendance is locked. "
        "You can only edit today or yesterday.",
      );

      return;
    }

    final students =
        studentsByClass[assignedClass] ??
            [];

    if (students.isEmpty) {
      _showMessage(
        "No students found.",
      );

      return;
    }

    final presentCount =
        students.where((student) {
      return attendance[
              student["id"]] ==
          true;
    }).length;

    final absentCount =
        students.length -
            presentCount;

    // ========================================================
    // SAVE LOCALLY FOR NOW
    //
    // Later this will be replaced with API call.
    // ========================================================

    final date =
        _dateOnly(selectedDate);

    for (final student in students) {
      final studentId =
          student["id"];

      attendanceHistory.putIfAbsent(
        studentId,
        () => {},
      );

      attendanceHistory[
              studentId]![date] =
          attendance[
                  studentId] ??
              false;
    }

    debugPrint(
      "ATTENDANCE SAVED: "
      "Class=$assignedClass "
      "Date=$date "
      "Present=$presentCount "
      "Absent=$absentCount",
    );

    setState(() {});

    _showMessage(
      "Attendance saved for Class "
      "$assignedClass • "
      "${_formatDate(selectedDate)}",
    );
  }

  // ==========================================================
  // OPEN STUDENT ATTENDANCE
  // ==========================================================

  void _openStudentAttendance(
    Map<String, dynamic> student,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return StudentAttendanceDialog(
          student: student,
          attendanceHistory:
              attendanceHistory,
        );
      },
    );
  }

  // ==========================================================
  // INITIAL SAMPLE ATTENDANCE
  //
  // TEMPORARY
  //
  // This creates some attendance records so the student
  // attendance screen has something to display.
  // ==========================================================

  void _initializeSampleAttendance() {
    final students =
        studentsByClass[assignedClass] ??
            [];

    final today =
        _dateOnly(DateTime.now());

    for (final student in students) {
      final studentId =
          student["id"];

      attendanceHistory[
          studentId] = {};

      // Last 30 days
      for (int i = 1; i <= 30; i++) {
        final date =
            today.subtract(
          Duration(days: i),
        );

        // Weekend = holiday.
        if (date.weekday ==
                DateTime.saturday ||
            date.weekday ==
                DateTime.sunday) {
          continue;
        }

        // Sample attendance:
        // Most days present.
        //
        // Every 9th day absent.
        attendanceHistory[
                studentId]![date] =
            i % 9 != 0;
      }
    }
  }

  // ==========================================================
  // OVERALL ATTENDANCE %
  // ==========================================================

  double _getOverallAttendancePercentage(
    String studentId,
  ) {
    final records =
        attendanceHistory[studentId];

    if (records == null ||
        records.isEmpty) {
      return 0;
    }

    final workingDays =
        records.length;

    final presentDays =
        records.values
            .where((value) => value)
            .length;

    if (workingDays == 0) {
      return 0;
    }

    return
        (presentDays /
                workingDays) *
            100;
  }

  // ==========================================================
  // DATE ONLY
  // ==========================================================

  DateTime _dateOnly(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void _showMessage(
    String message,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  // ==========================================================
  // DATE FORMAT
  // ==========================================================

  String _formatDate(
    DateTime date,
  ) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}

// ============================================================
// STUDENT ATTENDANCE DIALOG
//
// Opens when the teacher taps a student.
//
// Shows:
// - Overall percentage
// - Present days
// - Absent days
// - Month selector
// - Monthly calendar
// - Daily attendance status
// ============================================================

class StudentAttendanceDialog
    extends StatefulWidget {
  final Map<String, dynamic> student;

  final Map<String, Map<DateTime, bool>>
      attendanceHistory;

  const StudentAttendanceDialog({
    super.key,
    required this.student,
    required this.attendanceHistory,
  });

  @override
  State<StudentAttendanceDialog>
      createState() =>
          _StudentAttendanceDialogState();
}

class _StudentAttendanceDialogState
    extends State<StudentAttendanceDialog> {

  // ==========================================================
  // SELECTED MONTH
  // ==========================================================

  DateTime selectedMonth =
      DateTime.now();

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final studentId =
        widget.student["id"];

    final records =
        widget.attendanceHistory[
                studentId] ??
            {};

    final monthlyRecords =
        _getMonthlyRecords(records);

    final presentDays =
        monthlyRecords.values
            .where((value) => value)
            .length;

    final absentDays =
        monthlyRecords.values
            .where((value) => !value)
            .length;

    final overallPercentage =
        _getOverallPercentage(records);

    final monthlyPercentage =
        monthlyRecords.isEmpty
            ? 0.0
            : (presentDays /
                    monthlyRecords.length) *
                100;

    return Dialog(
      insetPadding:
          const EdgeInsets.all(18),

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Container(
        constraints:
            const BoxConstraints(
          maxWidth: 650,
        ),

        padding:
            const EdgeInsets.all(22),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // ==================================================
              // HEADER
              // ==================================================

              Row(
                children: [

                  CircleAvatar(
                    radius: 28,

                    backgroundColor:
                        Colors.blue.shade50,

                    child: Text(
                      widget.student["name"]
                          .toString()
                          .substring(0, 1)
                          .toUpperCase(),

                      style:
                          TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Colors.blue.shade700,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          widget.student[
                              "name"],

                          style:
                              const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          "Roll No. "
                          "${widget.student["rollNumber"]}",

                          style:
                              TextStyle(
                            fontSize: 13,
                            color: Colors
                                .grey
                                .shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },

                    icon:
                        const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ==================================================
              // OVERALL ATTENDANCE
              // ==================================================

              Container(
                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                  18,
                ),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.blue.shade50,

                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),

                  border: Border.all(
                    color:
                        Colors.blue.shade100,
                  ),
                ),

                child: Column(
                  children: [

                    const Text(
                      "Overall Attendance",
                      style:
                          TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      "${overallPercentage.toStringAsFixed(1)}%",

                      style:
                          TextStyle(
                        fontSize: 34,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            overallPercentage >=
                                    75
                                ? Colors
                                    .green
                                : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // ==================================================
              // MONTH SELECTOR
              // ==================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [

                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedMonth =
                            DateTime(
                          selectedMonth.year,
                          selectedMonth.month -
                              1,
                        );
                      });
                    },

                    icon:
                        const Icon(
                      Icons.chevron_left,
                    ),
                  ),

                  Text(
                    _monthName(
                      selectedMonth.month,
                    ) +
                        " " +
                        selectedMonth.year
                            .toString(),

                    style:
                        const TextStyle(
                      fontSize: 19,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  IconButton(
                    onPressed:
                        _canGoToNextMonth()
                            ? () {
                                setState(() {
                                  selectedMonth =
                                      DateTime(
                                    selectedMonth
                                        .year,
                                    selectedMonth
                                            .month +
                                        1,
                                  );
                                });
                              }
                            : null,

                    icon:
                        const Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),

              // ==================================================
              // MONTH SUMMARY
              // ==================================================

              Row(
                children: [

                  Expanded(
                    child:
                        _summaryBox(
                      "Present",
                      presentDays
                          .toString(),
                      Colors.green,
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child:
                        _summaryBox(
                      "Absent",
                      absentDays
                          .toString(),
                      Colors.red,
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child:
                        _summaryBox(
                      "Month %",
                      "${monthlyPercentage.toStringAsFixed(0)}%",
                      Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // ==================================================
              // CALENDAR
              // ==================================================

              _buildCalendar(
                records,
              ),

              const SizedBox(
                height: 18,
              ),

              // ==================================================
              // LEGEND
              // ==================================================

              Wrap(
                spacing: 15,
                runSpacing: 8,

                children: [

                  _legendItem(
                    "Present",
                    Colors.green,
                  ),

                  _legendItem(
                    "Absent",
                    Colors.red,
                  ),

                  _legendItem(
                    "Holiday",
                    Colors.grey,
                  ),

                  _legendItem(
                    "Not Marked",
                    Colors.blueGrey,
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width:
                    double.infinity,

                child:
                    ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },

                  child:
                      const Text(
                    "Close",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // CALENDAR
  // ==========================================================

  Widget _buildCalendar(
    Map<DateTime, bool> records,
  ) {
    final firstDay =
        DateTime(
      selectedMonth.year,
      selectedMonth.month,
      1,
    );

    final daysInMonth =
        DateTime(
      selectedMonth.year,
      selectedMonth.month + 1,
      0,
    ).day;

    final firstWeekday =
        firstDay.weekday;

    final List<Widget> cells =
        [];

    // Empty cells before first day.
    for (int i = 1;
        i < firstWeekday;
        i++) {
      cells.add(
        const SizedBox(),
      );
    }

    for (int day = 1;
        day <= daysInMonth;
        day++) {

      final date =
          DateTime(
        selectedMonth.year,
        selectedMonth.month,
        day,
      );

      cells.add(
        _buildDayCell(
          date,
          records,
        ),
      );
    }

    return Column(
      children: [

        Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceAround,

          children: const [

            Expanded(
              child: Center(
                child: Text("M"),
              ),
            ),

            Expanded(
              child: Center(
                child: Text("T"),
              ),
            ),

            Expanded(
              child: Center(
                child: Text("W"),
              ),
            ),

            Expanded(
              child: Center(
                child: Text("T"),
              ),
            ),

            Expanded(
              child: Center(
                child: Text("F"),
              ),
            ),

            Expanded(
              child: Center(
                child: Text("S"),
              ),
            ),

            Expanded(
              child: Center(
                child: Text("S"),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 12,
        ),

        GridView.count(
          crossAxisCount: 7,

          shrinkWrap: true,

          physics:
              const NeverScrollableScrollPhysics(),

          mainAxisSpacing: 10,

          crossAxisSpacing: 6,

          children: cells,
        ),
      ],
    );
  }

  // ==========================================================
  // DAY CELL
  // ==========================================================

  Widget _buildDayCell(
    DateTime date,
    Map<DateTime, bool> records,
  ) {
    final today =
        DateTime.now();

    final todayOnly =
        DateTime(
      today.year,
      today.month,
      today.day,
    );

    final dateOnly =
        DateTime(
      date.year,
      date.month,
      date.day,
    );

    // Weekend
    final isWeekend =
        date.weekday ==
                DateTime.saturday ||
            date.weekday ==
                DateTime.sunday;

    final status =
        records[dateOnly];

    Color backgroundColor;

    if (isWeekend) {
      backgroundColor =
          Colors.grey.shade500;
    } else if (status == true) {
      backgroundColor =
          Colors.green.shade600;
    } else if (status == false) {
      backgroundColor =
          Colors.red.shade600;
    } else {
      backgroundColor =
          Colors.blueGrey.shade100;
    }

    final isToday =
        dateOnly == todayOnly;

    return Container(
      decoration:
          BoxDecoration(
        color: backgroundColor,

        shape: BoxShape.circle,

        border: isToday
            ? Border.all(
                color: Colors.blue,
                width: 3,
              )
            : null,
      ),

      child: Center(
        child: Text(
          date.day.toString(),

          style: TextStyle(
            fontSize: 12,

            fontWeight:
                FontWeight.bold,

            color:
                isWeekend ||
                        status != null
                    ? Colors.white
                    : Colors
                        .grey
                        .shade700,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // MONTHLY RECORDS
  // ==========================================================

  Map<DateTime, bool> _getMonthlyRecords(
    Map<DateTime, bool> records,
  ) {
    final result =
        <DateTime, bool>{};

    records.forEach(
      (date, value) {
        if (date.year ==
                selectedMonth.year &&
            date.month ==
                selectedMonth.month) {
          result[date] = value;
        }
      },
    );

    return result;
  }

  // ==========================================================
  // OVERALL %
  // ==========================================================

  double _getOverallPercentage(
    Map<DateTime, bool> records,
  ) {
    if (records.isEmpty) {
      return 0;
    }

    final total =
        records.length;

    final present =
        records.values
            .where(
              (value) => value,
            )
            .length;

    return (present / total) * 100;
  }

  // ==========================================================
  // MONTH BOX
  // ==========================================================

  Widget _summaryBox(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 5,
      ),

      decoration:
          BoxDecoration(
        color:
            color.withValues(
          alpha: 0.08,
        ),

        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Column(
        children: [

          Text(
            value,

            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(
            height: 3,
          ),

          Text(
            title,

            style: TextStyle(
              fontSize: 11,
              color:
                  Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // LEGEND
  // ==========================================================

  Widget _legendItem(
    String title,
    Color color,
  ) {
    return Row(
      mainAxisSize:
          MainAxisSize.min,

      children: [

        Container(
          width: 12,
          height: 12,

          decoration:
              BoxDecoration(
            color: color,
            shape:
                BoxShape.circle,
          ),
        ),

        const SizedBox(
          width: 5,
        ),

        Text(
          title,
          style:
              const TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // NEXT MONTH
  // ==========================================================

  bool _canGoToNextMonth() {
    final now =
        DateTime.now();

    return selectedMonth.year <
            now.year ||
        (selectedMonth.year ==
                now.year &&
            selectedMonth.month <
                now.month);
  }

  // ==========================================================
  // MONTH NAME
  // ==========================================================

  String _monthName(
    int month,
  ) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return months[month - 1];
  }
}