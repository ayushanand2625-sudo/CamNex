import 'package:flutter/material.dart';
import '../models/canteen_item.dart';

class CanteenMenuCard extends StatelessWidget {
  final CanteenItem item;

  const CanteenMenuCard({
    super.key,
    required this.item,
  });

  Color _getCategoryColor() {
    switch (item.category.toLowerCase()) {
      case "snacks":
        return Colors.orange;
      case "beverages":
        return Colors.blue;
      case "meals":
        return Colors.green;
      case "dessert":
        return Colors.pink;
      default:
        return const Color(0xff2563EB);
    }
  }

  IconData _getCategoryIcon() {
    switch (item.category.toLowerCase()) {
      case "snacks":
        return Icons.fastfood_outlined;
      case "beverages":
        return Icons.local_drink_outlined;
      case "meals":
        return Icons.restaurant_outlined;
      case "dessert":
        return Icons.icecream_outlined;
      default:
        return Icons.restaurant_menu_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor();

    final isAvailable =
        item.status.toLowerCase() == "available";

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
              color: categoryColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _getCategoryIcon(),
              color: categoryColor,
              size: 26,
            ),
          ),

          const SizedBox(width: 15),

          // --------------------------------------------------
          // ITEM DETAILS
          // --------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1F2937),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  item.category,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "₹${item.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2563EB),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // --------------------------------------------------
          // STATUS
          // --------------------------------------------------

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isAvailable
                  ? Colors.green.shade50
                  : Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isAvailable
                        ? Colors.green
                        : Colors.red,
                  ),
                ),

                const SizedBox(width: 6),

                Text(
                  item.status,
                  style: TextStyle(
                    color: isAvailable
                        ? Colors.green.shade700
                        : Colors.red.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}