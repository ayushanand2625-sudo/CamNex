import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import 'Card_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final double amount;

  const PaymentSuccessScreen({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    final transactionId =
        "TXN${DateTime.now().millisecondsSinceEpoch}";

    final date =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

    final time =
        "${TimeOfDay.now().format(context)}";

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
                color: Colors.white,
                size: 55,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Recharge Successful",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "₹${amount.toStringAsFixed(2)} has been added to your Campus Smart Card.",
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
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  children: [

                    _row("Student",
                        student.name),

                    _row("Class",
                        student.studentClass),

                    _row(
                      "Amount Added",
                      "₹${amount.toStringAsFixed(2)}",
                    ),

                    _row(
                      "Updated Balance",
                      "₹${student.cardBalance.toStringAsFixed(2)}",
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

                    _row(
                      "Status",
                      "Successful",
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(18),
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
                        "The recharge amount has been credited to your Campus Smart Card and can now be used for purchases in the school canteen and library.",
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
                icon: const Icon(
                    Icons.credit_card),
                label: const Text(
                  "Back to Card",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                onPressed: () {

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const CardScreen(),
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
      padding:
          const EdgeInsets.symmetric(
        vertical: 10,
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
              fontWeight:
                  FontWeight.w600,
            ),
          ),

        ],
      ),
    );
  }
}