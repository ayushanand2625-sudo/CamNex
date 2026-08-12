import 'package:flutter/material.dart';

import '../models/student_parent_teacher_remarks.dart';
import 'student_parent_teacher_remarks_details_dialog.dart';

class TeacherRemarkTile extends StatelessWidget {
  final TeacherRemark remark;

  const TeacherRemarkTile({
    super.key,
    required this.remark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue.shade100,
            child: const Icon(
              Icons.person,
              color: Colors.blue,
              size: 30,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  remark.subject,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  remark.teacherName,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      remark.date,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Text(
                  remark.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  remark.remark,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => TeacherRemarkDetailsDialog(
                  remark: remark,
                ),
              );
            },
            child: const Text(
              "View Details",
            ),
          ),
        ],
      ),
    );
  }
}