import '../models/homework.dart';

final List<Homework> homeworkList = [
  Homework(
    subject: "Mathematics",
    teacher: "Mrs. Priya Sharma",
    title: "Chapter 5 Exercises",
    description:
        "Solve Chapter 5 Questions 1-20. Draw all graphs neatly in your notebook.",
    assignedDate: "15 Jul 2026",
    dueDate: "18 Jul 2026",
    submissionMode: "Online",
    status: "Pending",
    attachments: [
      "Worksheet.pdf",
      "Graph_Template.pdf",
    ],
    teacherRemarks: "Homework not reviewed yet.",
    marksAwarded: "-",
    reviewedOn: "-",
  ),

  Homework(
    subject: "Science",
    teacher: "Mr. Amit Gupta",
    title: "Human Digestive System",
    description:
        "Prepare a labelled diagram of the digestive system and write its functions.",
    assignedDate: "14 Jul 2026",
    dueDate: "17 Jul 2026",
    submissionMode: "Offline",
    status: "Pending",
    attachments: [
      "Diagram.pdf",
    ],
    teacherRemarks: "Homework not reviewed yet.",
    marksAwarded: "-",
    reviewedOn: "-",
  ),

  Homework(
    subject: "English",
    teacher: "Ms. Neha Verma",
    title: "Essay Writing",
    description:
        "Write a 500-word essay on 'Importance of Trees'.",
    assignedDate: "12 Jul 2026",
    dueDate: "20 Jul 2026",
    submissionMode: "Online",
    status: "Submitted",
    attachments: [],
    teacherRemarks:
        "Excellent work. Well structured essay with proper grammar.",
    marksAwarded: "9 / 10",
    reviewedOn: "-",
  ),

  Homework(
    subject: "Computer",
    teacher: "Mr. Arjun Khan",
    title: "Flutter Assignment",
    description:
        "Create a login screen using Flutter and submit the project ZIP file.",
    assignedDate: "10 Jul 2026",
    dueDate: "16 Jul 2026",
    submissionMode: "Online",
    status: "Overdue",
    attachments: [
      "Assignment.pdf",
      "Sample_UI.png",
    ],
    teacherRemarks: "Homework not submitted.",
    marksAwarded: "0 / 10",
    reviewedOn: "-",
  ),

  Homework(
    subject: "Social Science",
    teacher: "Mrs. Kavita Singh",
    title: "Map Work",
    description:
        "Mark all neighbouring countries of India on the political map.",
    assignedDate: "16 Jul 2026",
    dueDate: "22 Jul 2026",
    submissionMode: "Offline",
    status: "Pending",
    attachments: [],
    teacherRemarks: "Homework not reviewed yet.",
    marksAwarded: "-",
    reviewedOn: "-",
  ),
];