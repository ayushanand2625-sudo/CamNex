import 'package:flutter/material.dart';

import '../models/student_parent_teacher_remarks.dart';
import 'student_parent_teacher_remarks_tile.dart';

class TeacherRemarkListCard extends StatelessWidget {
  final List<TeacherRemark> remarks;

  const TeacherRemarkListCard({
    super.key,
    required this.remarks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================
            // HEADER
            // ==========================

            LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 450;

                if (isSmall) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Teacher Remarks",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Recent Remarks",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: const [
                    Flexible(
                      child: Text(
                        "Teacher Remarks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Recent Remarks",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 25),

            // ==========================
            // SECTION TITLE
            // ==========================

            const Text(
              "Recent Remarks (Latest 7 Records)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            // ==========================
            // EMPTY STATE
            // ==========================

            if (remarks.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.rate_review_outlined,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "No Teacher Remarks Found",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              )

            // ==========================
            // REMARKS LIST
            // ==========================

            else
              ...remarks.map(
                (remark) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: TeacherRemarkTile(
                    remark: remark,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}