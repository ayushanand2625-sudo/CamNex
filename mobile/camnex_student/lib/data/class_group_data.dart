import '../models/class_group.dart';

final List<ClassGroup> classGroups = [

  /// Main Class Group
  ClassGroup(
    title: "Class VIII-A",
    description:
        "Class Teacher • Subject Teachers • All Students",
    lastMessage: "Science test tomorrow at 10 AM.",
    time: "10:30 AM",
    isClassGroup: true,
  ),

  /// Subject Groups
  ClassGroup(
    title: "Mathematics",
    description:
        "Mathematics Teacher • Students",
    lastMessage: "Submit Homework-5 before Friday.",
    time: "09:15 AM",
    isClassGroup: false,
  ),

  ClassGroup(
    title: "Science",
    description:
        "Science Teacher • Students",
    lastMessage: "Live class scheduled for tomorrow.",
    time: "Yesterday",
    isClassGroup: false,
  ),

  ClassGroup(
    title: "English",
    description:
        "English Teacher • Students",
    lastMessage: "Read Chapter 7 for discussion.",
    time: "Yesterday",
    isClassGroup: false,
  ),

  ClassGroup(
    title: "Hindi",
    description:
        "Hindi Teacher • Students",
    lastMessage: "Poem recitation next week.",
    time: "Monday",
    isClassGroup: false,
  ),

  ClassGroup(
    title: "Social Science",
    description:
        "Social Science Teacher • Students",
    lastMessage: "Map work assignment uploaded.",
    time: "Monday",
    isClassGroup: false,
  ),

  ClassGroup(
    title: "Computer Science",
    description:
        "Computer Science Teacher • Students",
    lastMessage: "Project submission on Friday.",
    time: "Sunday",
    isClassGroup: false,
  ),

];