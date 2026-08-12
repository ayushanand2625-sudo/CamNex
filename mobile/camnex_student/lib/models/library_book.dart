class LibraryBook {
  final String bookName;
  final String author;
  final String category;
  final String publisher;

  final bool available;

  final String status;

  final String issueDate;
  final String dueDate;
  final String returnDate;

  final double fine;

  // NEW
  final String edition;
  final String isbn;
  final String rackNumber;
  final int availableCopies;
  final String description;

  const LibraryBook({
    required this.bookName,
    required this.author,
    required this.category,
    required this.publisher,
    required this.available,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    required this.returnDate,
    required this.fine,

    required this.edition,
    required this.isbn,
    required this.rackNumber,
    required this.availableCopies,
    required this.description,
  });
}