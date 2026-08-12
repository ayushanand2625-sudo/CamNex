import 'package:flutter/material.dart';

import '../models/library_book.dart';
import 'library_book_details_dialog.dart';

class LibraryBookTile extends StatelessWidget {
  final LibraryBook book;

  const LibraryBookTile({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = book.available;

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 600;

          if (isSmall) {
            return _buildSmallLayout(
              context,
              isAvailable,
            );
          }

          return _buildLargeLayout(
            context,
            isAvailable,
          );
        },
      ),
    );
  }

  // ===============================================================
  // LARGE SCREEN
  // ===============================================================

  Widget _buildLargeLayout(
    BuildContext context,
    bool isAvailable,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        // ---------------------------------------------------------
        // BOOK ICON
        // ---------------------------------------------------------

        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            color: Colors.blue,
            size: 29,
          ),
        ),

        const SizedBox(width: 16),

        // ---------------------------------------------------------
        // BOOK INFORMATION
        // ---------------------------------------------------------

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                book.bookName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                "by ${book.author}",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 16,
                runSpacing: 6,
                children: [

                  _metaItem(
                    Icons.category_outlined,
                    book.category,
                  ),

                  _metaItem(
                    Icons.business_outlined,
                    book.publisher,
                  ),

                  _metaItem(
                    Icons.location_on_outlined,
                    "Rack ${book.rackNumber}",
                  ),

                  _metaItem(
                    Icons.library_books_outlined,
                    "${book.availableCopies} copies",
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 18),

        // ---------------------------------------------------------
        // STATUS + BUTTON
        // ---------------------------------------------------------

        Column(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [

            _availabilityBadge(isAvailable),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {
                _showDetails(context);
              },
              icon: const Icon(
                Icons.visibility_outlined,
                size: 18,
              ),
              label: const Text("View Details"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: BorderSide(
                  color: Colors.blue.shade200,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 11,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===============================================================
  // SMALL SCREEN
  // ===============================================================

  Widget _buildSmallLayout(
    BuildContext context,
    bool isAvailable,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: Colors.blue,
                size: 26,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    book.bookName,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "by ${book.author}",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            _availabilityBadge(isAvailable),
          ],
        ),

        const SizedBox(height: 15),

        // ---------------------------------------------------------
        // METADATA
        // ---------------------------------------------------------

        Wrap(
          spacing: 14,
          runSpacing: 8,
          children: [

            _metaItem(
              Icons.category_outlined,
              book.category,
            ),

            _metaItem(
              Icons.location_on_outlined,
              "Rack ${book.rackNumber}",
            ),

            _metaItem(
              Icons.library_books_outlined,
              "${book.availableCopies} copies",
            ),
          ],
        ),

        const SizedBox(height: 16),

        // ---------------------------------------------------------
        // BUTTON
        // ---------------------------------------------------------

        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              _showDetails(context);
            },
            icon: const Icon(
              Icons.visibility_outlined,
              size: 18,
            ),
            label: const Text("View Details"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue,
              side: BorderSide(
                color: Colors.blue.shade200,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // AVAILABILITY BADGE
  // ===============================================================

  Widget _availabilityBadge(
    bool isAvailable,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: isAvailable
            ? Colors.green.shade50
            : Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isAvailable
              ? Colors.green.shade100
              : Colors.red.shade100,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            isAvailable
                ? Icons.check_circle_rounded
                : Icons.schedule_rounded,
            size: 15,
            color: isAvailable
                ? Colors.green
                : Colors.red,
          ),

          const SizedBox(width: 5),

          Text(
            isAvailable
                ? "Available"
                : "Issued",
            style: TextStyle(
              color: isAvailable
                  ? Colors.green.shade700
                  : Colors.red.shade700,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // METADATA ITEM
  // ===============================================================

  Widget _metaItem(
    IconData icon,
    String text,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Icon(
          icon,
          size: 15,
          color: Colors.grey.shade600,
        ),

        const SizedBox(width: 5),

        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // DETAILS DIALOG
  // ===============================================================

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return LibraryBookDetailsDialog(
          book: book,
        );
      },
    );
  }
}