import 'package:flutter/material.dart';

import '../models/library_book.dart';

class LibraryBookDetailsDialog extends StatelessWidget {
  final LibraryBook book;

  const LibraryBookDetailsDialog({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = book.available;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 720,
          maxHeight: 750,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =====================================================
              // HEADER
              // =====================================================

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          book.bookName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Book Details",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    tooltip: "Close",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // =====================================================
              // AVAILABILITY STATUS
              // =====================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: isAvailable
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isAvailable
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                  ),
                ),
                child: Row(
                  children: [

                    Icon(
                      isAvailable
                          ? Icons.check_circle_rounded
                          : Icons.schedule_rounded,
                      color: isAvailable
                          ? Colors.green
                          : Colors.orange,
                      size: 21,
                    ),

                    const SizedBox(width: 10),

                    Text(
                      isAvailable
                          ? "Available in Library"
                          : "Currently Issued",
                      style: TextStyle(
                        color: isAvailable
                            ? Colors.green.shade800
                            : Colors.orange.shade800,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),

                    const Spacer(),

                    if (isAvailable)
                      Text(
                        "${book.availableCopies} copies available",
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // =====================================================
              // BOOK INFORMATION
              // =====================================================

              const Text(
                "Book Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [

                    _info(
                      Icons.person_outline,
                      "Author",
                      book.author,
                    ),

                    _info(
                      Icons.category_outlined,
                      "Category",
                      book.category,
                    ),

                    _info(
                      Icons.business_outlined,
                      "Publisher",
                      book.publisher,
                    ),

                    _info(
                      Icons.layers_outlined,
                      "Edition",
                      book.edition,
                    ),

                    _info(
                      Icons.qr_code_rounded,
                      "ISBN",
                      book.isbn,
                    ),

                    _info(
                      Icons.location_on_outlined,
                      "Rack Number",
                      book.rackNumber,
                    ),

                    _info(
                      Icons.library_books_outlined,
                      "Available Copies",
                      book.availableCopies.toString(),
                    ),

                    _info(
                      Icons.info_outline,
                      "Status",
                      isAvailable
                          ? "Available"
                          : "Issued",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // =====================================================
              // DESCRIPTION
              // =====================================================

              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  book.description.isNotEmpty
                      ? book.description
                      : "No description available for this book.",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =====================================================
              // FOOTER
              // =====================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,
                children: [

                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Close"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // INFORMATION ITEM
  // ===============================================================

  Widget _info(
    IconData icon,
    String title,
    String value,
  ) {
    return SizedBox(
      width: 300,
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Icon(
              icon,
              size: 19,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
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