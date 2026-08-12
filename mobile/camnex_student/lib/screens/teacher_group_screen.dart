import 'package:flutter/material.dart';

class TeacherGroupScreen extends StatelessWidget {
  const TeacherGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teacher Group")),
      body: const Center(
        child: Text(
          "Teacher Group Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}