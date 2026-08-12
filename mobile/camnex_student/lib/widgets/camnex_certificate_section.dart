import 'package:flutter/material.dart';

import '../data/camnex_rewards_data.dart';

class CamnexCertificateSection extends StatelessWidget {
  const CamnexCertificateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Achievement Certificate",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(
        "Certificate Name",
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 5),

      Text(
        myReward.certificateName,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 15),

      Text(
        "Rank : #${myReward.rank}",
      ),

      const SizedBox(height: 8),

      Text(
        "Category : ${myReward.category}",
      ),

      const SizedBox(height: 8),

      Text(
        "Academic Session : ${myReward.academicSession}",
      ),

      const SizedBox(height: 8),

      Text(
        "Status : ${myReward.status}",
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
),
            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // View Certificate Logic
                    },
                    icon: const Icon(Icons.visibility),
                    label: const Text(
                      "View Certificate",
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Download Certificate Logic
                    },
                    icon: const Icon(Icons.download),
                    label: const Text(
                      "Download PDF",
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Your certificate is generated dynamically using your rank, name and academic session.",
                style: TextStyle(
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}