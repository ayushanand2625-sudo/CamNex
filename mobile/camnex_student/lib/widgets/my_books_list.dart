import 'package:flutter/material.dart';

import '../models/library_book.dart';
import 'my_book_tile.dart';

class MyBooksList extends StatelessWidget {
  final List<LibraryBook> books;

  const MyBooksList({
    super.key,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==================================================
        // HEADER
        // ==================================================

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                "My Books",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff111827),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffEFF6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${books.length} ${books.length == 1 ? "Book" : "Books"}",
                style: const TextStyle(
                  color: Color(0xff2563EB),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        Text(
          "Your issued and returned book history",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 18),

        // ==================================================
        // BOOK LIST / EMPTY STATE
        // ==================================================

        Expanded(
          child: books.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return MyBookTile(
                      book: books[index],
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ========================================================
  // EMPTY STATE
  // ========================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xffEFF6FF),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.menu_book_outlined,
                size: 40,
                color: Color(0xff2563EB),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "No Books Found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff111827),
              ),
            ),

            const SizedBox(height: 7),

            Text(
              "You don't have any books matching the selected filters.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}