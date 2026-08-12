import 'package:flutter/material.dart';
import '../models/canteen_purchase.dart';

void showCanteenDetails(
  BuildContext context,
  CanteenPurchase purchase,
) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 650,
            maxHeight: 750,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // =====================================================
                // HEADER
                // =====================================================

                Row(
                  children: [

                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.receipt_long_rounded,
                        color: Colors.blue,
                        size: 25,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Transaction Details",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            "Canteen purchase receipt",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // =====================================================
                // TRANSACTION STATUS
                // =====================================================

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            const Text(
                              "Transaction ID",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              purchase.transactionId,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Icon(
                              Icons.check_circle,
                              size: 15,
                              color: Colors.green.shade700,
                            ),

                            const SizedBox(width: 5),

                            Text(
                              purchase.status,
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // =====================================================
                // STUDENT DETAILS
                // =====================================================

                _sectionTitle(
                  Icons.person_outline,
                  "Student Details",
                ),

                const SizedBox(height: 12),

                _infoGrid([
                  _infoItem(
                    "Student",
                    "Ayush Sharma",
                  ),
                  _infoItem(
                    "Admission No.",
                    "CNX24018",
                  ),
                  _infoItem(
                    "Class",
                    "VIII-A",
                  ),
                  _infoItem(
                    "Card Number",
                    "XXXX XXXX 4821",
                  ),
                ]),

                const SizedBox(height: 24),

                // =====================================================
                // PURCHASE DETAILS
                // =====================================================

                _sectionTitle(
                  Icons.shopping_bag_outlined,
                  "Purchase Details",
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [

                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.restaurant,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              purchase.itemName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              "Quantity: 1",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Text(
                        "₹150",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                _amountRow("Subtotal", "₹140"),
                _amountRow("GST", "₹10"),
                _amountRow("Discount", "₹0"),

                const Divider(height: 25),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: const [

                    Text(
                      "Grand Total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),

                    Text(
                      "₹150",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // =====================================================
                // PAYMENT DETAILS
                // =====================================================

                _sectionTitle(
                  Icons.account_balance_wallet_outlined,
                  "Payment Details",
                ),

                const SizedBox(height: 12),

                _infoGrid([
                  _infoItem(
                    "Payment Mode",
                    purchase.paymentMode,
                  ),
                  _infoItem(
                    "Balance Before",
                    "₹970",
                  ),
                  _infoItem(
                    "Amount Deducted",
                    "₹150",
                  ),
                  _infoItem(
                    "Balance After",
                    "₹820",
                  ),
                ]),

                const SizedBox(height: 18),

                // Balance summary

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.green.shade100,
                    ),
                  ),
                  child: Row(
                    children: [

                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.green.shade700,
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Remaining Card Balance",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "₹820",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // =====================================================
                // TRANSACTION INFORMATION
                // =====================================================

                _sectionTitle(
                  Icons.info_outline,
                  "Transaction Information",
                ),

                const SizedBox(height: 12),

                _infoGrid([
                  _infoItem(
                    "Date",
                    purchase.purchaseDate,
                  ),
                  _infoItem(
                    "Time",
                    "11:42 AM",
                  ),
                  _infoItem(
                    "POS Counter",
                    "Main Counter",
                  ),
                  _infoItem(
                    "Status",
                    purchase.status,
                  ),
                ]),

                const SizedBox(height: 28),

                // =====================================================
                // BUTTONS
                // =====================================================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end,
                  children: [

                    OutlinedButton.icon(
                      onPressed: () {
                        // PDF generation later
                      },
                      icon: const Icon(
                        Icons.download_outlined,
                        size: 18,
                      ),
                      label: const Text(
                        "Download Bill",
                      ),
                    ),

                    const SizedBox(width: 12),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


// ================================================================
// SECTION TITLE
// ================================================================

Widget _sectionTitle(
  IconData icon,
  String title,
) {
  return Row(
    children: [

      Icon(
        icon,
        size: 19,
        color: Colors.blue,
      ),

      const SizedBox(width: 8),

      Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}


// ================================================================
// INFO GRID
// ================================================================

Widget _infoGrid(
  List<Widget> children,
) {
  return Wrap(
    spacing: 15,
    runSpacing: 12,
    children: children,
  );
}


// ================================================================
// INFO ITEM
// ================================================================

Widget _infoItem(
  String title,
  String value,
) {
  return SizedBox(
    width: 275,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}


// ================================================================
// AMOUNT ROW
// ================================================================

Widget _amountRow(
  String title,
  String value,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 5,
    ),
    child: Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [

        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}