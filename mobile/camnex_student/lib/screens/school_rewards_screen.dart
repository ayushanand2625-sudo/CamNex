import 'package:flutter/material.dart';

import '../data/school_reward_data.dart';
import '../widgets/reward_tile.dart';
import '../widgets/reward_summary_card.dart';

class SchoolRewardsScreen extends StatefulWidget {
  const SchoolRewardsScreen({
    super.key,
  });

  @override
  State<SchoolRewardsScreen> createState() =>
      _SchoolRewardsScreenState();
}

class _SchoolRewardsScreenState
    extends State<SchoolRewardsScreen> {
  final ScrollController _scrollController =
      ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showClassLeaderboard(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Top 10 Students - Class VIII",
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text("1. Riya Sharma"),
            Text("2. Ayush Sharma"),
            Text("3. Aarav Singh"),
            Text("4. Priya Verma"),
            Text("5. Aditya Kumar"),
            Text("6. Ananya Singh"),
            Text("7. Rahul Gupta"),
            Text("8. Kavya Sharma"),
            Text("9. Mohit Verma"),
            Text("10. Arjun Kumar"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showSectionLeaderboard(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Top 10 Students - Section VIII-A",
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text("1. Riya Sharma"),
            Text("2. Ayush Sharma"),
            Text("3. Arjun Gupta"),
            Text("4. Kavya Sharma"),
            Text("5. Rahul Kumar"),
            Text("6. Priya Singh"),
            Text("7. Mohit Gupta"),
            Text("8. Ananya Sharma"),
            Text("9. Aditya Singh"),
            Text("10. Ishita Verma"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _studentInfoTile(
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rankCard({
    required String title,
    required String rank,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),

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

      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            rank,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xff2563EB),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 38,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,

        title: const Text(
          "School Rewards",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 8,
        radius: const Radius.circular(10),

        child: SingleChildScrollView(
          controller: _scrollController,

          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // =================================================
              // HEADER
              // =================================================

              const Text(
                "School Rewards",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "View your academic achievements, rankings and rewards.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 22),

              // =================================================
              // STUDENT INFORMATION
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(16),
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
                  builder:
                      (context, constraints) {
                    final isWide =
                        constraints.maxWidth >=
                            700;

                    final items = [
                      _studentInfoTile(
                        "Student",
                        "Ayush Sharma",
                      ),
                      _studentInfoTile(
                        "Class",
                        "VIII - A",
                      ),
                      _studentInfoTile(
                        "Academic Year",
                        "2026 - 2027",
                      ),
                    ];

                    if (isWide) {
                      return Row(
                        children: [
                          Expanded(
                            child: items[0],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: items[1],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: items[2],
                          ),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        items[0],
                        const SizedBox(height: 12),
                        items[1],
                        const SizedBox(height: 12),
                        items[2],
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // =================================================
              // LEADERBOARD
              // =================================================

              const Text(
                "Leaderboard",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              LayoutBuilder(
                builder:
                    (context, constraints) {
                  final isWide =
                      constraints.maxWidth >=
                          700;

                  final classCard = _rankCard(
                    title: "Class Rank",
                    rank: "#3",
                    buttonText:
                        "View Top 10 Students of Class",
                    onPressed: () {
                      _showClassLeaderboard(
                        context,
                      );
                    },
                  );

                  final sectionCard =
                      _rankCard(
                    title: "Section Rank",
                    rank: "#12",
                    buttonText:
                        "View Top 10 Students of Section",
                    onPressed: () {
                      _showSectionLeaderboard(
                        context,
                      );
                    },
                  );

                  if (isWide) {
                    return Row(
                      children: [
                        Expanded(
                          child: classCard,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: sectionCard,
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      classCard,
                      const SizedBox(height: 15),
                      sectionCard,
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),

              // =================================================
              // ACHIEVEMENTS
              // =================================================

              const Text(
                "Achievements",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              ...schoolRewards.map(
                (reward) => RewardTile(
                  reward: reward,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}