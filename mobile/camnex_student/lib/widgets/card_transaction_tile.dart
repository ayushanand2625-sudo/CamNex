import 'package:flutter/material.dart';

import '../models/card_transaction.dart';

class CardTransactionTile extends StatelessWidget {
  final CardTransaction transaction;

  const CardTransactionTile({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCredit = transaction.isCredit;

    final Color mainColor =
        isCredit ? Colors.green.shade700 : Colors.red.shade700;

    final Color lightColor =
        isCredit ? Colors.green.shade50 : Colors.red.shade50;

    final IconData transactionIcon = isCredit
        ? Icons.account_balance_wallet_rounded
        : Icons.shopping_cart_rounded;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        child: Row(
          children: [
            // =====================================================
            // TRANSACTION ICON
            // =====================================================

            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                transactionIcon,
                color: mainColor,
                size: 24,
              ),
            ),

            const SizedBox(width: 14),

            // =====================================================
            // TRANSACTION DETAILS
            // =====================================================

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    transaction.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(
                        isCredit
                            ? Icons.arrow_downward_rounded
                            : Icons.arrow_upward_rounded,
                        size: 13,
                        color: mainColor,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        isCredit
                            ? "Money Added"
                            : "Payment",
                        style: TextStyle(
                          fontSize: 11,
                          color: mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // =====================================================
            // AMOUNT
            // =====================================================

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${isCredit ? "+" : "-"} ₹${transaction.amount.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 16,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isCredit ? "CREDIT" : "DEBIT",
                    style: TextStyle(
                      fontSize: 9,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
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