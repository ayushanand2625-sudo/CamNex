import 'package:flutter/material.dart';

import 'schedule_meeting_screen.dart';

class TeacherMeetingsScreen extends StatefulWidget {
  final String selectedClass;

  const TeacherMeetingsScreen({
    super.key,
    required this.selectedClass,
  });

  @override
  State<TeacherMeetingsScreen> createState() =>
      _TeacherMeetingsScreenState();
}

class _TeacherMeetingsScreenState
    extends State<TeacherMeetingsScreen> {

  final List<Map<String, dynamic>> meetings = [
    {
      "title": "Mathematics Revision",
      "class": "V-A",
      "date": "15 Jul 2026",
      "time": "10:00 AM",
      "status": "Upcoming",
    },
    {
      "title": "PTM Meeting",
      "class": "VI-A",
      "date": "18 Jul 2026",
      "time": "11:30 AM",
      "status": "Upcoming",
    },
    {
      "title": "Science Practical",
      "class": "V-A",
      "date": "10 Jul 2026",
      "time": "2:00 PM",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {

    final filtered = meetings.where((meeting) {

      if (widget.selectedClass == "All Classes") {
        return true;
      }

      return meeting["class"] == widget.selectedClass;

    }).toList();

    return Scaffold(

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const ScheduleMeetingScreen(),
            ),
          );

        },

        icon: const Icon(Icons.video_call),

        label: const Text("Schedule"),

      ),

      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: filtered.length,

        itemBuilder: (context, index) {

          final meeting = filtered[index];

          return Card(

            margin:
                const EdgeInsets.only(bottom: 16),

            child: Padding(

              padding:
                  const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    meeting["title"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      const Icon(Icons.class_),

                      const SizedBox(width: 8),

                      Text(meeting["class"]),

                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [

                      const Icon(Icons.calendar_today),

                      const SizedBox(width: 8),

                      Text(meeting["date"]),

                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [

                      const Icon(Icons.access_time),

                      const SizedBox(width: 8),

                      Text(meeting["time"]),

                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(

                    children: [

                      Chip(
                        label: Text(
                          meeting["status"],
                        ),
                      ),

                      const Spacer(),

                      ElevatedButton.icon(

                        onPressed: () {},

                        icon:
                            const Icon(Icons.login),

                        label:
                            const Text("Join"),

                      ),

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