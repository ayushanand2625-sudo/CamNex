import 'package:flutter/material.dart';

import '../data/homework_data.dart';
import '../models/homework.dart';

class ParentHomeworkProvider extends ChangeNotifier {
  // Parent gets a separate copy of homework
  final List<Homework> _homework =
      homeworkList.map((e) => e.copy()).toList();

  List<Homework> get homework => _homework;

  void refreshHomework() {
    notifyListeners();
  }
}