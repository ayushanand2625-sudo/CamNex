import 'package:flutter/material.dart';

import '../models/school_reward.dart';
import 'reward_details_dialog.dart';

class RewardTile extends StatelessWidget {
  final SchoolReward reward;

  const RewardTile({
    super.key,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 550;

          // ================================================
          // SMALL SCREEN
          // ================================================

          if (isSmall) {
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    _buildIcon(),

                    const SizedBox(width: 14),

                    Expanded(
                      child: _buildRewardInfo(),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showRewardDetails(
                        context,
                        reward,
                      );
                    },

                    icon: const Icon(
                      Icons.visibility_outlined,
                      size: 18,
                    ),

                    label: const Text(
                      "View Details",
                    ),
                  ),
                ),
              ],
            );
          }

          // ================================================
          // LARGE SCREEN
          // ================================================

          return Row(
            children: [
              _buildIcon(),

              const SizedBox(width: 18),

              Expanded(
                child: _buildRewardInfo(),
              ),

              const SizedBox(width: 15),

              ElevatedButton.icon(
                onPressed: () {
                  showRewardDetails(
                    context,
                    reward,
                  );
                },

                icon: const Icon(
                  Icons.visibility_outlined,
                  size: 18,
                ),

                label: const Text(
                  "View Details",
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // REWARD ICON
  // ============================================================

  Widget _buildIcon() {
    return Container(
      width: 52,
      height: 52,

      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(14),
      ),

      child: const Icon(
        Icons.workspace_premium,
        size: 28,
        color: Colors.orange,
      ),
    );
  }

  // ============================================================
  // REWARD INFORMATION
  // ============================================================

  Widget _buildRewardInfo() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          reward.title,

          maxLines: 2,
          overflow: TextOverflow.ellipsis,

          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 7),

        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 15,
              color: Colors.grey.shade600,
            ),

            const SizedBox(width: 6),

            Flexible(
              child: Text(
                "Awarded on : ${reward.date}",

                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}