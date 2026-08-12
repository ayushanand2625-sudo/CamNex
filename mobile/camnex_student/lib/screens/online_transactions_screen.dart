import 'package:flutter/material.dart';

import '../data/online_transactions.dart';
import '../models/online_transaction.dart';
import '../widgets/payment_details_dialog.dart';

class OnlineTransactionsScreen extends StatelessWidget {
  const OnlineTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Transactions"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: onlineTransactions.length,
        itemBuilder: (context, index) {
          final OnlineTransaction tx =
              onlineTransactions[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 18),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    tx.date,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          tx.title,
                          style:
                              const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        "₹${tx.amount.toStringAsFixed(0)}",
                        style:
                            const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Paid via ${tx.paymentMethod}",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Align(
                    alignment:
                        Alignment.centerRight,
                    child: TextButton.icon(
                      icon: const Icon(
                          Icons.receipt_long),
                      label:
                          const Text("Details"),
                      onPressed: () {

                        showPaymentDetails(
                          context,
                          tx,
                        );

                      },
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}