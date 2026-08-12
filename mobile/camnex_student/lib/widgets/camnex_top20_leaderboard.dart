import 'package:flutter/material.dart';

import '../data/camnex_rewards_data.dart';

class CamnexTop20Leaderboard extends StatelessWidget {
  const CamnexTop20Leaderboard({super.key});

  String getRankBadge(int rank) {
    if (rank == 1) {
      return "assets/images/camnex_rewards/rank1.png";
    } else if (rank == 2) {
      return "assets/images/camnex_rewards/rank2.png";
    } else if (rank == 3) {
      return "assets/images/camnex_rewards/rank3.png";
    } else if (rank >= 4 && rank <= 10) {
      return "assets/images/camnex_rewards/rank4to10.png";
    } else {
      return "assets/images/camnex_rewards/rank11to20.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        // =====================================================
        // SECTION HEADER
        // =====================================================

        Row(
          children: [
            Container(
              width: isMobile ? 42 : 48,
              height: isMobile ? 42 : 48,
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.emoji_events_outlined,
                color: Colors.amber.shade700,
                size: isMobile ? 22 : 26,
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "Top 20 Leaderboard",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF172033),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Students leading the CamNex rankings",
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

        const SizedBox(height: 18),

        // =====================================================
        // LEADERBOARD
        // =====================================================

        Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: ExpansionTile(
              initiallyExpanded: true,
              tilePadding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 20,
                vertical: 4,
              ),
              childrenPadding:
                  EdgeInsets.only(
                bottom: isMobile ? 10 : 16,
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.format_list_numbered,
                    size: 21,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "View Top 20 Students",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              children: List.generate(
                leaderboardStudents.length,
                (index) {
                  final student =
                      leaderboardStudents[index];

                  return _buildStudentCard(
                    context,
                    student,
                    isMobile,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STUDENT CARD
  // ============================================================

  Widget _buildStudentCard(
    BuildContext context,
    dynamic student,
    bool isMobile,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 16,
        vertical: 6,
      ),
      child: Container(
        padding: EdgeInsets.all(
          isMobile ? 13 : 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: isMobile
            ? _buildMobileStudentLayout(
                student,
              )
            : _buildDesktopStudentLayout(
                student,
              ),
      ),
    );
  }

  // ============================================================
  // MOBILE LAYOUT
  // ============================================================

  Widget _buildMobileStudentLayout(
    dynamic student,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _rankBadge(
              student.rank,
              56,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w800,
                      color: Color(0xFF172033),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    student.schoolName,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            _xpBox(student.points),
          ],
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: _rankColor(
              student.rank,
            ).withOpacity(0.08),
            borderRadius:
                BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.workspace_premium_outlined,
                size: 17,
                color: _rankColor(
                  student.rank,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                "Rank #${student.rank}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _rankColor(
                    student.rank,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DESKTOP / TABLET LAYOUT
  // ============================================================

  Widget _buildDesktopStudentLayout(
    dynamic student,
  ) {
    return Row(
      children: [
        _rankBadge(
          student.rank,
          65,
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                student.name,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight:
                      FontWeight.w800,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 5),

              Text(
                student.schoolName,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color:
                      Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 7),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: _rankColor(
                    student.rank,
                  ).withOpacity(0.08),
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                child: Text(
                  "Rank #${student.rank}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w700,
                    color: _rankColor(
                      student.rank,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 20),

        _xpBox(student.points),
      ],
    );
  }

  // ============================================================
  // RANK BADGE
  // ============================================================

  Widget _rankBadge(
    int rank,
    double size,
  ) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(14),
        color: Colors.grey.shade50,
      ),
      padding: const EdgeInsets.all(5),
      child: Image.asset(
        getRankBadge(rank),
        fit: BoxFit.contain,
      ),
    );
  }

  // ============================================================
  // XP BOX
  // ============================================================

  Widget _xpBox(
    int points,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius:
            BorderRadius.circular(12),
        border: Border.all(
          color: Colors.orange.shade100,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/camnex_rewards/xp.png",
            height: 27,
            width: 27,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 3),

          Text(
            "$points",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF172033),
            ),
          ),

          Text(
            "XP",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // RANK COLOR
  // ============================================================

  Color _rankColor(int rank) {
    if (rank == 1) {
      return Colors.amber.shade700;
    }

    if (rank == 2) {
      return Colors.blueGrey.shade600;
    }

    if (rank == 3) {
      return Colors.brown.shade500;
    }

    if (rank <= 10) {
      return Colors.blue.shade700;
    }

    return Colors.grey.shade700;
  }
}