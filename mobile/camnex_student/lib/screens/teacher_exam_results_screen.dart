import 'package:flutter/material.dart';

class TeacherExamResultsScreen extends StatelessWidget {
  const TeacherExamResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exam Results")),
      body: const Center(
        child: Text(
          "Teacher Exam Results Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}