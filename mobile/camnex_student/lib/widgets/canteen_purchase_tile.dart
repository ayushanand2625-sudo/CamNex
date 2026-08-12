import 'package:flutter/material.dart';

import '../models/canteen_purchase.dart';
import 'canteen_details_dialog.dart';

class CanteenPurchaseTile extends StatelessWidget {
  final CanteenPurchase purchase;

  const CanteenPurchaseTile({
    super.key,
    required this.purchase,
  });

  Color _getStatusColor() {
    switch (purchase.status.toLowerCase()) {
      case "completed":
        return Colors.green;

      case "pending":
        return Colors.orange;

      case "cancelled":
      case "failed":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  Color _getStatusBackground() {
    switch (purchase.status.toLowerCase()) {
      case "completed":
        return Colors.green.shade50;

      case "pending":
        return Colors.orange.shade50;

      case "cancelled":
      case "failed":
        return Colors.red.shade50;

      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          // --------------------------------------------------
          // FOOD ICON
          // --------------------------------------------------

          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.fastfood_outlined,
              color: Colors.orange,
              size: 26,
            ),
          ),

          const SizedBox(width: 15),

          // --------------------------------------------------
          // PURCHASE DETAILS
          // --------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  purchase.itemName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1F2937),
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      purchase.purchaseDate,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Icon(
                      Icons.payment_outlined,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      purchase.paymentMode,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          // --------------------------------------------------
          // AMOUNT + STATUS
          // --------------------------------------------------

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${purchase.amount}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2563EB),
                ),
              ),

              const SizedBox(height: 7),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _getStatusBackground(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      purchase.status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // --------------------------------------------------
              // VIEW DETAILS
              // --------------------------------------------------

              TextButton(
                onPressed: () {
                  showCanteenDetails(
                    context,
                    purchase,
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 30),
                  tapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}