import 'package:flutter/material.dart';

class TeacherNoticeScreen extends StatelessWidget {
  const TeacherNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notice")),
      body: const Center(
        child: Text(
          "Teacher Notice Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}