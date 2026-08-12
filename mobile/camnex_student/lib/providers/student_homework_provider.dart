import 'package:flutter/material.dart';

class StudentHomeworkProvider extends ChangeNotifier {
  final Map<String, String> _status = {};

  String getStatus(String title, String defaultStatus) {
    return _status[title] ?? defaultStatus;
  }

  void submitHomework(String title) {
    _status[title] = "Submitted";
    notifyListeners();
  }
}