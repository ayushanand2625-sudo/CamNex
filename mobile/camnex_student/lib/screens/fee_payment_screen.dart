import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import 'fee_payment_summary_screen.dart';

class FeePaymentScreen extends StatefulWidget {
  const FeePaymentScreen({super.key});

  @override
  State<FeePaymentScreen> createState() =>
      _FeePaymentScreenState();
}

class _FeePaymentScreenState
    extends State<FeePaymentScreen> {
  bool schoolFee = true;
  bool transportFee = true;
  bool libraryFine = true;

  String paymentMethod = "UPI";

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    double total = 0;

    if (schoolFee) total += 3500;
    if (transportFee) total += 500;
    if (libraryFine) total += 200;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fee Payment"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Student",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              student.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              student.studentClass,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet,
                ),
                title: const Text(
                  "Current Outstanding",
                ),
                trailing: Text(
                  "₹${student.feeDue.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Select Fee Items",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _feeTile(
              title: "School Fee",
              amount: 3500,
              value: schoolFee,
              onChanged: (v) {
                setState(() {
                  schoolFee = v!;
                });
              },
              onDetails: () {
                _showSchoolFee();
              },
            ),

            _feeTile(
              title: "Transport Fee",
              amount: 500,
              value: transportFee,
              onChanged: (v) {
                setState(() {
                  transportFee = v!;
                });
              },
              onDetails: () {
                _showTransport();
              },
            ),

            _feeTile(
              title: "Library Fine",
              amount: 200,
              value: libraryFine,
              onChanged: (v) {
                setState(() {
                  libraryFine = v!;
                });
              },
              onDetails: () {
                _showLibrary();
              },
            ),

            const SizedBox(height: 30),

            Card(
              color: Colors.blue.shade50,
              child: ListTile(
                title: const Text(
                  "Total Payable",
                ),
                trailing: Text(
                  "₹${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile(
              value: "UPI",
              groupValue: paymentMethod,
              onChanged: (v) {
                setState(() {
                  paymentMethod = v!;
                });
              },
              title: const Text("UPI"),
            ),

            RadioListTile(
              value: "Debit Card",
              groupValue: paymentMethod,
              onChanged: (v) {
                setState(() {
                  paymentMethod = v!;
                });
              },
              title: const Text("Debit Card"),
            ),

            RadioListTile(
              value: "Credit Card",
              groupValue: paymentMethod,
              onChanged: (v) {
                setState(() {
                  paymentMethod = v!;
                });
              },
              title: const Text("Credit Card"),
            ),

            RadioListTile(
              value: "Net Banking",
              groupValue: paymentMethod,
              onChanged: (v) {
                setState(() {
                  paymentMethod = v!;
                });
              },
              title: const Text("Net Banking"),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          FeePaymentSummaryScreen(
                        totalAmount: total,
                        paymentMethod:
                            paymentMethod,
                      ),
                    ),
                  );

                },
                child: const Text(
                  "Proceed to Pay",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _feeTile({
    required String title,
    required double amount,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required VoidCallback onDetails,
  }) {
    return Card(
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title),
        subtitle: Text("₹${amount.toStringAsFixed(0)}"),
        secondary: TextButton(
          onPressed: onDetails,
          child: const Text("Details"),
        ),
      ),
    );
  }

  void _showSchoolFee() {
    _dialog(
      "School Fee",
      "Tuition Fee : ₹2500\n"
      "Computer Lab : ₹300\n"
      "Science Lab : ₹200\n"
      "Activity Fee : ₹300\n"
      "Exam Fee : ₹200",
    );
  }

  void _showTransport() {
    _dialog(
      "Transport Fee",
      "Route : Route 7\n"
      "Pickup : Sector 45\n"
      "Drop : Sector 45\n"
      "Month : July 2026\n"
      "Amount : ₹500",
    );
  }

  void _showLibrary() {
    _dialog(
      "Library Fine",
      "Book : Mathematics\n"
      "Late Days : 5\n"
      "Fine : ₹200",
    );
  }

  void _dialog(String title, String body) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}