import 'package:flutter/material.dart';

import '../models/library_book.dart';
import 'library_book_details_dialog.dart';

class MyBookTile extends StatelessWidget {
  final LibraryBook book;

  const MyBookTile({
    super.key,
    required this.book,
  });

  Color getStatusColor() {
    switch (book.status) {
      case "Issued":
        return Colors.blue;
      case "Returned":
        return Colors.green;
      case "Overdue":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getStatusBackgroundColor() {
    switch (book.status) {
      case "Issued":
        return Colors.blue.shade50;
      case "Returned":
        return Colors.green.shade50;
      case "Overdue":
        return Colors.red.shade50;
      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor();
    final statusBackground = getStatusBackgroundColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================================================
          // HEADER
          // ==================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffDBEAFE),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.menu_book_outlined,
                  color: Color(0xff2563EB),
                  size: 27,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.bookName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff111827),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // STATUS
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  book.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // ==================================================
          // DATE INFORMATION
          // ==================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _dateInfo(
                    icon: Icons.calendar_today_outlined,
                    title: "Issued",
                    value: book.issueDate,
                  ),
                ),

                Container(
                  height: 35,
                  width: 1,
                  color: Colors.grey.shade200,
                ),

                Expanded(
                  child: _dateInfo(
                    icon: Icons.event_outlined,
                    title: "Due Date",
                    value: book.dueDate,
                  ),
                ),

                Container(
                  height: 35,
                  width: 1,
                  color: Colors.grey.shade200,
                ),

                Expanded(
                  child: _dateInfo(
                    icon: Icons.assignment_return_outlined,
                    title: "Returned",
                    value: book.returnDate.isEmpty
                        ? "-"
                        : book.returnDate,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // ==================================================
          // FINE + DETAILS
          // ==================================================

          Row(
            children: [
              // Fine
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      book.fine > 0
                          ? Icons.warning_amber_rounded
                          : Icons.check_circle_outline,
                      size: 20,
                      color: book.fine > 0
                          ? Colors.red
                          : Colors.green,
                    ),

                    const SizedBox(width: 7),

                    Text(
                      book.fine > 0
                          ? "Fine ₹${book.fine.toStringAsFixed(0)}"
                          : "No Fine",
                      style: TextStyle(
                        color: book.fine > 0
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // Details button
              OutlinedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => LibraryBookDetailsDialog(
                      book: book,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.visibility_outlined,
                  size: 17,
                ),
                label: const Text("View Details"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xff2563EB),
                  side: const BorderSide(
                    color: Color(0xffBFDBFE),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DATE INFO
  // ==========================================================

  Widget _dateInfo({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: const Color(0xff64748B),
          ),

          const SizedBox(width: 7),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xff64748B),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}