import 'package:flutter/material.dart';

import '../data/student_data.dart';
import '../models/student.dart';

class StudentProvider extends ChangeNotifier {
  Student _selectedStudent = students.first;

  Student get selectedStudent => _selectedStudent;

  // Card Transactions
  final List<Map<String, dynamic>> _transactions = [
    {
      "title": "Recharge",
      "subtitle": "Online Payment",
      "amount": 500.0,
      "isCredit": true,
      "date": DateTime.now(),
    },
    {
      "title": "Canteen",
      "subtitle": "Lunch",
      "amount": 120.0,
      "isCredit": false,
      "date": DateTime.now(),
    },
  ];

  List<Map<String, dynamic>> get transactions => _transactions;

  void selectStudent(Student student) {
    _selectedStudent = student;
    notifyListeners();
  }

  // Recharge Card
  void rechargeCard(double amount) {
    _selectedStudent.cardBalance += amount;

    _transactions.insert(0, {
      "title": "Recharge",
      "subtitle": "Online Payment",
      "amount": amount,
      "isCredit": true,
      "date": DateTime.now(),
    });

    notifyListeners();
  }

  // Spend from Card (Canteen/Library)
  void spendFromCard(
    double amount,
    String place,
  ) {
    if (_selectedStudent.cardBalance >= amount) {
      _selectedStudent.cardBalance -= amount;

      _transactions.insert(0, {
        "title": place,
        "subtitle": "Card Payment",
        "amount": amount,
        "isCredit": false,
        "date": DateTime.now(),
      });

      notifyListeners();
    }
  }
}