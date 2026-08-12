import 'package:flutter/material.dart';

import '../data/camnex_rewards_data.dart';

class CamnexProfileBadgeSection extends StatelessWidget {
  const CamnexProfileBadgeSection({super.key});

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
              "CamNex Profile Badge",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              myReward.profileBadgeName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            /// Profile Badge Preview
            Center(
              child: Image.asset(
                myReward.profileBadgeAsset,
                height: 180,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // View Badge Logic
                },
                icon: const Icon(Icons.visibility),
                label: const Text(
                  "View Profile Badge",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "This badge has been automatically added "
                "to your CamNex student profile and will "
                "be visible across the CamNex ecosystem.",
                style: TextStyle(
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Profile badges are permanent achievements "
                "earned through the CamNex Rewards Leaderboard "
                "and cannot be transferred or redeemed.",
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