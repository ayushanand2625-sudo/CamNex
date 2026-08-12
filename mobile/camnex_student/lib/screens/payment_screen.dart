import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final double amount;

  const PaymentScreen({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.account_balance_wallet,
                size: 90,
                color: Colors.blue,
              ),

              const SizedBox(height: 30),

              const Text(
                "Recharge Amount",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "₹${amount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Payment Successful",
                        ),
                      ),
                    );

                    Navigator.pop(context);

                  },
                  child: const Text(
                    "Pay Now",
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}