import 'package:flutter/material.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  const ScheduleMeetingScreen({super.key});

  @override
  State<ScheduleMeetingScreen> createState() =>
      _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState
    extends State<ScheduleMeetingScreen> {

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

  DateTime? meetingDate;
  TimeOfDay? meetingTime;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Schedule Meeting"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Meeting Title",
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

            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                meetingDate == null
                    ? "Choose Date"
                    : meetingDate.toString(),
              ),
              onTap: () async {

                final picked =
                    await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2035),
                  initialDate: DateTime.now(),
                );

                if (picked != null) {

                  setState(() {

                    meetingDate = picked;

                  });

                }

              },
            ),

            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(
                meetingTime == null
                    ? "Choose Time"
                    : meetingTime!
                        .format(context),
              ),
              onTap: () async {

                final picked =
                    await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.now(),
                );

                if (picked != null) {

                  setState(() {

                    meetingTime = picked;

                  });

                }

              },
            ),

            const SizedBox(height: 20),

            TextField(

              controller:
                  descriptionController,

              maxLines: 5,

              decoration:
                  const InputDecoration(

                labelText: "Description",

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 40),

            SizedBox(

              width: double.infinity,

              height: 52,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.pop(context);

                },

                child:
                    const Text("Schedule"),

              ),

            ),

          ],

        ),

      ),

    );

  }
}