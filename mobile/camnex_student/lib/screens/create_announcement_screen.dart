import 'package:flutter/material.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState
    extends State<CreateAnnouncementScreen> {

  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  String selectedClass = "V-A";

  final classes = [
    "V-A",
    "VI-A",
    "VII-A",
    "VIII-A",
    "IX-A",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("New Announcement"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Announcement Title",
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(

              value: selectedClass,

              items: classes
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

            const SizedBox(height: 20),

            TextField(

              controller:
                  descriptionController,

              maxLines: 6,

              decoration: const InputDecoration(

                labelText: "Announcement",

                border: OutlineInputBorder(),

              ),

            ),

            const Spacer(),

            SizedBox(

              width: double.infinity,

              height: 50,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.pop(context);

                },

                child: const Text(
                  "Publish",
                ),

              ),

            ),

          ],

        ),

      ),

    );

  }
}