import 'package:flutter/material.dart';

class LibrarySummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const LibrarySummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  IconData _getIcon() {
    switch (title.toLowerCase()) {
      case "issued":
        return Icons.menu_book_outlined;
      case "returned":
        return Icons.assignment_return_outlined;
      case "overdue":
        return Icons.warning_amber_rounded;
      case "fine":
        return Icons.currency_rupee_rounded;
      default:
        return Icons.library_books_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIcon(),
                color: color,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            // Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}