import 'package:flutter/material.dart';

class TeacherMembersScreen extends StatefulWidget {
  final String selectedClass;

  const TeacherMembersScreen({
    super.key,
    required this.selectedClass,
  });

  @override
  State<TeacherMembersScreen> createState() =>
      _TeacherMembersScreenState();
}

class _TeacherMembersScreenState
    extends State<TeacherMembersScreen> {

  String search = "";

  final List<Map<String, dynamic>> members = [

    // Teachers

    {
      "name": "Mr. Rajesh Kumar",
      "role": "Class Teacher",
      "class": "V-A",
      "adm": "",
      "teacher": true,
    },

    {
      "name": "Mrs. Priya Sharma",
      "role": "Science Teacher",
      "class": "V-A",
      "adm": "",
      "teacher": true,
    },

    // Students

    {
      "name": "Ayush Anand",
      "role": "Student",
      "class": "V-A",
      "adm": "230001",
      "teacher": false,
    },

    {
      "name": "Riya Sharma",
      "role": "Student",
      "class": "V-A",
      "adm": "230002",
      "teacher": false,
    },

    {
      "name": "Rahul Kumar",
      "role": "Student",
      "class": "VI-A",
      "adm": "230005",
      "teacher": false,
    },
  ];

  @override
  Widget build(BuildContext context) {

    final filtered = members.where((member) {

      final classMatch =
          widget.selectedClass == "All Classes"
              ? true
              : member["class"] == widget.selectedClass;

      final searchMatch =
          member["name"]
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||

              member["adm"]
                  .toLowerCase()
                  .contains(search.toLowerCase());

      return classMatch && searchMatch;

    }).toList();

    return Scaffold(

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed: () {
          // Later:
          // Add members to custom groups
        },

        icon: const Icon(Icons.person_add),

        label: const Text("Add Member"),

      ),

      body: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(16),

            child: TextField(

              decoration: InputDecoration(

                prefixIcon:
                    const Icon(Icons.search),

                hintText:
                    "Search Name / Admission No",

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),

              ),

              onChanged: (value) {

                setState(() {

                  search = value;

                });

              },

            ),

          ),

          Expanded(

            child: ListView.builder(

              itemCount: filtered.length,

              itemBuilder: (context, index) {

                final member = filtered[index];

                return ListTile(

                  leading: CircleAvatar(

                    child: Icon(

                      member["teacher"]
                          ? Icons.school
                          : Icons.person,

                    ),

                  ),

                  title: Text(member["name"]),

                  subtitle: Text(

                      "${member["role"]}\n${member["class"]}"),

                  isThreeLine: true,

                  trailing: member["teacher"]

                      ? const Icon(Icons.workspace_premium)

                      : Text(member["adm"]),

                  onTap: () {

                    // Future:
                    // Open Member Profile

                  },

                );

              },

            ),

          ),

        ],

      ),

    );

  }
}