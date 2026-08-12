import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/online_transaction.dart';

void showPaymentDetails(
  BuildContext context,
  OnlineTransaction transaction,
) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    barrierColor: Colors.black26,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, _, _) {
      return const SizedBox();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6,
          sigmaY: 6,
        ),
        child: FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: .9,
              end: 1,
            ).animate(animation),
            child: Center(
              child: Container(
                width: 550,
                margin: const EdgeInsets.all(24),
                child: Material(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                  elevation: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [

                          const Icon(
                            Icons.receipt_long,
                            size: 60,
                            color: Colors.blue,
                          ),

                          const SizedBox(height: 15),

                          const Text(
                            "Payment Details",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 30),

                          _row(
                            "Transaction Type",
                            transaction.title,
                          ),

                          _row(
                            "Amount",
                            "₹${transaction.amount.toStringAsFixed(2)}",
                          ),

                          _row(
                            "Payment Method",
                            transaction.paymentMethod,
                          ),

                          _row(
                            "Transaction ID",
                            transaction.transactionId,
                          ),

                          _row(
                            "Reference No.",
                            transaction.referenceNo,
                          ),

                          _row(
                            "Date",
                            transaction.date,
                          ),

                          _row(
                            "Time",
                            transaction.time,
                          ),

                          _row(
                            "Status",
                            transaction.status,
                            valueColor:
                                Colors.green,
                          ),

                          _row(
                            "Remarks",
                            transaction.remarks,
                          ),

                          const SizedBox(height: 35),

                          Row(
                            children: [

                              Expanded(
                                child:
                                    OutlinedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Receipt download will be added soon.",
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.download,
                                  ),
                                  label: const Text(
                                    "Download Receipt",
                                  ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child:
                                    ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context);
                                  },
                                  child:
                                      const Text(
                                    "Close",
                                  ),
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _row(
  String title,
  String value, {
  Color valueColor = Colors.black,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
    ),
    child: Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        SizedBox(
          width: 170,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight:
                  FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),

      ],
    ),
  );
}