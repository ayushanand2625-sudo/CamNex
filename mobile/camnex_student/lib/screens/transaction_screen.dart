import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TransactionScreen extends StatelessWidget {
  final String studentName;
  final String studentClass;

  const TransactionScreen({
    super.key,
    required this.studentName,
    required this.studentClass,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        foregroundColor: AppTheme.textPrimary,

        title: const Text(
          "Card Transactions",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =================================================
            // STUDENT INFORMATION
            // =================================================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(18),

                border: Border.all(
                  color: AppTheme.border,
                ),
              ),

              child: Row(
                children: [

                  CircleAvatar(
                    radius: 28,

                    backgroundColor:
                        AppTheme.lightBlue,

                    child: const Icon(
                      Icons.person_outline,
                      color: AppTheme.primaryBlue,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Currently Viewing",
                          style: TextStyle(
                            color:
                                AppTheme.textSecondary,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          studentName,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color:
                                AppTheme.textPrimary,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          studentClass,
                          style: const TextStyle(
                            color:
                                AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =================================================
            // TRANSACTION SUMMARY
            // =================================================

            Row(
              children: [

                Expanded(
                  child: _summaryCard(
                    title: "Total Credits",
                    amount: "₹1,000",
                    icon: Icons
                        .arrow_downward_rounded,
                    color: AppTheme.success,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: _summaryCard(
                    title: "Total Spent",
                    amount: "₹870",
                    icon:
                        Icons.arrow_upward_rounded,
                    color: AppTheme.danger,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // =================================================
            // SECTION HEADER
            // =================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  "Transaction History",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: AppTheme.lightBlue,

                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Text(
                    "4 Transactions",
                    style: TextStyle(
                      color:
                          AppTheme.primaryBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // =================================================
            // TRANSACTION LIST
            // =================================================

            _transactionTile(
              icon: Icons.restaurant_rounded,
              title: "Canteen Purchase",
              subtitle: "School Canteen",
              date: "Today, 10:30 AM",
              amount: "- ₹50",
              amountColor: AppTheme.danger,
              iconColor: Colors.orange,
              type: "DEBIT",
            ),

            _transactionTile(
              icon: Icons.menu_book_rounded,
              title: "Library Fine",
              subtitle: "School Library",
              date: "Yesterday, 2:15 PM",
              amount: "- ₹20",
              amountColor: AppTheme.danger,
              iconColor: Colors.red,
              type: "DEBIT",
            ),

            _transactionTile(
              icon: Icons.directions_bus_rounded,
              title: "Bus Fee",
              subtitle: "Transport Department",
              date: "12 Jun 2026",
              amount: "- ₹800",
              amountColor: AppTheme.danger,
              iconColor: Colors.blue,
              type: "DEBIT",
            ),

            _transactionTile(
              icon: Icons.account_balance_wallet_rounded,
              title: "Wallet Recharge",
              subtitle: "Parent Portal",
              date: "10 Jun 2026",
              amount: "+ ₹1000",
              amountColor: AppTheme.success,
              iconColor: Colors.green,
              type: "CREDIT",
            ),

            const SizedBox(height: 15),

            // =================================================
            // SECURITY INFORMATION
            // =================================================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,

                borderRadius:
                    BorderRadius.circular(14),
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Icon(
                    Icons.info_outline,
                    color: AppTheme.primaryBlue,
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: Text(
                      "Transactions shown here are recorded against the student's Smart Card and cannot be modified from the student portal.",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SUMMARY CARD
  // =========================================================

  Widget _summaryCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: AppTheme.border,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              CircleAvatar(
                radius: 18,

                backgroundColor:
                    color.withOpacity(0.12),

                child: Icon(
                  icon,
                  color: color,
                  size: 19,
                ),
              ),

              const Spacer(),

              Icon(
                Icons.more_horiz,
                color:
                    Colors.grey.shade400,
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            amount,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TRANSACTION TILE
  // =========================================================

  Widget _transactionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String date,
    required String amount,
    required Color amountColor,
    required Color iconColor,
    required String type,
  }) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 14),

      elevation: 0,

      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),

        side: const BorderSide(
          color: AppTheme.border,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Row(
          children: [

            // ===============================================
            // ICON
            // ===============================================

            CircleAvatar(
              radius: 25,

              backgroundColor:
                  iconColor.withOpacity(0.12),

              child: Icon(
                icon,
                color: iconColor,
                size: 23,
              ),
            ),

            const SizedBox(width: 14),

            // ===============================================
            // DETAILS
            // ===============================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color:
                          AppTheme.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color:
                          AppTheme.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),

            // ===============================================
            // AMOUNT + TYPE
            // ===============================================

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end,

              children: [

                Text(
                  amount,
                  style: TextStyle(
                    color: amountColor,
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),

                  decoration: BoxDecoration(
                    color: amountColor
                        .withOpacity(0.10),

                    borderRadius:
                        BorderRadius.circular(8),
                  ),

                  child: Text(
                    type,
                    style: TextStyle(
                      color: amountColor,
                      fontSize: 9,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}