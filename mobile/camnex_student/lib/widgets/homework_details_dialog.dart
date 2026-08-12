import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/homework.dart';

Future<void> showHomeworkDetails(
  BuildContext context,
  Homework homework, {
  bool isStudent = false,
}) {
  final TextEditingController messageController =
      TextEditingController();

  String? selectedFile;

  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => const SizedBox(),
    transitionBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6,
          sigmaY: 6,
        ),
        child: FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.95,
              end: 1,
            ).animate(animation),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Center(
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    child: SizedBox(
                      width: 850,
                      height: 650,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              
                              /// TITLE

                              Center(
                                child: Text(
                                  homework.subject,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),

                              _row(
                                "Teacher",
                                homework.teacher,
                              ),

                              _row(
                                "Assigned",
                                homework.assignedDate,
                              ),

                              _row(
                                "Submission Date",
                                homework.dueDate,
                              ),

                              _row(
                                "Submission Mode",
                                homework.submissionMode,
                              ),

                              _row(
                                "Status",
                                homework.status,
                              ),

                              const Divider(height: 35),

                              const Text(
                                "Homework",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                homework.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 25),

                              /// TEACHER ATTACHMENTS

                              if (homework
                                  .attachments
                                  .isNotEmpty) ...[
                                const Text(
                                  "Teacher Attachments",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),
                                                                ...homework.attachments.map(
                                  (file) => Card(
                                    elevation: 0,
                                    color: Colors.grey.shade100,
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                      ),
                                      title: Text(file),
                                      trailing: ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.download,
                                          size: 18,
                                        ),
                                        label: const Text(
                                          "Download",
                                        ),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "$file downloaded successfully.",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),
                              ],

                              /// ==========================
                              /// ONLINE SUBMISSION
                              /// ==========================

                              if (homework.submissionMode ==
                                  "Online") ...[
                                const Divider(),

                                const SizedBox(height: 15),

                                const Text(
                                  "Your Submission",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 15),

                                TextField(
                                  controller: messageController,
                                  maxLines: 4,
                                  decoration:
                                      const InputDecoration(
                                    labelText:
                                        "Write your answer",
                                    border:
                                        OutlineInputBorder(),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.attach_file,
                                      ),
                                      label: const Text(
                                        "Attach File",
                                      ),
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker
                                                .platform
                                                .pickFiles(
                                          allowMultiple: false,
                                          type:
                                              FileType.custom,
                                          allowedExtensions: const [
                                            'pdf',
                                            'doc',
                                            'docx',
                                            'jpg',
                                            'jpeg',
                                            'png',
                                            'zip',
                                          ],
                                        );

                                        if (result != null) {
                                          setState(() {
                                            selectedFile =
                                                result.files
                                                    .single
                                                    .name;
                                          });
                                        }
                                      },
                                    ),

                                    const SizedBox(width: 15),

                                    Expanded(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.all(
                                                12),
                                        decoration:
                                            BoxDecoration(
                                          color: Colors
                                              .grey.shade100,
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                                      10),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons
                                                  .insert_drive_file,
                                              color:
                                                  Colors.blue,
                                            ),

                                            const SizedBox(
                                                width: 10),

                                            Expanded(
                                              child: Text(
                                                selectedFile ??
                                                    "No file selected",
                                                overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 25),
                                                                const Divider(),

                                const SizedBox(height: 18),

                                const Text(
                                  "Teacher Review",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 15),

                                Card(
                                  elevation: 0,
                                  color: const Color(0xffF8FAFC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 28,
                                              backgroundColor:
                                                  Colors.blue,
                                              child: Icon(
                                                Icons.person,
                                                color:
                                                    Colors.white,
                                                size: 28,
                                              ),
                                            ),

                                            const SizedBox(
                                                width: 15),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    homework
                                                        .teacher,
                                                    style:
                                                        const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight
                                                              .bold,
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                      height: 4),

                                                  const Text(
                                                    "Subject Teacher",
                                                    style:
                                                        TextStyle(
                                                      color:
                                                          Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 20),

                                        _row(
                                          "Reviewed On",
                                          homework.reviewedOn,
                                        ),

                                        _row(
                                          "Teacher Feedback",
                                          homework
                                              .teacherRemarks,
                                        ),

                                        _row(
                                          "Marks Awarded",
                                          homework
                                              .marksAwarded,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                   onPressed: () {

   if (isStudent) {
     homework.status = "Submitted";

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Homework submitted successfully."),
      ),
    );

    Navigator.pop(context);

    return;
   }
   

   showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
            SizedBox(width: 10),
            Text("Parent Dashboard"),
          ],
        ),
        content: const Text(
          "Homework submission is available only through the Student Portal.\n\n"
          "Please ask your child to login using their Student ID and submit the homework.\n\n"
          "This ensures the submission is made by the student and recorded correctly.",
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ),
        ],
      );
    },
   );
   },
              

                                    child: const Text(
                                      "Submit Homework",
                                    ),
                                  ),
                                ),

                              ] else ...[
                                                                const Divider(),

                                const SizedBox(height: 15),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Offline Submission",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      Text(
                                        "Submit this homework physically to ${homework.teacher} before ${homework.dueDate}.",
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                const Divider(),

                                const SizedBox(height: 18),

                                const Text(
                                  "Teacher Review",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 15),

                                Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [

                                        _row(
                                          "Remarks",
                                          homework.teacherRemarks,
                                        ),

                                        const Divider(),

                                        _row(
                                          "Marks Awarded",
                                          homework.marksAwarded,
                                        ),

                                        const Divider(),

                                        _row(
                                          "Reviewed On",
                                          homework.reviewedOn,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 25),

                                ElevatedButton(
  onPressed: () {
    if (isStudent) {
      // Update homework status
      homework.status = "Submitted";

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Homework submitted successfully.",
          ),
        ),
      );

      Navigator.pop(context);

      return;
    }

    // Parent Portal
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.blue,
              ),
              SizedBox(width: 10),
              Text("Parent Dashboard"),
            ],
          ),
          content: const Text(
            "Homework submission is available only through the Student Portal.\n\n"
            "Please ask your child to login using their Student ID and submit the homework.\n\n"
            "This ensures the submission is made by the student and recorded correctly.",
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ),
          ],
        );
      },
    );
  },
  child: const Text("Submit Homework"),
),

                              ],
                                                          ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
          );
   
    }

     

/// =======================================
/// Reusable Row Widget
/// =======================================

Widget _row(
  String title,
  String value,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 170,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}