import 'package:flutter/material.dart';

import '../widgets/camnex_badges_header.dart';
import '../widgets/camnex_leaderboard_updates.dart';
import '../widgets/camnex_my_rewards.dart';
import '../widgets/camnex_top20_leaderboard.dart';

class CamnexRewardsScreen extends StatelessWidget {
  const CamnexRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CamNex Rewards"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CamnexBadgesHeader(),

              SizedBox(height: 24),

              CamnexLeaderboardUpdates(),

              SizedBox(height: 24),

              CamnexTop20Leaderboard(),

              SizedBox(height: 24),

              CamnexMyRewards(),
            ],
          ),
        ),
      ),
    );
  }
}