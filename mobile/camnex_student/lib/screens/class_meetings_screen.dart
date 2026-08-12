import 'package:flutter/material.dart';

import '../data/class_meeting_data.dart';
import '../widgets/meeting_tile.dart';
// import 'camnex_meeting_screen.dart';

class ClassMeetingsScreen extends StatelessWidget {
  const ClassMeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: classMeetings.length,
        itemBuilder: (context, index) {
          final meeting = classMeetings[index];

          return MeetingTile(
            meeting: meeting,
            onJoin: () {
              // Future Implementation

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => CamNexMeetingScreen(
              //       meeting: meeting,
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}