import 'package:flutter/material.dart';

import '../models/notice.dart';
import 'notice_details_dialog.dart';

class NoticeTile extends StatelessWidget {
  final NoticeModel notice;

  const NoticeTile({
    super.key,
    required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showNoticeDetails(
          context,
          notice,
        );
      },

      child: Container(
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: notice.isImportant
              ? Colors.amber.withValues(alpha: 0.04)
              : Colors.white,

          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),

        child: Row(
          children: [

            // --------------------------------------------------
            // NOTICE ICON
            // --------------------------------------------------

            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: notice.isImportant
                    ? Colors.amber.withValues(alpha: 0.12)
                    : Colors.blue.withValues(alpha: 0.10),

                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: Icon(
                notice.isImportant
                    ? Icons.star
                    : Icons.notifications,

                color: notice.isImportant
                    ? Colors.amber.shade700
                    : Colors.blue,

                size: 22,
              ),
            ),

            const SizedBox(width: 15),

            // --------------------------------------------------
            // NOTICE INFORMATION
            // --------------------------------------------------

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    notice.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,

                      color: notice.isImportant
                          ? Colors.black87
                          : Colors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "${notice.date} | ${notice.category}",

                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // --------------------------------------------------
            // IMPORTANT BADGE
            // --------------------------------------------------

            if (notice.isImportant)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  "Important",
                  style: TextStyle(
                    color: Colors.amber.shade800,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(width: 8),

            // --------------------------------------------------
            // ARROW
            // --------------------------------------------------

            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}