import 'package:flutter/material.dart';

import '../models/class_group.dart';
import 'student_profile_screen.dart';
import 'teacher_profile_screen.dart';

class GroupInfoScreen extends StatelessWidget {
  final ClassGroup group;

  const GroupInfoScreen({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    // ============================================================
    // DUMMY MEMBERS
    // Replace with Firebase/API data later.
    // ============================================================

    final members = [
      {
        "name": "Mr. Rajesh Kumar",
        "role": "Class Teacher",
        "teacher": true,
      },
      {
        "name": "Mrs. Priya Sharma",
        "role": "Science Teacher",
        "teacher": true,
      },
      {
        "name": "Ayush Anand",
        "role": "Student",
        "teacher": false,
      },
      {
        "name": "Riya Sharma",
        "role": "Student",
        "teacher": false,
      },
      {
        "name": "Rahul Kumar",
        "role": "Student",
        "teacher": false,
      },
      {
        "name": "Ananya Singh",
        "role": "Student",
        "teacher": false,
      },
      {
        "name": "Arjun Verma",
        "role": "Student",
        "teacher": false,
      },
    ];

    final teachers = members
        .where((member) => member["teacher"] == true)
        .toList();

    final students = members
        .where((member) => member["teacher"] == false)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Group Information",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.only(bottom: 30),
        children: [
          // ========================================================
          // GROUP HEADER
          // ========================================================

          const SizedBox(height: 25),

          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: group.isClassGroup
                  ? Colors.blue.shade50
                  : Colors.orange.shade50,
              child: Icon(
                group.isClassGroup
                    ? Icons.groups_rounded
                    : Icons.menu_book_rounded,
                size: 48,
                color: group.isClassGroup
                    ? Colors.blue
                    : Colors.orange,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Text(
                group.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 7),

          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                group.isClassGroup
                    ? "Official Class Group"
                    : "Academic Group",
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Center(
            child: Text(
              "${members.length} members",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // ========================================================
          // GROUP DESCRIPTION
          // ========================================================

          _sectionCard(
            context,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "About this group",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Official CamNex academic communication "
                  "group for students and teachers. "
                  "Important academic announcements, "
                  "homework, study material and class "
                  "discussions are shared here.",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // ========================================================
          // SHARED CONTENT
          // ========================================================

          _sectionTitle("Shared Content"),

          _infoTile(
            icon: Icons.photo_library_outlined,
            iconColor: Colors.purple,
            title: "Media",
            subtitle: "Photos and videos shared in this group",
            onTap: () {
              _showComingSoon(
                context,
                "Media",
              );
            },
          ),

          _infoTile(
            icon: Icons.link_rounded,
            iconColor: Colors.blue,
            title: "Links",
            subtitle: "Links shared in this group",
            onTap: () {
              _showComingSoon(
                context,
                "Links",
              );
            },
          ),

          _infoTile(
            icon: Icons.insert_drive_file_outlined,
            iconColor: Colors.red,
            title: "Documents",
            subtitle: "PDFs and other documents",
            onTap: () {
              _showComingSoon(
                context,
                "Documents",
              );
            },
          ),

          const Divider(
            height: 30,
          ),

          // ========================================================
          // TEACHERS
          // ========================================================

          _sectionTitle(
            "Teachers (${teachers.length})",
          ),

          ...teachers.map(
            (member) => _memberTile(
              context,
              member,
            ),
          ),

          const Divider(
            height: 30,
          ),

          // ========================================================
          // STUDENTS
          // ========================================================

          _sectionTitle(
            "Students (${students.length})",
          ),

          ...students.map(
            (member) => _memberTile(
              context,
              member,
            ),
          ),

          const SizedBox(height: 20),

          // ========================================================
          // GROUP NOTICE
          // ========================================================

          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.orange.shade100,
              ),
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.orange.shade700,
                ),

                const SizedBox(width: 10),

                const Expanded(
                  child: Text(
                    "Please use this group only for "
                    "academic and class-related communication.",
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        10,
        18,
        8,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // SECTION CARD
  // ============================================================

  Widget _sectionCard(
    BuildContext context, {
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: child,
    );
  }

  // ============================================================
  // SHARED CONTENT TILE
  // ============================================================

  Widget _infoTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      leading: CircleAvatar(
        backgroundColor: iconColor.withValues(
          alpha: .10,
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
      ),
      onTap: onTap,
    );
  }

  // ============================================================
  // MEMBER TILE
  // ============================================================

  Widget _memberTile(
    BuildContext context,
    Map<String, dynamic> member,
  ) {
    final bool isTeacher =
        member["teacher"] as bool;

    final String name =
        member["name"] as String;

    final String role =
        member["role"] as String;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 4,
      ),

      leading: CircleAvatar(
        radius: 24,
        backgroundColor: isTeacher
            ? Colors.blue.shade50
            : Colors.grey.shade100,
        child: Icon(
          isTeacher
              ? Icons.school_rounded
              : Icons.person_rounded,
          color: isTeacher
              ? Colors.blue
              : Colors.grey.shade700,
        ),
      ),

      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),

      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          role,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ),

      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
      ),

      onTap: () {
        if (isTeacher) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TeacherProfileScreen(
                name: name,
                subject: role,
                degree: "M.Ed., B.Ed.",
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StudentProfileScreen(
                name: name,
                className: "VIII",
                section: "A",
                admissionNo: "230154",
                rollNo: "18",
              ),
            ),
          );
        }
      },
    );
  }

  // ============================================================
  // COMING SOON
  // ============================================================

  void _showComingSoon(
    BuildContext context,
    String feature,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              25,
              10,
              25,
              30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      Colors.blue.shade50,
                  child: const Icon(
                    Icons.construction_outlined,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "$feature",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "$feature shared in this group "
                  "will appear here once connected "
                  "to the CamNex backend.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}