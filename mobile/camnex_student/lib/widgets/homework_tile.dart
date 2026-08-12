import 'package:flutter/material.dart';

import '../models/homework.dart';
import 'homework_details_dialog.dart';

class HomeworkTile extends StatelessWidget {
  final Homework homework;
  final bool isStudent;

  const HomeworkTile({
    super.key,
    required this.homework,
    required this.isStudent,
  });
  Color getStatusColor() {
    switch (homework.status) {
      case "Submitted":
        return Colors.green;

      case "Pending":
        return Colors.orange;

      case "Overdue":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xffE8F1FF),
            child: Icon(
              Icons.menu_book,
              color: Color(0xff2563EB),
              size: 30,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homework.subject,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  homework.title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Teacher : ${homework.teacher}",
                ),

                const SizedBox(height: 5),

                Text(
                  "Assigned : ${homework.assignedDate}",
                ),

                Text(
                  "Submission : ${homework.dueDate}",
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor().withOpacity(.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    homework.status,
                    style: TextStyle(
                      color: getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 20),

SizedBox(
  height: 45,
  child: ElevatedButton.icon(
    icon: const Icon(Icons.visibility),
    label: const Text("View Details"),
    onPressed: () {
      showHomeworkDetails(
        context,
        homework,
        isStudent: isStudent,
      );
    },
  ),
),

],
),
);
}
}
  