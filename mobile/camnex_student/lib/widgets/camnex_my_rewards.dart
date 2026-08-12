import 'package:flutter/material.dart';

import '../data/camnex_rewards_data.dart';

class CamnexMyRewards extends StatelessWidget {
  const CamnexMyRewards({super.key});

  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color darkBlue = Color(0xFF172554);
  static const Color lightBlue = Color(0xFFEFF6FF);

  static const Color success = Color(0xFF16A34A);
  static const Color lightGreen = Color(0xFFF0FDF4);

  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);

  // ==========================================================
  // CERTIFICATE DIALOG
  // ==========================================================

  void _showCertificateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final dialogWidth =
            screenWidth > 700 ? 650.0 : screenWidth * 0.94;

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: dialogWidth,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  screenWidth < 400 ? 16 : 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------------------------------------------
                    // HEADER
                    // ------------------------------------------------

                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: lightBlue,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.workspace_premium_outlined,
                            color: primaryBlue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "Certificate Preview",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: textPrimary,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ------------------------------------------------
                    // CERTIFICATE
                    // ------------------------------------------------

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(16),
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 1.414,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10),
                                child: Image.asset(
                                  myReward.certificateAsset,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            // Student name
                            Positioned(
                              top: screenWidth < 400
                                  ? 80
                                  : 130,
                              left: 20,
                              right: 20,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  myReward.studentName,
                                  style: TextStyle(
                                    fontSize:
                                        screenWidth < 400
                                            ? 20
                                            : 26,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: screenWidth < 400
                                  ? 125
                                  : 180,
                              child: Text(
                                "Rank #${myReward.rank}",
                                style: TextStyle(
                                  fontSize:
                                      screenWidth < 400
                                          ? 14
                                          : 18,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),

                            Positioned(
                              top: screenWidth < 400
                                  ? 150
                                  : 215,
                              child: Text(
                                myReward.category,
                                style: TextStyle(
                                  fontSize:
                                      screenWidth < 400
                                          ? 13
                                          : 16,
                                  fontWeight:
                                      FontWeight.w500,
                                ),
                              ),
                            ),

                            Positioned(
                              top: screenWidth < 400
                                  ? 175
                                  : 245,
                              child: Text(
                                myReward.academicSession,
                                style: TextStyle(
                                  fontSize:
                                      screenWidth < 400
                                          ? 13
                                          : 16,
                                  fontWeight:
                                      FontWeight.w500,
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: screenWidth < 400
                                  ? 25
                                  : 45,
                              child: Text(
                                myReward.status,
                                style: TextStyle(
                                  fontSize:
                                      screenWidth < 400
                                          ? 13
                                          : 16,
                                  fontWeight:
                                      FontWeight.bold,
                                  color: success,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ------------------------------------------------
                    // ACTION BUTTONS
                    // ------------------------------------------------

                    LayoutBuilder(
                      builder:
                          (context, constraints) {
                        final isSmall =
                            constraints.maxWidth < 420;

                        if (isSmall) {
                          return Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child:
                                    OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                  ),
                                  label:
                                      const Text("Close"),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child:
                                    ElevatedButton.icon(
                                  onPressed: () {
                                    // Download Certificate Logic
                                  },
                                  icon: const Icon(
                                    Icons.download,
                                  ),
                                  label: const Text(
                                    "Download PDF",
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(
                              child:
                                  OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                  );
                                },
                                icon: const Icon(
                                  Icons.close,
                                ),
                                label:
                                    const Text("Close"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child:
                                  ElevatedButton.icon(
                                onPressed: () {
                                  // Download Certificate Logic
                                },
                                icon: const Icon(
                                  Icons.download,
                                ),
                                label: const Text(
                                  "Download PDF",
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // BADGE DIALOG
  // ==========================================================

  void _showBadgeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 520,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  screenWidth < 400 ? 18 : 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.military_tech_outlined,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "Profile Badge Preview",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: textPrimary,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    Center(
                      child: Container(
                        width: 220,
                        height: 220,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.amber.shade100,
                            width: 2,
                          ),
                        ),
                        child: Image.asset(
                          myReward.profileBadgeAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      myReward.profileBadgeName,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      "This badge has been automatically added "
                      "to your CamNex student profile and will be "
                      "visible across the CamNex ecosystem.",
                      style: TextStyle(
                        height: 1.55,
                        color: textSecondary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Profile badges are permanent achievements "
                      "earned through the CamNex rewards leaderboard "
                      "and cannot be transferred or redeemed.",
                      style: TextStyle(
                        height: 1.55,
                        color: textSecondary,
                      ),
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // MAIN SCREEN
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: borderColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width < 500
              ? 16
              : 24,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // =====================================================
            // TITLE
            // =====================================================

            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: lightBlue,
                    borderRadius:
                        BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.card_giftcard_outlined,
                    color: primaryBlue,
                    size: 25,
                  ),
                ),

                const SizedBox(width: 13),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Rewards",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: darkBlue,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Your CamNex achievements and rewards",
                        style: TextStyle(
                          fontSize: 13,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =====================================================
            // REWARD SUMMARY
            // =====================================================

            LayoutBuilder(
              builder: (context, constraints) {
                final isSmall =
                    constraints.maxWidth < 600;

                if (isSmall) {
                  return Column(
                    children: [
                      _buildSummaryCard(
                        icon: Icons.emoji_events_outlined,
                        title: "Rank Achieved",
                        value: "#${myReward.rank}",
                        color: Colors.amber,
                      ),
                      const SizedBox(height: 10),
                      _buildSummaryCard(
                        icon:
                            Icons.workspace_premium_outlined,
                        title: "Category",
                        value: myReward.category,
                        color: primaryBlue,
                      ),
                      const SizedBox(height: 10),
                      _buildSummaryCard(
                        icon:
                            Icons.calendar_today_outlined,
                        title: "Session",
                        value:
                            myReward.academicSession,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(height: 10),
                      _buildSummaryCard(
                        icon: Icons.verified_outlined,
                        title: "Status",
                        value: myReward.status,
                        color: success,
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        icon:
                            Icons.emoji_events_outlined,
                        title: "Rank Achieved",
                        value: "#${myReward.rank}",
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        icon:
                            Icons.workspace_premium_outlined,
                        title: "Category",
                        value: myReward.category,
                        color: primaryBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        icon:
                            Icons.calendar_today_outlined,
                        title: "Session",
                        value:
                            myReward.academicSession,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        icon: Icons.verified_outlined,
                        title: "Status",
                        value: myReward.status,
                        color: success,
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 28),

            // =====================================================
            // REWARD DETAILS
            // =====================================================

            _buildSectionTitle(
              "Reward Details",
              Icons.workspace_premium_outlined,
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius:
                    BorderRadius.circular(14),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Column(
                children: [
                  _buildRewardTile(
                    title: "Rank Achieved",
                    value: "#${myReward.rank}",
                  ),
                  const Divider(
                    height: 1,
                  ),
                  _buildRewardTile(
                    title: "Reward Category",
                    value: myReward.category,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  _buildRewardTile(
                    title: "Academic Session",
                    value:
                        myReward.academicSession,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  _buildRewardTile(
                    title: "Status",
                    value: myReward.status,
                    valueColor: success,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // REWARDS EARNED
            // =====================================================

            _buildSectionTitle(
              "CamNex Rewards Earned",
              Icons.card_giftcard_outlined,
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius:
                    BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.green.shade100,
                ),
              ),
              child: Column(
                children: [
                  _buildRewardActionTile(
                    icon:
                        Icons.workspace_premium_outlined,
                    title:
                        myReward.certificateName,
                    subtitle:
                        "Official CamNex achievement certificate",
                    buttonText: "View Certificate",
                    onPressed: () =>
                        _showCertificateDialog(
                      context,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: Divider(),
                  ),

                  _buildRewardActionTile(
                    icon:
                        Icons.military_tech_outlined,
                    title:
                        myReward.profileBadgeName,
                    subtitle:
                        "Permanent profile achievement badge",
                    buttonText: "View Badge",
                    onPressed: () =>
                        _showBadgeDialog(
                      context,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // REDEMPTION INFORMATION
            // =====================================================

            _buildSectionTitle(
              "Reward Redemption Information",
              Icons.info_outline,
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius:
                    BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.mail_outline,
                      color: primaryBlue,
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Text(
                      "If you are eligible for any physical "
                      "or digital rewards, you will receive "
                      "an email from CamNex containing your "
                      "reward voucher, coupon, or redemption "
                      "instructions.",
                      style: TextStyle(
                        height: 1.55,
                        color: textPrimary,
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

  // ==========================================================
  // SUMMARY CARD
  // ==========================================================

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius:
                  BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SECTION TITLE
  // ==========================================================

  Widget _buildSectionTitle(
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryBlue,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // REWARD TILE
  // ==========================================================

  Widget _buildRewardTile({
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textSecondary,
              ),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color:
                    valueColor ?? textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // REWARD ACTION TILE
  // ==========================================================

  Widget _buildRewardActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall =
            constraints.maxWidth < 500;

        if (isSmall) {
          return Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildRewardIcon(icon),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w700,
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color:
                                textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.visibility_outlined,
                    size: 18,
                  ),
                  label: Text(buttonText),
                ),
              ),
            ],
          );
        }

        return Row(
          children: [
            _buildRewardIcon(icon),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w700,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            OutlinedButton.icon(
              onPressed: onPressed,
              icon: const Icon(
                Icons.visibility_outlined,
                size: 18,
              ),
              label: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // REWARD ICON
  // ==========================================================

  Widget _buildRewardIcon(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Icon(
        icon,
        color: primaryBlue,
        size: 22,
      ),
    );
  }
}