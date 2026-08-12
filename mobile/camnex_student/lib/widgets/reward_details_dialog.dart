import 'package:flutter/material.dart';

import '../models/school_reward.dart';
import 'certificate_preview_dialog.dart';

void showRewardDetails(
  BuildContext context,
  SchoolReward reward,
) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Icon(
                Icons.workspace_premium,
                color: Colors.orange,
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Text(
                "Achievement Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            IconButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),

        content: SizedBox(
          width: 500,

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // ==========================================
                // TITLE
                // ==========================================

                _detailItem(
                  "Achievement",
                  reward.title,
                  Icons.emoji_events_outlined,
                ),

                const SizedBox(height: 15),

                // ==========================================
                // CATEGORY
                // ==========================================

                _detailItem(
                  "Category",
                  reward.category,
                  Icons.category_outlined,
                ),

                const SizedBox(height: 15),

                // ==========================================
                // AWARD DATE
                // ==========================================

                _detailItem(
                  "Award Date",
                  reward.date,
                  Icons.calendar_today_outlined,
                ),

                const SizedBox(height: 15),

                // ==========================================
                // CERTIFICATE ID
                // ==========================================

                _detailItem(
                  "Certificate ID",
                  reward.certificateId,
                  Icons.badge_outlined,
                ),

                const SizedBox(height: 25),

                // ==========================================
                // DESCRIPTION
                // ==========================================

                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius:
                        BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),

                  child: Text(
                    reward.description,
                    style: const TextStyle(
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ================================================
        // ACTIONS
        // ================================================

        actions: [
          Wrap(
            spacing: 10,
            runSpacing: 10,

            alignment: WrapAlignment.end,

            children: [
              OutlinedButton.icon(
                onPressed: () {
                  showCertificatePreview(
                    context,
                    reward,
                  );
                },

                icon: const Icon(
                  Icons.workspace_premium_outlined,
                ),

                label: const Text(
                  "View Certificate",
                ),
              ),

              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "PDF Downloaded",
                      ),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.download_outlined,
                ),

                label: const Text(
                  "Download PDF",
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },

                child: const Text(
                  "Close",
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

// ============================================================
// DETAIL ITEM
// ============================================================

Widget _detailItem(
  String title,
  String value,
  IconData icon,
) {
  return Row(
    crossAxisAlignment:
        CrossAxisAlignment.start,

    children: [
      Container(
        padding: const EdgeInsets.all(9),

        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Icon(
          icon,
          size: 20,
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
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}