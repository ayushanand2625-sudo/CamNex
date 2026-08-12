import 'package:flutter/material.dart';

class TeacherRemarksScreen extends StatefulWidget {
  const TeacherRemarksScreen({super.key});

  @override
  State<TeacherRemarksScreen> createState() =>
      _TeacherRemarksScreenState();
}

class _TeacherRemarksScreenState extends State<TeacherRemarksScreen> {
  // ==========================================================
  // SELECTED CLASS
  // ==========================================================

  String? selectedClass;

  // ==========================================================
  // SELECTED SUBJECT
  // ==========================================================

  String? selectedSubject;

  // ==========================================================
  // SAMPLE CLASSES
  //
  // Later this will come from backend according to
  // the teacher's assigned classes.
  // ==========================================================

  final List<String> classes = [
    "V-A",
    "VI-A",
    "VII-A",
    "VIII-A",
    "IX-A",
  ];

  // ==========================================================
  // SAMPLE SUBJECTS
  //
  // Later only subjects assigned to the logged-in teacher
  // will be displayed.
  // ==========================================================

  final List<String> subjects = [
    "Mathematics",
    "Science",
    "English",
    "Computer",
  ];

  // ==========================================================
  // SAMPLE STUDENTS
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
  // REMARKS DATA
  //
  // Structure:
  //
  // class -> subject -> studentId -> list of remarks
  //
  // Later this will come from backend/database.
  // ==========================================================

  final Map<String, Map<String, Map<String, List<Map<String, dynamic>>>>>
      remarks = {
    "V-A": {
      "Mathematics": {
        "ST001": [
          {
            "remark":
                "Excellent participation in today's mathematics class.",
            "date": "10/07/2026",
          },
          {
            "remark":
                "Good improvement in problem solving.",
            "date": "05/07/2026",
          },
        ],
        "ST002": [
          {
            "remark":
                "Needs to practice multiplication tables regularly.",
            "date": "09/07/2026",
          },
        ],
      },
    },
  };

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final students = selectedClass == null
        ? <Map<String, dynamic>>[]
        : studentsByClass[selectedClass!] ?? [];

    final remarkCount = _getRemarkCount(students);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Teacher Remarks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ==================================================
            // HEADER
            // ==================================================

            const Text(
              "Teacher Remarks",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Add and review remarks for students. "
              "Saved remarks will be visible to students "
              "and their parents.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // SELECT CLASS
            // ==================================================

            const Text(
              "Select Class",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedClass,

              decoration: InputDecoration(
                hintText: "Choose class",

                prefixIcon: const Icon(
                  Icons.class_outlined,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),

                filled: true,
                fillColor: Colors.white,
              ),

              items: classes.map((className) {
                return DropdownMenuItem<String>(
                  value: className,
                  child: Text(
                    "Class $className",
                  ),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedClass = value;

                  // Reset subject when class changes.
                  selectedSubject = null;
                });
              },
            ),

            const SizedBox(height: 22),

            // ==================================================
            // SELECT SUBJECT
            // ==================================================

            const Text(
              "Select Subject",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedSubject,

              decoration: InputDecoration(
                hintText: "Choose subject",

                prefixIcon: const Icon(
                  Icons.menu_book_outlined,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),

                filled: true,
                fillColor: Colors.white,
              ),

              items: subjects.map((subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),

              onChanged: selectedClass == null
                  ? null
                  : (value) {
                      setState(() {
                        selectedSubject = value;
                      });
                    },
            ),

            const SizedBox(height: 25),

            // ==================================================
            // CLASS/SUBJECT INFORMATION
            // ==================================================

            if (selectedClass != null &&
                selectedSubject != null)
              _buildSubjectInformation(
                students.length,
                remarkCount,
              ),

            const SizedBox(height: 25),

            // ==================================================
            // STUDENT LIST
            // ==================================================

            if (selectedClass != null &&
                selectedSubject != null) ...[
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Students",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "${students.length} Students",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ...students.map(
                (student) => _buildStudentCard(student),
              ),

              const SizedBox(height: 20),
            ],

            // ==================================================
            // NOTHING SELECTED
            // ==================================================

            if (selectedClass == null)
              _buildEmptyState(
                icon: Icons.class_outlined,
                title: "Select a Class",
                message:
                    "Select a class to view students "
                    "and add teacher remarks.",
              ),

            if (selectedClass != null &&
                selectedSubject == null)
              _buildEmptyState(
                icon: Icons.menu_book_outlined,
                title: "Select a Subject",
                message:
                    "Select the subject taught by you "
                    "to view the assigned students.",
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SUBJECT INFORMATION
  // ==========================================================

  Widget _buildSubjectInformation(
    int studentCount,
    int remarkCount,
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
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.rate_review_outlined,
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
                      "Class $selectedClass",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      selectedSubject!,
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
                child: _summaryItem(
                  "Students",
                  studentCount.toString(),
                  Colors.blue,
                ),
              ),

              Expanded(
                child: _summaryItem(
                  "Remarks",
                  remarkCount.toString(),
                  Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SUMMARY ITEM
  // ==========================================================

  Widget _summaryItem(
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
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // STUDENT CARD
  // ==========================================================

  Widget _buildStudentCard(
    Map<String, dynamic> student,
  ) {
    final studentId = student["id"];

    final studentRemarks =
        _getStudentRemarks(studentId);

    final hasRemarks =
        studentRemarks.isNotEmpty;

    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: hasRemarks
              ? Colors.orange.shade200
              : Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(16),

        onTap: () {
          _openStudentRemarks(student);
        },

        child: Row(
          children: [
            // ==================================================
            // AVATAR
            // ==================================================

            CircleAvatar(
              radius: 24,

              backgroundColor:
                  hasRemarks
                      ? Colors.orange.shade50
                      : Colors.grey.shade100,

              child: Text(
                student["name"]
                    .toString()
                    .substring(0, 1)
                    .toUpperCase(),

                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,

                  color: hasRemarks
                      ? Colors.orange.shade700
                      : Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // ==================================================
            // STUDENT INFORMATION
            // ==================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    student["name"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Roll No. ${student["rollNumber"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    hasRemarks
                        ? "${studentRemarks.length} previous remark(s)"
                        : "No remarks yet",

                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w600,
                      color: hasRemarks
                          ? Colors.orange.shade700
                          : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // ACTION
            // ==================================================

            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(9),

                  decoration: BoxDecoration(
                    color:
                        Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.edit_outlined,
                    size: 19,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "View",
                  style: TextStyle(
                    fontSize: 10,
                    color:
                        Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // OPEN STUDENT REMARKS
  // ==========================================================

  void _openStudentRemarks(
    Map<String, dynamic> student,
  ) {
    final studentId = student["id"];

    final studentRemarks =
        _getStudentRemarks(studentId);

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {
        return Container(
          height:
              MediaQuery.of(context).size.height * 0.85,

          decoration: const BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),

          child: Column(
            children: [
              // ==================================================
              // HEADER
              // ==================================================

              Padding(
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  18,
                  12,
                  10,
                ),

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 23,

                      backgroundColor:
                          Colors.blue.shade50,

                      child: Text(
                        student["name"]
                            .toString()
                            .substring(0, 1)
                            .toUpperCase(),

                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Colors.blue.shade700,
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
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            "Roll No. ${student["rollNumber"]} • "
                            "$selectedClass • "
                            "$selectedSubject",
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon:
                          const Icon(Icons.close),
                    ),
                  ],
                ),
              ),

              const Divider(),

              // ==================================================
              // PREVIOUS REMARKS
              // ==================================================

              Expanded(
                child: studentRemarks.isEmpty
                    ? _buildNoRemarks()
                    : ListView(
                        padding:
                            const EdgeInsets.all(20),

                        children: [
                          const Text(
                            "Previous Remarks",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),

                          ...studentRemarks.reversed
                              .map(
                            (remark) =>
                                _buildRemarkCard(
                              remark,
                            ),
                          ),
                        ],
                      ),
              ),

              // ==================================================
              // ADD REMARK BUTTON
              // ==================================================

              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.all(20),

                  child: SizedBox(
                    width: double.infinity,
                    height: 54,

                    child:
                        ElevatedButton.icon(
                      onPressed: () {
                        _showAddRemarkDialog(
                          student,
                        );
                      },

                      icon: const Icon(
                        Icons.add_comment_outlined,
                      ),

                      label: const Text(
                        "Add New Remark",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      style:
                          ElevatedButton.styleFrom(
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // ADD REMARK DIALOG
  // ==========================================================

  void _showAddRemarkDialog(
    Map<String, dynamic> student,
  ) {
    final TextEditingController controller =
        TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),

          title: const Text(
            "Add Teacher Remark",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                student["name"],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w600,
                  color:
                      Colors.blue.shade700,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "$selectedClass • $selectedSubject",
                style: TextStyle(
                  fontSize: 12,
                  color:
                      Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: controller,

                maxLines: 5,

                textCapitalization:
                    TextCapitalization.sentences,

                decoration:
                    InputDecoration(
                  hintText:
                      "Write your remark here...",

                  alignLabelWithHint: true,

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),

                  filled: true,

                  fillColor:
                      Colors.grey.shade50,
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child:
                  const Text("Cancel"),
            ),

            ElevatedButton.icon(
              onPressed: () {
                final text =
                    controller.text.trim();

                if (text.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please write a remark.",
                      ),
                    ),
                  );

                  return;
                }

                _saveRemark(
                  student,
                  text,
                );

                Navigator.pop(
                  dialogContext,
                );
              },

              icon: const Icon(
                Icons.save_outlined,
                size: 18,
              ),

              label:
                  const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // SAVE REMARK
  // ==========================================================

  void _saveRemark(
    Map<String, dynamic> student,
    String remarkText,
  ) {
    if (selectedClass == null ||
        selectedSubject == null) {
      return;
    }

    final className = selectedClass!;
    final subjectName = selectedSubject!;
    final studentId = student["id"];

    remarks.putIfAbsent(
      className,
      () => {},
    );

    remarks[className]!.putIfAbsent(
      subjectName,
      () => {},
    );

    remarks[className]![subjectName]!
        .putIfAbsent(
      studentId,
      () => [],
    );

    remarks[className]![subjectName]![studentId]!
        .add({
      "remark": remarkText,
      "date": _formatDate(DateTime.now()),
    });

    setState(() {});

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          "Remark added for ${student["name"]}.",
        ),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  // ==========================================================
  // GET STUDENT REMARKS
  // ==========================================================

  List<Map<String, dynamic>> _getStudentRemarks(
    String studentId,
  ) {
    if (selectedClass == null ||
        selectedSubject == null) {
      return [];
    }

    return remarks[selectedClass!]
            ?[selectedSubject!]
            ?[studentId] ??
        [];
  }

  // ==========================================================
  // GET TOTAL REMARK COUNT
  // ==========================================================

  int _getRemarkCount(
    List<Map<String, dynamic>> students,
  ) {
    int count = 0;

    for (final student in students) {
      count += _getStudentRemarks(
        student["id"],
      ).length;
    }

    return count;
  }

  // ==========================================================
  // REMARK CARD
  // ==========================================================

  Widget _buildRemarkCard(
    Map<String, dynamic> remark,
  ) {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.orange.shade50,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: Colors.orange.shade100,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                Icons.comment_outlined,
                size: 18,
                color:
                    Colors.orange.shade700,
              ),

              const SizedBox(width: 8),

              const Expanded(
                child: Text(
                  "Teacher Remark",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              Text(
                remark["date"] ?? "",
                style: TextStyle(
                  fontSize: 11,
                  color:
                      Colors.grey.shade600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            remark["remark"] ?? "",
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // NO REMARKS
  // ==========================================================

  Widget _buildNoRemarks() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(
                color:
                    Colors.grey.shade100,
                shape: BoxShape.circle,
              ),

              child: Icon(
                Icons.comment_outlined,
                size: 34,
                color:
                    Colors.grey.shade500,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "No Remarks Yet",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "No previous remarks have been "
              "given to this student.",
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color:
                    Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 25,
      ),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,

        borderRadius:
            BorderRadius.circular(18),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            size: 45,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 15),

          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color:
                  Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DATE FORMAT
  // ==========================================================

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}