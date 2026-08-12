import 'package:flutter/material.dart';

class CamnexLeaderboardUpdates extends StatelessWidget {
  const CamnexLeaderboardUpdates({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: isMobile ? 42 : 48,
                  height: isMobile ? 42 : 48,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.leaderboard_outlined,
                    color: Colors.blue.shade700,
                    size: isMobile ? 22 : 26,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leaderboard Updates",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF172033),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Track your current CamNex ranking",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // =====================================================
            // SESSION + UPDATE INFORMATION
            // =====================================================

            if (isMobile)
              Column(
                children: [
                  _infoBox(
                    icon: Icons.school_outlined,
                    title: "Academic Session",
                    value: "2026 - 2027",
                  ),
                  const SizedBox(height: 12),
                  _infoBox(
                    icon: Icons.update_outlined,
                    title: "Leaderboard Updates In",
                    value: "0 Days",
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: _infoBox(
                      icon: Icons.school_outlined,
                      title: "Academic Session",
                      value: "2026 - 2027",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _infoBox(
                      icon: Icons.update_outlined,
                      title: "Leaderboard Updates In",
                      value: "0 Days",
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 22),

            Divider(
              color: Colors.grey.shade200,
              height: 1,
            ),

            const SizedBox(height: 20),

            // =====================================================
            // DESCRIPTION
            // =====================================================

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 14 : 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.public_outlined,
                    size: 21,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Showing Top 20 Students Across All CamNex Schools",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF303846),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =====================================================
            // RANK RANGE
            // =====================================================

            const Text(
              "Leaderboard Rank Range",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF303846),
              ),
            ),

            const SizedBox(height: 12),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      height: 12,
                      color: Colors.red.shade400,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 12,
                      color: Colors.orange.shade400,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 12,
                      color: Colors.green.shade500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _rankLabel(
                  "#20",
                  Colors.red.shade700,
                ),
                _rankLabel(
                  "#10",
                  Colors.orange.shade700,
                ),
                _rankLabel(
                  "#1",
                  Colors.green.shade700,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =====================================================
            // CURRENT RANK
            // =====================================================

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade50,
                    Colors.indigo.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.12),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.emoji_events_outlined,
                      color: Colors.amber.shade700,
                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Current Rank",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "#2",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF172033),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (!isMobile)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Top Performer",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.green.shade700,
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

  // ============================================================
  // INFO BOX
  // ============================================================

  Widget _infoBox({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.blue.shade700,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // RANK LABEL
  // ============================================================

  Widget _rankLabel(
    String text,
    Color color,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: color,
      ),
    );
  }
}