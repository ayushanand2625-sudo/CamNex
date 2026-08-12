import 'package:flutter/material.dart';

import '../models/notice.dart';

void showNoticeDetails(
  BuildContext context,
  NoticeModel notice,
) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(
          notice.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        content: SizedBox(
          width: 500,

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // Notice ID
                const Text(
                  "Notice ID",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  notice.noticeId,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 15),

                // Published Date
                const Text(
                  "Published Date",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  notice.date,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 15),

                // Category
                const Text(
                  "Category",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  notice.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                const Divider(),

                const SizedBox(height: 15),

                // Description
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  notice.description,
                  style: const TextStyle(
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                // Important Status
                Row(
                  children: [
                    Icon(
                      notice.isImportant
                          ? Icons.star
                          : Icons.star_border,
                      color: notice.isImportant
                          ? Colors.orange
                          : Colors.grey,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      notice.isImportant
                          ? "Important Notice"
                          : "Normal Notice",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: notice.isImportant
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        actions: [

          // Important Button
          ElevatedButton.icon(
            onPressed: () {
              notice.isImportant =
                  !notice.isImportant;

              Navigator.pop(dialogContext);
            },

            icon: Icon(
              notice.isImportant
                  ? Icons.star_border
                  : Icons.star,
            ),

            label: Text(
              notice.isImportant
                  ? "Remove Important"
                  : "Mark Important",
            ),
          ),

          // Close
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },

            child: const Text(
              "Close",
            ),
          ),
        ],
      );
    },
  );
}