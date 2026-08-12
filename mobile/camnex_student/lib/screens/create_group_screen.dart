import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() =>
      _CreateGroupScreenState();
}

class _CreateGroupScreenState
    extends State<CreateGroupScreen> {

  final TextEditingController groupController =
      TextEditingController();

  final TextEditingController searchController =
      TextEditingController();

  String selectedClass = "V-A";

  final List<String> teacherClasses = [
    "V-A",
    "VI-A",
    "VII-A",
    "VIII-A",
    "IX-A",
  ];

  final List<Map<String, dynamic>> students = [
    {
      "name": "Ayush Anand",
      "adm": "230001",
      "class": "V-A"
    },
    {
      "name": "Riya Sharma",
      "adm": "230002",
      "class": "V-A"
    },
    {
      "name": "Aditya Singh",
      "adm": "230003",
      "class": "VI-A"
    },
    {
      "name": "Rahul Kumar",
      "adm": "230004",
      "class": "VII-A"
    },
  ];

  final List<Map<String, dynamic>> selectedStudents = [];

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> filtered =
        students.where((student) {

      bool classMatch =
          student["class"] == selectedClass;

      bool searchMatch =
          student["name"]
                  .toLowerCase()
                  .contains(
                    searchController.text
                        .toLowerCase(),
                  ) ||
              student["adm"]
                  .contains(searchController.text);

      return classMatch && searchMatch;

    }).toList();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Create Group"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Group Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: groupController,
              decoration: const InputDecoration(
                hintText:
                    "Science Exhibition Team",
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Select Class",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField(

              value: selectedClass,

              items: teacherClasses
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),

              onChanged: (value) {
                setState(() {
                  selectedClass = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText:
                    "Search Student / Admission No",
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),

            const SizedBox(height: 20),

            const Text(
              "Students",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ...filtered.map((student) {

              bool added =
                  selectedStudents.contains(student);

              return CheckboxListTile(

                value: added,

                title: Text(student["name"]),

                subtitle:
                    Text(student["adm"]),

                onChanged: (value) {

                  setState(() {

                    if (value!) {
                      selectedStudents.add(student);
                    } else {
                      selectedStudents
                          .remove(student);
                    }

                  });

                },

              );

            }),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 10),

            const Text(
              "Selected Members",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Wrap(

              spacing: 10,

              children:
                  selectedStudents.map((student) {

                return Chip(

                  label:
                      Text(student["name"]),

                  onDeleted: () {

                    setState(() {

                      selectedStudents
                          .remove(student);

                    });

                  },

                );

              }).toList(),

            ),

            const SizedBox(height: 35),

            SizedBox(

              width: double.infinity,

              height: 52,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.pop(context);

                },

                child: const Text(
                  "Create Group",
                ),

              ),

            ),

          ],

        ),

      ),

    );
  }
}