import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import 'fee_payment_success_screen.dart';

class FeePaymentSummaryScreen extends StatelessWidget {
  final double totalAmount;
  final String paymentMethod;

  const FeePaymentSummaryScreen({
    super.key,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentProvider>();
    final student = provider.selectedStudent;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Summary"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Fee Payment Summary",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _row(
                      "Student",
                      student.name,
                    ),

                    _row(
                      "Class",
                      student.studentClass,
                    ),

                    _row(
                      "Outstanding Fee",
                      "₹${student.feeDue.toStringAsFixed(2)}",
                    ),

                    const Divider(),

                    _row(
                      "School Fee",
                      "₹3,500",
                    ),

                    _row(
                      "Transport Fee",
                      "₹500",
                    ),

                    _row(
                      "Library Fine",
                      "₹200",
                    ),

                    const Divider(),

                    _row(
                      "Total Amount",
                      "₹${totalAmount.toStringAsFixed(2)}",
                      bold: true,
                    ),

                    _row(
                      "Payment Method",
                      paymentMethod,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  await Future.delayed(
                    const Duration(seconds: 2),
                  );

                  if (!context.mounted) return;

                  Navigator.pop(context);

                  // We'll connect this to the provider next
                  // provider.payFees(totalAmount);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          FeePaymentSuccessScreen(
                        amount: totalAmount,
                        paymentMethod: paymentMethod,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Pay Now",
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

  static Widget _row(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight:
                  bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}