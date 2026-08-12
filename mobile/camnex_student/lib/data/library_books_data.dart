import '../models/library_book.dart';

const List<LibraryBook> libraryBooks = [

  LibraryBook(
    bookName: "Advanced Mathematics",
    author: "R.D. Sharma",
    category: "Mathematics",
    publisher: "Dhanpat Rai Publications",
    available: false,
    status: "Issued",
    issueDate: "05 Jul 2026",
    dueDate: "20 Jul 2026",
    returnDate: "",
    fine: 0,

    edition: "2025 Edition",
    isbn: "978-81-219-1234-5",
    rackNumber: "M-12",
    availableCopies: 4,
    description:
        "Comprehensive mathematics reference covering Algebra, Geometry, Trigonometry and Calculus.",
  ),

  LibraryBook(
    bookName: "Computer Science Fundamentals",
    author: "Sumita Arora",
    category: "Computer",
    publisher: "Dhanpat Rai",
    available: false,
    status: "Overdue",
    issueDate: "28 Jun 2026",
    dueDate: "12 Jul 2026",
    returnDate: "",
    fine: 150,

    edition: "8th Edition",
    isbn: "978-93-85678-12-4",
    rackNumber: "C-04",
    availableCopies: 2,
    description:
        "Introduction to Computer Science, Python Programming, Databases and Networking.",
  ),

  LibraryBook(
    bookName: "Physics Volume I",
    author: "H.C. Verma",
    category: "Physics",
    publisher: "Bharati Bhawan",
    available: false,
    status: "Returned",
    issueDate: "01 Jun 2026",
    dueDate: "15 Jun 2026",
    returnDate: "14 Jun 2026",
    fine: 0,

    edition: "2024 Edition",
    isbn: "978-81-701-1223-8",
    rackNumber: "P-08",
    availableCopies: 5,
    description:
        "One of the most popular physics books for conceptual understanding and numerical practice.",
  ),

  LibraryBook(
    bookName: "English Grammar",
    author: "Wren & Martin",
    category: "English",
    publisher: "S. Chand",
    available: true,
    status: "Available",
    issueDate: "",
    dueDate: "",
    returnDate: "",
    fine: 0,

    edition: "Latest Edition",
    isbn: "978-93-5283-216-7",
    rackNumber: "E-15",
    availableCopies: 8,
    description:
        "Grammar reference book for school students with examples and exercises.",
  ),

  LibraryBook(
    bookName: "Biology Today",
    author: "Trueman",
    category: "Biology",
    publisher: "Trueman Publications",
    available: true,
    status: "Available",
    issueDate: "",
    dueDate: "",
    returnDate: "",
    fine: 0,

    edition: "2026 Edition",
    isbn: "978-81-999-4521-3",
    rackNumber: "B-11",
    availableCopies: 6,
    description:
        "Detailed Biology reference for CBSE and competitive examination preparation.",
  ),

  LibraryBook(
    bookName: "Chemistry NCERT",
    author: "NCERT",
    category: "Chemistry",
    publisher: "NCERT",
    available: true,
    status: "Available",
    issueDate: "",
    dueDate: "",
    returnDate: "",
    fine: 0,

    edition: "2026 Edition",
    isbn: "978-81-7450-567-1",
    rackNumber: "CH-09",
    availableCopies: 10,
    description:
        "Official NCERT Chemistry textbook for senior secondary classes.",
  ),

  LibraryBook(
    bookName: "History of India",
    author: "Bipan Chandra",
    category: "History",
    publisher: "Orient Blackswan",
    available: true,
    status: "Available",
    issueDate: "",
    dueDate: "",
    returnDate: "",
    fine: 0,

    edition: "Revised Edition",
    isbn: "978-81-250-1234-6",
    rackNumber: "H-05",
    availableCopies: 3,
    description:
        "Modern Indian History covering important events from colonial rule to independence.",
  ),

  LibraryBook(
    bookName: "Artificial Intelligence",
    author: "Stuart Russell",
    category: "Technology",
    publisher: "Pearson",
    available: true,
    status: "Available",
    issueDate: "",
    dueDate: "",
    returnDate: "",
    fine: 0,

    edition: "4th Edition",
    isbn: "978-01-321-789-5",
    rackNumber: "AI-01",
    availableCopies: 2,
    description:
        "Comprehensive introduction to Artificial Intelligence, Machine Learning and Robotics.",
  ),
];