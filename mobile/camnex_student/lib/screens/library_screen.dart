import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/library_books_data.dart';
import '../models/library_book.dart';
import '../providers/student_provider.dart';
import '../widgets/available_books_list.dart';
import '../widgets/library_search_card.dart';
import '../widgets/library_summary_card.dart';
import '../widgets/my_books_list.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late List<LibraryBook> filteredBooks;
  late TabController _tabController;

  String searchText = "";
  String selectedStatus = "All";

  DateTime? issueFrom;
  DateTime? issueTo;

  DateTime? dueFrom;
  DateTime? dueTo;

  DateTime? returnFrom;
  DateTime? returnTo;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    filteredBooks = List.from(libraryBooks);

    filteredBooks.sort(
      (a, b) => a.bookName.compareTo(b.bookName),
    );
  }

  DateTime _parseDate(String value) {
    final parts = value.split(" ");

    final day = int.parse(parts[0]);

    final monthMap = {
      "Jan": 1,
      "Feb": 2,
      "Mar": 3,
      "Apr": 4,
      "May": 5,
      "Jun": 6,
      "Jul": 7,
      "Aug": 8,
      "Sep": 9,
      "Oct": 10,
      "Nov": 11,
      "Dec": 12,
    };

    final month = monthMap[parts[1]]!;
    final year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  bool _isDateInRange(
    String dateValue,
    DateTime? from,
    DateTime? to,
  ) {
    if (from == null && to == null) {
      return true;
    }

    final date = _parseDate(dateValue);

    if (from != null && date.isBefore(from!)) {
      return false;
    }

    if (to != null && date.isAfter(to!)) {
      return false;
    }

    return true;
  }

  void filterBooks() {
    setState(() {
      filteredBooks = libraryBooks.where((book) {
        bool match = true;

        // Search
        if (searchText.trim().isNotEmpty) {
          final query = searchText.toLowerCase().trim();

          match = book.bookName.toLowerCase().contains(query);
        }

        // Status
        if (match && selectedStatus != "All") {
          match = book.status == selectedStatus;
        }

        // Issue date
        if (match && book.issueDate != null) {
          match = _isDateInRange(
            book.issueDate!,
            issueFrom,
            issueTo,
          );
        }

        // Due date
        if (match && book.dueDate != null) {
          match = _isDateInRange(
            book.dueDate!,
            dueFrom,
            dueTo,
          );
        }

        // Return date
        if (match && book.returnDate != null) {
          match = _isDateInRange(
            book.returnDate!,
            returnFrom,
            returnTo,
          );
        }

        return match;
      }).toList();

      filteredBooks.sort(
        (a, b) => a.bookName.compareTo(b.bookName),
      );
    });
  }

  void resetFilters() {
    setState(() {
      searchText = "";
      selectedStatus = "All";

      issueFrom = null;
      issueTo = null;

      dueFrom = null;
      dueTo = null;

      returnFrom = null;
      returnTo = null;

      filteredBooks = List.from(libraryBooks);

      filteredBooks.sort(
        (a, b) => a.bookName.compareTo(b.bookName),
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    final availableBooks =
        filteredBooks.where((book) => book.available).toList();

    final myBooks =
        filteredBooks.where((book) => !book.available).toList();

    final issued =
        myBooks.where((book) => book.status == "Issued").length;

    final overdue =
        myBooks.where((book) => book.status == "Overdue").length;

    final returned =
        myBooks.where((book) => book.status == "Returned").length;

    final totalFine = myBooks.fold<double>(
      0,
      (sum, book) => sum + book.fine,
    );

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,

        title: const Text(
          "Library",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==================================================
            // HEADER
            // ==================================================

            const Text(
              "Library",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Manage your books, issues, returns and library fines.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // STUDENT INFORMATION
            // ==================================================

            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Row(
                  children: [

                    CircleAvatar(
                      radius: 28,
                      backgroundColor:
                          Colors.blue.shade50,

                      child: const Icon(
                        Icons.person_outline,
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
                            student.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "${student.studentClass}  •  Academic Year 2026-2027",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Icon(
                            Icons.menu_book,
                            size: 16,
                            color: Colors.green,
                          ),

                          SizedBox(width: 5),

                          Text(
                            "Library",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight:
                                  FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ==================================================
            // SUMMARY
            // ==================================================

            const Text(
              "Library Summary",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: [

                  SizedBox(
                    width: 145,
                    child: LibrarySummaryCard(
                      title: "Issued",
                      value: "$issued",
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  SizedBox(
                    width: 145,
                    child: LibrarySummaryCard(
                      title: "Returned",
                      value: "$returned",
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(width: 12),

                  SizedBox(
                    width: 145,
                    child: LibrarySummaryCard(
                      title: "Overdue",
                      value: "$overdue",
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(width: 12),

                  SizedBox(
                    width: 145,
                    child: LibrarySummaryCard(
                      title: "Fine",
                      value:
                          "₹${totalFine.toStringAsFixed(0)}",
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ==================================================
            // MAIN CONTENT
            // ==================================================

            LayoutBuilder(
              builder: (context, constraints) {

                final isWide =
                    constraints.maxWidth >= 900;

                if (isWide) {
                  return Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Expanded(
                        flex: 7,
                        child: _buildBooksSection(
                          availableBooks,
                          myBooks,
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        flex: 3,
                        child: LibrarySearchCard(
                          searchText: searchText,
                          selectedStatus: selectedStatus,

                          onSearchChanged: (value) {
                            searchText = value;
                            filterBooks();
                          },

                          onStatusChanged: (value) {
                            selectedStatus =
                                value ?? "All";
                            filterBooks();
                          },

                          onIssueFromChanged: (date) {
                            issueFrom = date;
                            filterBooks();
                          },

                          onIssueToChanged: (date) {
                            issueTo = date;
                            filterBooks();
                          },

                          onDueFromChanged: (date) {
                            dueFrom = date;
                            filterBooks();
                          },

                          onDueToChanged: (date) {
                            dueTo = date;
                            filterBooks();
                          },

                          onReturnFromChanged: (date) {
                            returnFrom = date;
                            filterBooks();
                          },

                          onReturnToChanged: (date) {
                            returnTo = date;
                            filterBooks();
                          },

                          onReset: resetFilters,
                        ),
                      ),
                    ],
                  );
                }

                // ==================================================
                // MOBILE / SMALL SCREEN
                // ==================================================

                return Column(
                  children: [

                    LibrarySearchCard(
                      searchText: searchText,
                      selectedStatus: selectedStatus,

                      onSearchChanged: (value) {
                        searchText = value;
                        filterBooks();
                      },

                      onStatusChanged: (value) {
                        selectedStatus =
                            value ?? "All";
                        filterBooks();
                      },

                      onIssueFromChanged: (date) {
                        issueFrom = date;
                        filterBooks();
                      },

                      onIssueToChanged: (date) {
                        issueTo = date;
                        filterBooks();
                      },

                      onDueFromChanged: (date) {
                        dueFrom = date;
                        filterBooks();
                      },

                      onDueToChanged: (date) {
                        dueTo = date;
                        filterBooks();
                      },

                      onReturnFromChanged: (date) {
                        returnFrom = date;
                        filterBooks();
                      },

                      onReturnToChanged: (date) {
                        returnTo = date;
                        filterBooks();
                      },

                      onReset: resetFilters,
                    ),

                    const SizedBox(height: 20),

                    _buildBooksSection(
                      availableBooks,
                      myBooks,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BOOK SECTION
  // ============================================================

  Widget _buildBooksSection(
    List<LibraryBook> availableBooks,
    List<LibraryBook> myBooks,
  ) {
    return Card(
      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // Header

            Row(
              children: [

                const Icon(
                  Icons.library_books_outlined,
                  color: Colors.blue,
                ),

                const SizedBox(width: 10),

                const Expanded(
                  child: Text(
                    "Books",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Text(
                  "${availableBooks.length + myBooks.length} Books",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),

              child: TabBar(
                controller: _tabController,

                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),

                labelColor: Colors.blue,
                unselectedLabelColor:
                    Colors.grey.shade600,

                dividerColor: Colors.transparent,

                tabs: const [

                  Tab(
                    text: "All Library Books",
                  ),

                  Tab(
                    text: "My Books",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 650,

              child: TabBarView(
                controller: _tabController,

                children: [

                  AvailableBooksList(
                    books: availableBooks,
                  ),

                  MyBooksList(
                    books: myBooks,
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