import 'package:flutter/material.dart';

class CamnexBadgesHeader extends StatelessWidget {
  const CamnexBadgesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =====================================================
        // SECTION HEADER
        // =====================================================

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.workspace_premium_outlined,
                color: Colors.amber.shade700,
                size: 25,
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reward Categories",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF172033),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Explore the different CamNex achievement categories",
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

        const SizedBox(height: 20),

        // =====================================================
        // RESPONSIVE BADGES
        // =====================================================

        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int columns;

            if (width >= 1200) {
              columns = 5;
            } else if (width >= 900) {
              columns = 4;
            } else if (width >= 600) {
              columns = 3;
            } else if (width >= 380) {
              columns = 2;
            } else {
              columns = 1;
            }

            const spacing = 12.0;

            final cardWidth =
                (width - ((columns - 1) * spacing)) /
                    columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                _BadgeCard(
                  width: cardWidth,
                  title: "Category 1",
                  subtitle: "Rank #1",
                  image:
                      "assets/images/camnex_rewards/diamond_badge.png",
                  badgeColor: Colors.amber,
                  icon: Icons.emoji_events_outlined,
                ),

                _BadgeCard(
                  width: cardWidth,
                  title: "Category 2",
                  subtitle: "Rank #2",
                  image:
                      "assets/images/camnex_rewards/platinum_badge.png",
                  badgeColor: Colors.blueGrey,
                  icon: Icons.workspace_premium_outlined,
                ),

                _BadgeCard(
                  width: cardWidth,
                  title: "Category 3",
                  subtitle: "Rank #3",
                  image:
                      "assets/images/camnex_rewards/gold_badge.png",
                  badgeColor: Colors.orange,
                  icon: Icons.military_tech_outlined,
                ),

                _BadgeCard(
                  width: cardWidth,
                  title: "Category 4",
                  subtitle: "Rank #4 - #10",
                  image:
                      "assets/images/camnex_rewards/elite_badge.png",
                  badgeColor: Colors.blue,
                  icon: Icons.star_border_rounded,
                ),

                _BadgeCard(
                  width: cardWidth,
                  title: "Category 5",
                  subtitle: "Rank #11 - #20",
                  image:
                      "assets/images/camnex_rewards/merit_badge.png",
                  badgeColor: Colors.green,
                  icon: Icons.workspace_premium_outlined,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// =============================================================
// BADGE CARD
// =============================================================

class _BadgeCard extends StatelessWidget {
  final double width;
  final String title;
  final String subtitle;
  final String image;
  final Color badgeColor;
  final IconData icon;

  const _BadgeCard({
    required this.width,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.badgeColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isSmall = width < 180;

    return SizedBox(
      width: width,
      child: Container(
        padding: EdgeInsets.all(
          isSmall ? 12 : 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // =================================================
            // BADGE IMAGE
            // =================================================

            Container(
              width: isSmall ? 78 : 94,
              height: isSmall ? 78 : 94,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 13),

            // =================================================
            // CATEGORY
            // =================================================

            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isSmall ? 14 : 15,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 7),

            // =================================================
            // RANK
            // =================================================

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 14,
                    color: badgeColor,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      subtitle,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: badgeColor,
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