import 'package:flutter/material.dart';

class TeacherHomeworkReviewScreen extends StatefulWidget {
  final String homeworkTitle;
  final String className;
  final String subject;
  final String description;
  final DateTime homeworkDate;
  final DateTime dueDate;
  final bool marksEnabled;
  final int? totalMarks;

  const TeacherHomeworkReviewScreen({
    super.key,
    required this.homeworkTitle,
    required this.className,
    required this.subject,
    required this.description,
    required this.homeworkDate,
    required this.dueDate,
    required this.marksEnabled,
    required this.totalMarks,
  });

  @override
  State<TeacherHomeworkReviewScreen> createState() =>
      _TeacherHomeworkReviewScreenState();
}

class _TeacherHomeworkReviewScreenState
    extends State<TeacherHomeworkReviewScreen> {
  // ==========================================================
  // SAMPLE STUDENT SUBMISSIONS
  // ==========================================================

  final List<Map<String, dynamic>> submissions = [
    {
      "studentName": "Ayush Sharma",
      "rollNumber": "01",
      "status": "Submitted",
      "submittedDate": "08 Aug 2026",
      "fileName": "Ayush_Science_Assignment.pdf",
      "submissionText": "",
      "marks": null,
      "feedback": "",
    },
    {
      "studentName": "Rahul Kumar",
      "rollNumber": "02",
      "status": "Submitted",
      "submittedDate": "08 Aug 2026",
      "fileName": "Rahul_Assignment.pdf",
      "submissionText": "",
      "marks": null,
      "feedback": "",
    },
    {
      "studentName": "Priya Singh",
      "rollNumber": "03",
      "status": "Returned",
      "submittedDate": "07 Aug 2026",
      "fileName": "Priya_Homework.pdf",
      "submissionText": "",
      "marks": 15,
      "feedback": "Please correct question 5 and resubmit.",
    },
    {
      "studentName": "Ankit Verma",
      "rollNumber": "04",
      "status": "Pending",
      "submittedDate": "",
      "fileName": null,
      "submissionText": "",
      "marks": null,
      "feedback": "",
    },
  ];

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final submittedCount = submissions
        .where((submission) =>
            submission["status"] == "Submitted" ||
            submission["status"] == "Reviewed" ||
            submission["status"] == "Approved")
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Review Submissions",
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
            // HOMEWORK INFORMATION
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.homeworkTitle,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "${widget.subject} • Class ${widget.className}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 17,
                      ),

                      const SizedBox(width: 7),

                      Text(
                        "Assigned: ${_formatDate(widget.homeworkDate)}",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      const Icon(
                        Icons.event_outlined,
                        size: 17,
                      ),

                      const SizedBox(width: 7),

                      Text(
                        "Due: ${_formatDate(widget.dueDate)}",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  if (widget.marksEnabled) ...[
                    const SizedBox(height: 7),

                    Row(
                      children: [
                        const Icon(
                          Icons.grade_outlined,
                          size: 18,
                        ),

                        const SizedBox(width: 7),

                        Text(
                          "Maximum Marks: ${widget.totalMarks}",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // SUBMISSION SUMMARY
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    icon: Icons.people_outline,
                    title: "Students",
                    value: submissions.length.toString(),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _summaryCard(
                    icon: Icons.upload_file_outlined,
                    title: "Submitted",
                    value: submittedCount.toString(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ==================================================
            // STUDENT SUBMISSIONS
            // ==================================================

            const Text(
              "Student Submissions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...submissions.map(
              (submission) =>
                  _buildSubmissionCard(submission),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SUMMARY CARD
  // ==========================================================

  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: Colors.blue.shade700,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
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
  // SUBMISSION CARD
  // ==========================================================

  Widget _buildSubmissionCard(
      Map<String, dynamic> submission) {
    final String status = submission["status"];

    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        children: [
          Row(
            children: [
              // Student avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade50,

                child: Text(
                  submission["studentName"]
                      .toString()
                      .substring(0, 1)
                      .toUpperCase(),

                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Student details
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      submission["studentName"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Roll No. ${submission["rollNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    if (submission["submittedDate"]
                        .toString()
                        .isNotEmpty) ...[
                      const SizedBox(height: 3),

                      Text(
                        "Submitted: ${submission["submittedDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              _statusChip(status),
            ],
          ),

          if (submission["fileName"] != null) ...[
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.red,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      submission["fileName"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      _viewSubmission(submission);
                    },
                    icon: const Icon(
                      Icons.visibility_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (status == "Pending") ...[
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,

              child: Text(
                "Student has not submitted this homework yet.",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],

          if (status == "Submitted") ...[
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 45,

              child: ElevatedButton.icon(
                onPressed: () {
                  _viewSubmission(submission);
                },

                icon: const Icon(
                  Icons.rate_review_outlined,
                ),

                label: const Text(
                  "Review Submission",
                ),

                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],

          if (status == "Returned") ...[
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange.shade700,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      submission["feedback"] ??
                          "Returned for correction.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.orange.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: () {
                  _viewSubmission(submission);
                },

                icon: const Icon(
                  Icons.visibility_outlined,
                ),

                label: const Text(
                  "View Previous Review",
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ==========================================================
  // STATUS CHIP
  // ==========================================================

  Widget _statusChip(String status) {
    Color background;
    Color foreground;

    switch (status) {
      case "Submitted":
        background = Colors.blue.shade50;
        foreground = Colors.blue.shade700;
        break;

      case "Reviewed":
      case "Approved":
        background = Colors.green.shade50;
        foreground = Colors.green.shade700;
        break;

      case "Returned":
        background = Colors.orange.shade50;
        foreground = Colors.orange.shade700;
        break;

      default:
        background = Colors.grey.shade100;
        foreground = Colors.grey.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }

  // ==========================================================
  // VIEW SUBMISSION
  // ==========================================================

  void _viewSubmission(
      Map<String, dynamic> submission) {
    final TextEditingController feedbackController =
        TextEditingController(
      text: submission["feedback"] ?? "",
    );

    final TextEditingController marksController =
        TextEditingController(
      text: submission["marks"]?.toString() ?? "",
    );

    String selectedAction = "Approved";

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height:
                  MediaQuery.of(context).size.height * 0.85,

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Center(
                      child: Container(
                        width: 45,
                        height: 5,

                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      submission["studentName"],
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "Submission for ${widget.homeworkTitle}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // File
                    if (submission["fileName"] != null)
                      Container(
                        padding:
                            const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius:
                              BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),

                        child: Row(
                          children: [
                            const Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                              size: 30,
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                submission["fileName"],
                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),

                            OutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "File viewer will be connected to storage later.",
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Open",
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Marks
                    if (widget.marksEnabled)
                      TextField(
                        controller: marksController,
                        keyboardType:
                            TextInputType.number,

                        decoration: InputDecoration(
                          labelText:
                              "Marks / ${widget.totalMarks}",
                          prefixIcon: const Icon(
                            Icons.grade_outlined,
                          ),
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                          ),
                        ),
                      ),

                    if (widget.marksEnabled)
                      const SizedBox(height: 15),

                    // Feedback
                    TextField(
                      controller:
                          feedbackController,

                      maxLines: 3,

                      decoration: InputDecoration(
                        labelText:
                            "Feedback / Remarks",
                        hintText:
                            "Write feedback for the student...",

                        alignLabelWithHint: true,

                        prefixIcon: const Padding(
                          padding:
                              EdgeInsets.only(
                            bottom: 35,
                          ),
                          child: Icon(
                            Icons.comment_outlined,
                          ),
                        ),

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Action
                    DropdownButtonFormField<String>(
                      value: selectedAction,

                      decoration: InputDecoration(
                        labelText: "Review Action",
                        prefixIcon: const Icon(
                          Icons.fact_check_outlined,
                        ),
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  12),
                        ),
                      ),

                      items: const [
                        DropdownMenuItem(
                          value: "Approved",
                          child: Text(
                            "Approve",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Returned",
                          child: Text(
                            "Return for Correction",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "Reviewed",
                          child: Text(
                            "Mark as Reviewed",
                          ),
                        ),
                      ],

                      onChanged: (value) {
                        if (value == null) return;

                        setModalState(() {
                          selectedAction = value;
                        });
                      },
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 52,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          _saveReview(
                            submission,
                            selectedAction,
                            marksController.text,
                            feedbackController.text,
                          );

                          Navigator.pop(context);
                        },

                        icon: const Icon(
                          Icons.check_circle_outline,
                        ),

                        label: const Text(
                          "Save Review",
                          style: TextStyle(
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
                                BorderRadius.circular(
                                    14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // SAVE REVIEW
  // ==========================================================

  void _saveReview(
    Map<String, dynamic> submission,
    String action,
    String marks,
    String feedback,
  ) {
    if (widget.marksEnabled &&
        marks.trim().isNotEmpty) {
      final enteredMarks =
          int.tryParse(marks.trim());

      if (enteredMarks == null ||
          enteredMarks < 0 ||
          enteredMarks > widget.totalMarks!) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              "Please enter marks between 0 and "
              "${widget.totalMarks}.",
            ),
          ),
        );

        return;
      }

      submission["marks"] = enteredMarks;
    }

    submission["feedback"] =
        feedback.trim();

    submission["status"] = action;

    setState(() {});

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          "${submission["studentName"]}'s submission "
          "marked as $action.",
        ),
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