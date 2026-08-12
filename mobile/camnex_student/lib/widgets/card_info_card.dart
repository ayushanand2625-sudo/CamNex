import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CardInfoCard extends StatelessWidget {
  const CardInfoCard({
    super.key,
  });

  Widget _infoRow(
    String title,
    String value, {
    Color valueColor = AppTheme.textPrimary,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      child: Row(
        children: [
          // =================================================
          // ICON
          // =================================================

          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                icon,
                size: 18,
                color: AppTheme.primaryBlue,
              ),
            ),

            const SizedBox(width: 12),
          ],

          // =================================================
          // TITLE
          // =================================================

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ),

          // =================================================
          // VALUE
          // =================================================

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // =================================================
            // HEADER
            // =================================================

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue
                        .withOpacity(0.10),
                    borderRadius:
                        BorderRadius.circular(11),
                  ),

                  child: const Icon(
                    Icons.credit_card_rounded,
                    color: AppTheme.primaryBlue,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Card Information",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 3),

                      Text(
                        "Smart Card details",
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Divider(),

            // =================================================
            // STATUS
            // =================================================

            _infoRow(
              "Status",
              "Active",
              valueColor: Colors.green,
              icon: Icons.check_circle_outline,
            ),

            const Divider(height: 1),

            // =================================================
            // CARD NUMBER
            // =================================================

            _infoRow(
              "Card Number",
              "**** **** 4582",
              icon: Icons.credit_card_outlined,
            ),

            const Divider(height: 1),

            // =================================================
            // ISSUE DATE
            // =================================================

            _infoRow(
              "Issued On",
              "01 Apr 2025",
              icon: Icons.calendar_today_outlined,
            ),

            const Divider(height: 1),

            // =================================================
            // USAGE
            // =================================================

            _infoRow(
              "Usage",
              "Canteen & Library",
              icon: Icons.storefront_outlined,
            ),

            const SizedBox(height: 8),

            // =================================================
            // SECURITY INFORMATION
            // =================================================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 19,
                    color: Colors.blue.shade700,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Keep your Smart Card secure. "
                      "Do not share your card number or "
                      "account information with others.",
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.45,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}