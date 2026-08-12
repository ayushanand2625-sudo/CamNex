import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import 'payment_success_screen.dart';

class PaymentSummaryScreen extends StatefulWidget {
  final double rechargeAmount;

  const PaymentSummaryScreen({
    super.key,
    required this.rechargeAmount,
  });

  @override
  State<PaymentSummaryScreen> createState() =>
      _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState
    extends State<PaymentSummaryScreen> {

  String paymentMethod = "UPI";

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<StudentProvider>();

    final student = provider.selectedStudent;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Summary"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Recharge Summary",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),

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
                      "Current Balance",
                      "₹${student.cardBalance.toStringAsFixed(2)}",
                    ),

                   _row(
  "Recharge Amount",
  "₹${widget.rechargeAmount.toStringAsFixed(2)}",
),

_row(
  "Balance After Recharge",
  "₹${(student.cardBalance + widget.rechargeAmount).toStringAsFixed(2)}",
),

const Divider(),

_row(
  "Total Amount",
  "₹${widget.rechargeAmount.toStringAsFixed(2)}",
  bold: true,
),
                    const Divider(),

_row(
  "Payment Method",
  paymentMethod,
),
                  ],
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
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                });
              },
              title: const Text("UPI"),
            ),

            RadioListTile(
              value: "Debit Card",
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                });
              },
              title: const Text("Debit Card"),
            ),

            RadioListTile(
              value: "Credit Card",
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                });
              },
              title: const Text("Credit Card"),
            ),

            RadioListTile(
              value: "Net Banking",
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                });
              },
              title: const Text("Net Banking"),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(

onPressed: () async {
  // Simulate payment processing
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return;

  Navigator.pop(context); // Close loading dialog

  provider.rechargeCard(widget.rechargeAmount);

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => PaymentSuccessScreen(
        amount: widget.rechargeAmount,
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

  Widget _row(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
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
              fontWeight: bold
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}