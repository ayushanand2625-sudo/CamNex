import 'package:flutter/material.dart';

import '../data/class_announcement_data.dart';
import '../widgets/announcement_tile.dart';

class ClassAnnouncementsScreen extends StatelessWidget {
  const ClassAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [

          /// Announcement Info Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    "Class Announcements",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Stay updated with all class notices, assignments, teacher announcements and important academic updates.",
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          /// Announcements List
          Expanded(
            child: ListView.builder(
              itemCount: classAnnouncements.length,
              itemBuilder: (context, index) {
                final announcement =
                    classAnnouncements[index];

                return AnnouncementTile(
                  announcement: announcement,
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}