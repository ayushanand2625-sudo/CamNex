import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import 'fee_payment_screen.dart';

class FeePaymentSuccessScreen extends StatelessWidget {
  final double amount;
  final String paymentMethod;

  const FeePaymentSuccessScreen({
    super.key,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    final transactionId =
        "FEE${DateTime.now().millisecondsSinceEpoch}";

    final date =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

    final time = TimeOfDay.now().format(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Successful"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 15),

            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.check,
                size: 55,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Fee Payment Successful",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "₹${amount.toStringAsFixed(2)} has been paid successfully.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
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
                      "Amount Paid",
                      "₹${amount.toStringAsFixed(2)}",
                    ),

                    _row(
                      "Payment Method",
                      paymentMethod,
                    ),

                    _row(
                      "Transaction ID",
                      transactionId,
                    ),

                    _row(
                      "Date",
                      date,
                    ),

                    _row(
                      "Time",
                      time,
                    ),

                    const Divider(),

                    const _StatusRow(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Your fee payment has been received successfully. The official receipt will be available in the Transactions section.",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.school),
                label: const Text(
                  "Back to Fee Payment",
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const FeePaymentScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _row(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Text(
            "Status",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Text(
          "Successful",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}