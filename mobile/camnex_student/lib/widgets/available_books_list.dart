import 'package:flutter/material.dart';

import '../models/library_book.dart';
import 'library_book_tile.dart';

class AvailableBooksList extends StatelessWidget {
  final List<LibraryBook> books;

  const AvailableBooksList({
    super.key,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    final sortedBooks = [...books];

    sortedBooks.sort(
      (a, b) => a.bookName.compareTo(b.bookName),
    );

    if (sortedBooks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 15),

            const Text(
              "No Books Found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Try changing your search or filters.",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // List header
        Row(
          children: [
            const Icon(
              Icons.auto_stories_outlined,
              size: 20,
              color: Colors.blue,
            ),

            const SizedBox(width: 8),

            const Expanded(
              child: Text(
                "Available Books",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${sortedBooks.length} Books",
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: sortedBooks.length,

            separatorBuilder: (_, __) =>
                const SizedBox(height: 12),

            itemBuilder: (context, index) {
              return LibraryBookTile(
                book: sortedBooks[index],
              );
            },
          ),
        ),
      ],
    );
  }
}