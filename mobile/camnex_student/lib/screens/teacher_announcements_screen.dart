import 'package:flutter/material.dart';

import 'create_announcement_screen.dart';

class TeacherAnnouncementsScreen extends StatefulWidget {
  final String selectedClass;

  const TeacherAnnouncementsScreen({
    super.key,
    required this.selectedClass,
  });

  @override
  State<TeacherAnnouncementsScreen> createState() =>
      _TeacherAnnouncementsScreenState();
}

class _TeacherAnnouncementsScreenState
    extends State<TeacherAnnouncementsScreen> {

  final List<Map<String, dynamic>> announcements = [
    {
      "title": "Unit Test Schedule",
      "description":
          "Mathematics Unit Test will be held on Friday.",
      "class": "V-A",
      "date": "Today"
    },
    {
      "title": "Science Project",
      "description":
          "Bring your science project by Monday.",
      "class": "VI-A",
      "date": "Yesterday"
    },
    {
      "title": "PTM Notice",
      "description":
          "Parent Teacher Meeting on Saturday.",
      "class": "V-A",
      "date": "12 Jun"
    },
  ];

  @override
  Widget build(BuildContext context) {

    final filtered = announcements.where((item) {

      if (widget.selectedClass == "All Classes") {
        return true;
      }

      return item["class"] == widget.selectedClass;

    }).toList();

    return Scaffold(

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const CreateAnnouncementScreen(),
            ),
          );

        },

        icon: const Icon(Icons.add),

        label: const Text("Announcement"),

      ),

      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: filtered.length,

        itemBuilder: (context, index) {

          final item = filtered[index];

          return Card(

            margin:
                const EdgeInsets.only(bottom: 15),

            child: Padding(

              padding:
                  const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(

                    children: [

                      Expanded(

                        child: Text(

                          item["title"],

                          style: const TextStyle(

                            fontSize: 18,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),

                      ),

                      PopupMenuButton(

                        itemBuilder: (_) => [

                          const PopupMenuItem(
                            value: 1,
                            child: Text("Edit"),
                          ),

                          const PopupMenuItem(
                            value: 2,
                            child: Text("Delete"),
                          ),

                        ],

                      ),

                    ],

                  ),

                  const SizedBox(height: 10),

                  Text(item["description"]),

                  const SizedBox(height: 15),

                  Row(

                    children: [

                      Chip(
                        label: Text(item["class"]),
                      ),

                      const Spacer(),

                      Text(item["date"]),

                    ],

                  ),

                ],

              ),

            ),

          );

        },

      ),

    );
  }
}