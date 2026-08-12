import 'package:flutter/material.dart';

import '../data/class_member_data.dart';
import '../widgets/member_tile.dart';

class ClassMembersScreen extends StatelessWidget {
  const ClassMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          /// Total Members Card
          Card(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Class VIII-A",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Total Members : ${classMembers.length}",
        ),

        const SizedBox(height: 5),

        const Text(
          "Includes Class Teacher, Subject Teachers and Students.",
        ),

      ],
    ),
  ),
),

          const SizedBox(height: 15),

          /// Members List
          Expanded(
            child: ListView.builder(
              itemCount: classMembers.length,
              itemBuilder: (context, index) {
                final member = classMembers[index];

                return MemberTile(
                  member: member,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}