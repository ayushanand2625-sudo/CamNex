import 'package:flutter/material.dart';

import '../models/student_parent_teacher_remarks.dart';

class TeacherRemarkDetailsDialog extends StatelessWidget {
  final TeacherRemark remark;

  const TeacherRemarkDetailsDialog({
    super.key,
    required this.remark,
  });

  Widget _infoTile(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 650,
        padding: const EdgeInsets.all(28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Icon(
                    Icons.rate_review,
                    color: Colors.blue,
                    size: 30,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Teacher Remark",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const Divider(height: 35),

              // Teacher & Subject
              Row(
                children: [
                  Expanded(
                    child: _infoTile(
                      "Teacher",
                      remark.teacherName,
                    ),
                  ),
                  Expanded(
                    child: _infoTile(
                      "Subject",
                      remark.subject,
                    ),
                  ),
                ],
              ),

              // Date
              _infoTile(
                "Date",
                remark.date,
              ),

              const SizedBox(height: 10),

              // Remark
              const Text(
                "Remark",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  remark.remark,
                  style: const TextStyle(
                    height: 1.7,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Suggested Improvement
              const Text(
                "Suggested Improvement",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  remark.suggestion,
                  style: const TextStyle(
                    height: 1.7,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Attachments
              const Text(
                "Attachments",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (remark.attachments.isEmpty)
                const Text(
                  "No attachments available.",
                )
              else
                ...remark.attachments.map(
                  (file) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                    ),
                    title: Text(file),
                    trailing: TextButton(
                      onPressed: () {
                        // Add attachment viewing logic here
                      },
                      child: const Text("View"),
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // Close Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}