import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'teacher_homework_review_screen.dart';

class TeacherHomeworkScreen extends StatefulWidget {
  const TeacherHomeworkScreen({super.key});

  @override
  State<TeacherHomeworkScreen> createState() =>
      _TeacherHomeworkScreenState();
}

class _TeacherHomeworkScreenState
    extends State<TeacherHomeworkScreen> {
  String? selectedClass;
  String? selectedSubject;

  DateTime? selectedHomeworkDate;

  // ==========================================================
  // HOMEWORK DATA
  // ==========================================================

  final List<Map<String, dynamic>> homeworkList = [
    {
      "id": "HW001",
      "title": "Chapter 4 Exercise",
      "description": "Complete questions 1 to 10.",
      "class": "VIII-A",
      "subject": "Mathematics",
      "assignedDate": DateTime(2026, 8, 5),
      "dueDate": DateTime(2026, 8, 8),
      "hasMarks": true,
      "maxMarks": 20,
      "submissions": 18,
      "totalStudents": 28,
    },
    {
      "id": "HW002",
      "title": "Algebra Practice",
      "description": "Solve the given algebra problems.",
      "class": "VIII-A",
      "subject": "Mathematics",
      "assignedDate": DateTime(2026, 8, 7),
      "dueDate": DateTime(2026, 8, 12),
      "hasMarks": false,
      "maxMarks": null,
      "submissions": 9,
      "totalStudents": 28,
    },
    {
      "id": "HW003",
      "title": "Science Worksheet",
      "description":
          "Complete the worksheet on Force and Motion.",
      "class": "VII-A",
      "subject": "Science",
      "assignedDate": DateTime(2026, 8, 6),
      "dueDate": DateTime(2026, 8, 10),
      "hasMarks": true,
      "maxMarks": 25,
      "submissions": 21,
      "totalStudents": 28,
    },
    {
      "id": "HW004",
      "title": "Chapter 6 Questions",
      "description":
          "Answer all textbook questions.",
      "class": "VIII-A",
      "subject": "Science",
      "assignedDate": DateTime(2026, 8, 8),
      "dueDate": DateTime(2026, 8, 13),
      "hasMarks": true,
      "maxMarks": 20,
      "submissions": 4,
      "totalStudents": 26,
    },
  ];

  // ==========================================================
  // CLASSES
  // ==========================================================

  final List<String> classes = [
    "V-A",
    "VI-A",
    "VII-A",
    "VIII-A",
    "IX-A",
  ];

  // ==========================================================
  // SUBJECTS
  // ==========================================================

  final Map<String, List<String>> subjectsByClass = {
    "V-A": [
      "Mathematics",
      "Science",
    ],
    "VI-A": [
      "Mathematics",
      "Science",
    ],
    "VII-A": [
      "Mathematics",
      "Science",
      "English",
    ],
    "VIII-A": [
      "Mathematics",
      "Science",
      "English",
    ],
    "IX-A": [
      "Mathematics",
      "Science",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final availableSubjects = selectedClass == null
        ? <String>[]
        : subjectsByClass[selectedClass!] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text(
          "Homework & Assignments",
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
              "Create Homework / Assignment",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Select a class and subject to provide "
              "homework to the students of that subject.",
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
                  borderRadius:
                      BorderRadius.circular(14),
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
                  selectedSubject = null;
                  selectedHomeworkDate = null;
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
                hintText: selectedClass == null
                    ? "Select class first"
                    : "Choose subject",

                prefixIcon: const Icon(
                  Icons.menu_book_outlined,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),

                filled: true,
                fillColor: Colors.white,
              ),

              items: availableSubjects.map((subject) {
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
                        selectedHomeworkDate = null;
                      });
                    },
            ),

            const SizedBox(height: 25),

            // ==================================================
            // STUDENT INFORMATION
            // ==================================================

            if (selectedClass != null &&
                selectedSubject != null)
              _buildStudentInfo(),

            const SizedBox(height: 25),

            // ==================================================
            // CREATE BUTTON
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 54,

              child: ElevatedButton.icon(
                onPressed:
                    selectedClass != null &&
                            selectedSubject != null
                        ? _openCreateHomework
                        : null,

                icon: const Icon(
                  Icons.add_task,
                ),

                label: const Text(
                  "Create Homework / Assignment",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            // ==================================================
            // HOMEWORK LIST
            // ==================================================

            if (selectedClass != null &&
                selectedSubject != null) ...[
              const SizedBox(height: 35),

              _buildHomeworkList(),
            ],
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // STUDENT INFORMATION
  // ==========================================================

  Widget _buildStudentInfo() {
    const studentCount = 28;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.shade100,
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.groups_outlined,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  "$selectedSubject Students",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "$studentCount students in Class "
                  "$selectedClass have selected "
                  "$selectedSubject.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // HOMEWORK LIST
  // ==========================================================

  Widget _buildHomeworkList() {
    List<Map<String, dynamic>> filteredHomework =
        homeworkList.where((homework) {
      final classMatch =
          homework["class"] == selectedClass;

      final subjectMatch =
          homework["subject"] == selectedSubject;

      final dateMatch =
          selectedHomeworkDate == null ||
          _isSameDate(
            homework["assignedDate"],
            selectedHomeworkDate!,
          );

      return classMatch &&
          subjectMatch &&
          dateMatch;
    }).toList();

    // Latest homework first
    filteredHomework.sort(
      (a, b) =>
          b["assignedDate"].compareTo(
        a["assignedDate"],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==================================================
        // LIST HEADER
        // ==================================================

        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "Homework List",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "View homework assigned to this class and subject.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              tooltip: "Select Date",
              onPressed: _selectHomeworkDate,
              icon: const Icon(
                Icons.calendar_month_outlined,
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        // ==================================================
        // SELECTED DATE
        // ==================================================

        if (selectedHomeworkDate != null)
          Container(
            width: double.infinity,
            margin:
                const EdgeInsets.only(bottom: 15),

            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 11,
            ),

            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius:
                  BorderRadius.circular(12),
              border: Border.all(
                color: Colors.orange.shade100,
              ),
            ),

            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Colors.orange.shade800,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    "Showing homework for "
                    "${_formatDate(selectedHomeworkDate!)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color:
                          Colors.orange.shade900,
                    ),
                  ),
                ),

                IconButton(
                  visualDensity:
                      VisualDensity.compact,
                  onPressed: () {
                    setState(() {
                      selectedHomeworkDate = null;
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 19,
                  ),
                ),
              ],
            ),
          ),

        // ==================================================
        // EMPTY STATE
        // ==================================================

        if (filteredHomework.isEmpty)
          _buildEmptyHomework(),

        // ==================================================
        // HOMEWORK CARDS
        // ==================================================

        ...filteredHomework.map(
          (homework) =>
              _buildHomeworkCard(homework),
        ),
      ],
    );
  }

  // ==========================================================
  // HOMEWORK CARD
  // ==========================================================

  Widget _buildHomeworkCard(
    Map<String, dynamic> homework,
  ) {
    final int submissions =
        homework["submissions"];

    final int totalStudents =
        homework["totalStudents"];

    final double submissionPercentage =
        totalStudents == 0
            ? 0
            : submissions / totalStudents;

    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(17),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(17),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.035,
            ),
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // ==================================================
          // TITLE ROW
          // ==================================================

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius:
                      BorderRadius.circular(13),
                ),

                child: Icon(
                  Icons.assignment_outlined,
                  color:
                      Colors.orange.shade700,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      homework["title"],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      homework["description"],
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ==================================================
          // DATE INFORMATION
          // ==================================================

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _infoChip(
                Icons.calendar_today_outlined,
                "Assigned: "
                "${_formatDate(homework["assignedDate"])}",
              ),

              _infoChip(
                Icons.event_outlined,
                "Due: "
                "${_formatDate(homework["dueDate"])}",
              ),

              if (homework["hasMarks"] == true)
                _infoChip(
                  Icons.grade_outlined,
                  "Marks: "
                  "${homework["maxMarks"]}",
                ),
            ],
          ),

          const SizedBox(height: 15),

          // ==================================================
          // SUBMISSION PROGRESS
          // ==================================================

          Container(
            padding: const EdgeInsets.all(13),

            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.people_outline,
                      size: 19,
                    ),

                    const SizedBox(width: 7),

                    Expanded(
                      child: Text(
                        "$submissions of "
                        "$totalStudents students submitted",
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    Text(
                      "${(submissionPercentage * 100).round()}%",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 9),

                LinearProgressIndicator(
                  value:
                      submissionPercentage,
                  minHeight: 7,

                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ==================================================
          // REVIEW BUTTON
          // ==================================================

          SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(
              onPressed: () {
                _openReviewScreen(homework);
              },

              icon: const Icon(
                Icons.rate_review_outlined,
              ),

              label: Text(
                submissions == 0
                    ? "View Submissions"
                    : "Review Submissions",
              ),

              style:
                  ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 13,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                          12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // OPEN REVIEW SCREEN
  // ==========================================================

  void _openReviewScreen(
    Map<String, dynamic> homework,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            TeacherHomeworkReviewScreen(
          homeworkTitle:
              homework["title"],

          className:
              homework["class"],

          subject:
              homework["subject"],

          description:
              homework["description"],

          homeworkDate:
              homework["assignedDate"],

          dueDate:
              homework["dueDate"],

          marksEnabled:
              homework["hasMarks"],

          totalMarks:
              homework["maxMarks"],
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY HOMEWORK
  // ==========================================================

  Widget _buildEmptyHomework() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 50,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 12),

          const Text(
            "No homework found",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            selectedHomeworkDate == null
                ? "No homework has been assigned "
                    "for this class and subject."
                : "No homework was assigned on "
                    "${_formatDate(selectedHomeworkDate!)}.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // INFO CHIP
  // ==========================================================

  Widget _infoChip(
    IconData icon,
    String text,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 7,
      ),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius:
            BorderRadius.circular(9),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey.shade700,
          ),

          const SizedBox(width: 5),

          Text(
            text,
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
  // CREATE HOMEWORK
  // ==========================================================

  void _openCreateHomework() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CreateHomeworkScreen(
          className: selectedClass!,
          subject: selectedSubject!,
        ),
      ),
    );
  }

  // ==========================================================
  // HOMEWORK DATE PICKER
  // ==========================================================

  Future<void> _selectHomeworkDate() async {
    final picked =
        await showDatePicker(
      context: context,

      initialDate:
          selectedHomeworkDate ??
              DateTime.now(),

      firstDate:
          DateTime(2025),

      lastDate:
          DateTime(2030),
    );

    if (picked == null) return;

    setState(() {
      selectedHomeworkDate = picked;
    });
  }

  // ==========================================================
  // DATE COMPARISON
  // ==========================================================

  bool _isSameDate(
    DateTime first,
    DateTime second,
  ) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
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

// ============================================================
// CREATE HOMEWORK SCREEN
// ============================================================

class CreateHomeworkScreen extends StatefulWidget {
  final String className;
  final String subject;

  const CreateHomeworkScreen({
    super.key,
    required this.className,
    required this.subject,
  });

  @override
  State<CreateHomeworkScreen> createState() =>
      _CreateHomeworkScreenState();
}

class _CreateHomeworkScreenState
    extends State<CreateHomeworkScreen> {
  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final marksController =
      TextEditingController();

  final submissionController =
      TextEditingController();

  DateTime? dueDate;

  bool hasMarks = false;

  String? attachmentName;
  String? attachmentType;

  String submissionType =
      "No submission required";

  final List<String> submissionOptions = [
    "No submission required",
    "Written work",
    "PDF document",
    "Image / Photo",
    "Online text response",
    "PDF + Image",
  ];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    marksController.dispose();
    submissionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Homework",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // =================================================
            // TARGET CLASS / SUBJECT
            // =================================================

            Container(
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
                  const Text(
                    "Homework will be assigned to",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    "Class ${widget.className} • "
                    "${widget.subject}",
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Only students who have selected "
                    "this subject will receive this homework.",
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // TITLE
            // =================================================

            const Text(
              "Homework / Assignment Title",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: titleController,

              decoration: InputDecoration(
                hintText:
                    "e.g. Chapter 5 Exercise",

                prefixIcon:
                    const Icon(
                  Icons.assignment_outlined,
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          14),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // =================================================
            // INSTRUCTIONS
            // =================================================

            const Text(
              "Instructions",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller:
                  descriptionController,

              maxLines: 6,

              decoration:
                  InputDecoration(
                hintText:
                    "Enter homework instructions...",

                alignLabelWithHint: true,

                prefixIcon:
                    const Padding(
                  padding:
                      EdgeInsets.only(
                    bottom: 90,
                  ),
                  child: Icon(
                    Icons.notes_outlined,
                  ),
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          14),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // =================================================
            // DUE DATE
            // =================================================

            const Text(
              "Due Date",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            InkWell(
              onTap: _selectDueDate,

              borderRadius:
                  BorderRadius.circular(
                      14),

              child: Container(
                width: double.infinity,

                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),

                decoration:
                    BoxDecoration(
                  border: Border.all(
                    color:
                        Colors.grey.shade400,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                          14),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons
                          .calendar_month_outlined,
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        dueDate == null
                            ? "Select due date"
                            : _formatDate(
                                dueDate!,
                              ),
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              dueDate == null
                                  ? Colors.grey
                                      .shade600
                                  : Colors
                                      .black87,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons
                          .arrow_forward_ios,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // ATTACHMENT
            // =================================================

            const Text(
              "Attachment",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            if (attachmentName == null)
              InkWell(
                onTap:
                    _pickAttachment,

                borderRadius:
                    BorderRadius.circular(
                        14),

                child: Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                          18),

                  decoration:
                      BoxDecoration(
                    color:
                        Colors.grey.shade50,

                    border: Border.all(
                      color:
                          Colors.grey.shade300,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                            14),
                  ),

                  child: Column(
                    children: [
                      Icon(
                        Icons
                            .cloud_upload_outlined,
                        size: 35,
                        color:
                            Colors.blue
                                .shade600,
                      ),

                      const SizedBox(
                          height: 8),

                      const Text(
                        "Add Attachment",
                        style: TextStyle(
                          fontWeight:
                              FontWeight
                                  .w600,
                        ),
                      ),

                      const SizedBox(
                          height: 4),

                      Text(
                        "PDF, Word, Excel, "
                        "Images or other documents",
                        textAlign:
                            TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors
                              .grey
                              .shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                        14),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.green.shade50,

                  borderRadius:
                      BorderRadius.circular(
                          14),

                  border: Border.all(
                    color:
                        Colors.green
                            .shade200,
                  ),
                ),

                child: Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius
                                .circular(
                                    10),
                      ),

                      child: Icon(
                        _attachmentIcon(),
                        color:
                            Colors.blue
                                .shade700,
                      ),
                    ),

                    const SizedBox(
                        width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Text(
                            attachmentName!,
                            maxLines: 2,
                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),

                          const SizedBox(
                              height: 4),

                          Text(
                            attachmentType ??
                                "Document",

                            style:
                                TextStyle(
                              fontSize: 12,
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
                        setState(() {
                          attachmentName =
                              null;

                          attachmentType =
                              null;
                        });
                      },

                      icon:
                          const Icon(
                        Icons
                            .delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 25),

            // =================================================
            // MARKS
            // =================================================

            Container(
              decoration:
                  BoxDecoration(
                color: Colors.white,

                border: Border.all(
                  color:
                      Colors.grey.shade300,
                ),

                borderRadius:
                    BorderRadius.circular(
                        14),
              ),

              child:
                  Column(
                children: [
                  SwitchListTile(
                    value: hasMarks,

                    onChanged: (value) {
                      setState(() {
                        hasMarks = value;

                        if (!value) {
                          marksController
                              .clear();
                        }
                      });
                    },

                    title:
                        const Text(
                      "Add Marks",
                      style:
                          TextStyle(
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),

                    subtitle:
                        const Text(
                      "Enable this if the homework "
                      "will be evaluated for marks.",
                    ),

                    secondary:
                        const Icon(
                      Icons
                          .grade_outlined,
                    ),
                  ),

                  if (hasMarks)
                    Padding(
                      padding:
                          const EdgeInsets
                              .fromLTRB(
                        16,
                        0,
                        16,
                        16,
                      ),

                      child:
                          TextField(
                        controller:
                            marksController,

                        keyboardType:
                            TextInputType
                                .number,

                        decoration:
                            InputDecoration(
                          labelText:
                              "Maximum Marks",

                          hintText:
                              "e.g. 20",

                          prefixIcon:
                              const Icon(
                            Icons
                                .emoji_events_outlined,
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // SUBMISSION REQUIREMENTS
            // =================================================

            const Text(
              "Submission Requirements",
              style: TextStyle(
                fontSize: 15,
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: submissionType,

              decoration:
                  InputDecoration(
                prefixIcon:
                    const Icon(
                  Icons
                      .upload_file_outlined,
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          14),
                ),
              ),

              items:
                  submissionOptions
                      .map(
                (option) =>
                    DropdownMenuItem<
                        String>(
                  value: option,
                  child: Text(
                    option,
                  ),
                ),
              ).toList(),

              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  submissionType =
                      value;
                });
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  submissionController,

              maxLines: 3,

              decoration:
                  InputDecoration(
                hintText:
                    "Additional submission "
                    "instructions (optional)...",

                labelText:
                    "Submission Instructions",

                alignLabelWithHint:
                    true,

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          14),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // PUBLISH
            // =================================================

            SizedBox(
              width: double.infinity,
              height: 56,

              child:
                  ElevatedButton.icon(
                onPressed:
                    _publishHomework,

                icon:
                    const Icon(
                  Icons.publish,
                ),

                label:
                    const Text(
                  "Publish Homework",
                  style:
                      TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                style:
                    ElevatedButton
                        .styleFrom(
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            14),
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
  // FILE PICKER
  // ==========================================================

  Future<void> _pickAttachment() async {
    try {
      final result =
          await FilePicker.platform.pickFiles(
        type: FileType.custom,

        allowedExtensions: [
          "pdf",
          "doc",
          "docx",
          "xls",
          "xlsx",
          "ppt",
          "pptx",
          "jpg",
          "jpeg",
          "png",
          "webp",
        ],
      );

      if (result == null ||
          result.files.isEmpty) {
        return;
      }

      final file = result.files.first;

      final extension =
          file.extension?.toLowerCase() ??
              "";

      String type = "Document";

      if (extension == "pdf") {
        type = "PDF Document";
      } else if ([
        "jpg",
        "jpeg",
        "png",
        "webp",
      ].contains(extension)) {
        type = "Image";
      } else if ([
        "doc",
        "docx",
      ].contains(extension)) {
        type = "Word Document";
      } else if ([
        "xls",
        "xlsx",
      ].contains(extension)) {
        type = "Excel Spreadsheet";
      } else if ([
        "ppt",
        "pptx",
      ].contains(extension)) {
        type = "PowerPoint Presentation";
      }

      setState(() {
        attachmentName = file.name;
        attachmentType = type;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "Unable to select file: $e",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // ATTACHMENT ICON
  // ==========================================================

  IconData _attachmentIcon() {
    final extension =
        attachmentName
            ?.split(".")
            .last
            .toLowerCase() ??
            "";

    switch (extension) {
      case "pdf":
        return Icons.picture_as_pdf;

      case "jpg":
      case "jpeg":
      case "png":
      case "webp":
        return Icons.image_outlined;

      case "doc":
      case "docx":
        return Icons.description_outlined;

      case "xls":
      case "xlsx":
        return Icons.table_chart_outlined;

      case "ppt":
      case "pptx":
        return Icons.slideshow_outlined;

      default:
        return Icons.attach_file;
    }
  }

  // ==========================================================
  // DATE PICKER
  // ==========================================================

  Future<void> _selectDueDate() async {
    final picked =
        await showDatePicker(
      context: context,

      initialDate:
          DateTime.now().add(
        const Duration(days: 1),
      ),

      firstDate: DateTime.now(),

      lastDate:
          DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (picked != null) {
      setState(() {
        dueDate = picked;
      });
    }
  }

  // ==========================================================
  // DATE FORMAT
  // ==========================================================

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  // ==========================================================
  // PUBLISH HOMEWORK
  // ==========================================================

  void _publishHomework() {
    if (titleController.text.trim().isEmpty) {
      _showError(
        "Please enter homework title.",
      );
      return;
    }

    if (descriptionController.text
        .trim()
        .isEmpty) {
      _showError(
        "Please enter homework instructions.",
      );
      return;
    }

    if (dueDate == null) {
      _showError(
        "Please select due date.",
      );
      return;
    }

    if (hasMarks) {
      final marks =
          int.tryParse(
        marksController.text.trim(),
      );

      if (marks == null || marks <= 0) {
        _showError(
          "Please enter valid maximum marks.",
        );
        return;
      }
    }

    final homeworkData = {
      "title":
          titleController.text.trim(),

      "description":
          descriptionController.text.trim(),

      "class":
          widget.className,

      "subject":
          widget.subject,

      "dueDate":
          dueDate!.toIso8601String(),

      "attachment":
          attachmentName,

      "attachmentType":
          attachmentType,

      "hasMarks":
          hasMarks,

      "maxMarks":
          hasMarks
              ? int.parse(
                  marksController.text
                      .trim(),
                )
              : null,

      "submissionType":
          submissionType,

      "submissionInstructions":
          submissionController.text
              .trim(),
    };

    debugPrint(
      "HOMEWORK DATA: $homeworkData",
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          "Homework published for "
          "Class ${widget.className} • "
          "${widget.subject}",
        ),
      ),
    );

    Navigator.pop(context);
  }

  // ==========================================================
  // ERROR
  // ==========================================================

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }
}