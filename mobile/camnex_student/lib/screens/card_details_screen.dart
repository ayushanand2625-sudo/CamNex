import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import '../theme/app_theme.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryBlue,
        title: const Text(
          "Card Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =====================================================
            // DIGITAL CARD
            // =====================================================

            _buildDigitalCard(
              context,
              student.name,
              student.studentClass,
              student.cardBalance,
            ),

            const SizedBox(height: 28),

            // =====================================================
            // CARD STATUS
            // =====================================================

            const Text(
              "Card Status",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Row(
                  children: [

                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Active",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Your smart card is active and ready to use.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.verified,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // CARD INFORMATION
            // =====================================================

            const Text(
              "Card Information",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    _infoRow(
                      icon: Icons.badge_outlined,
                      title: "Card Number",
                      value: "CNX-2026-458921",
                    ),

                    const Divider(height: 28),

                    _infoRow(
                      icon: Icons.person_outline,
                      title: "Card Holder",
                      value: student.name,
                    ),

                    const Divider(height: 28),

                    _infoRow(
                      icon: Icons.school_outlined,
                      title: "Class",
                      value: student.studentClass,
                    ),

                    const Divider(height: 28),

                    _infoRow(
                      icon: Icons.calendar_today_outlined,
                      title: "Issue Date",
                      value: "12 June 2026",
                    ),

                    const Divider(height: 28),

                    _infoRow(
                      icon: Icons.event_available_outlined,
                      title: "Expiry Date",
                      value: "31 March 2032",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // CURRENT BALANCE
            // =====================================================

            const Text(
              "Current Balance",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),

              child: Row(
                children: [

                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: AppTheme.primaryBlue,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Available Balance",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),

                        SizedBox(height: 5),
                      ],
                    ),
                  ),

                  Text(
                    "₹${student.cardBalance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // CARD USAGE
            // =====================================================

            const Text(
              "Card Usage",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                children: [

                  _usageTile(
                    icon: Icons.restaurant_rounded,
                    iconColor: Colors.green,
                    title: "School Canteen",
                    subtitle:
                        "Food and refreshments",
                  ),

                  const Divider(
                    height: 1,
                    indent: 75,
                  ),

                  _usageTile(
                    icon: Icons.menu_book_rounded,
                    iconColor: Colors.blue,
                    title: "School Library",
                    subtitle:
                        "Library services and fines",
                  ),

                  const Divider(
                    height: 1,
                    indent: 75,
                  ),

                  _usageTile(
                    icon: Icons.local_activity_rounded,
                    iconColor: Colors.orange,
                    title: "Campus Services",
                    subtitle:
                        "Approved school facilities",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // SECURITY INFORMATION
            // =====================================================

            const Text(
              "Security & Important Information",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.orange.shade100,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  _securityItem(
                    Icons.location_on_outlined,
                    "Campus Only",
                    "This card can only be used inside the school campus.",
                  ),

                  const SizedBox(height: 16),

                  _securityItem(
                    Icons.money_off_outlined,
                    "No Cash Withdrawal",
                    "The card balance cannot be withdrawn as cash.",
                  ),

                  const SizedBox(height: 16),

                  _securityItem(
                    Icons.lock_outline,
                    "Keep Your Card Safe",
                    "Do not share your card details with anyone.",
                  ),

                  const SizedBox(height: 16),

                  _securityItem(
                    Icons.report_problem_outlined,
                    "Lost Card",
                    "Report a lost or damaged card immediately to the school administration.",
                  ),

                  const SizedBox(height: 16),

                  _securityItem(
                    Icons.account_balance_outlined,
                    "Recharge",
                    "Recharge transactions are securely recorded in the school system.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // =====================================================
            // CARD ID FOOTER
            // =====================================================

            Center(
              child: Column(
                children: [

                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.grey.shade500,
                    size: 25,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "CamNex Smart Card",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Secure • Digital • Campus Ready",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // DIGITAL CARD
  // =============================================================

  Widget _buildDigitalCard(
    BuildContext context,
    String studentName,
    String studentClass,
    double balance,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            AppTheme.primaryBlue,
            AppTheme.primaryBlue.withOpacity(0.75),
          ],
        ),

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              const Row(
                children: [

                  Icon(
                    Icons.credit_card_rounded,
                    color: Colors.white,
                    size: 28,
                  ),

                  SizedBox(width: 10),

                  Text(
                    "CamNex",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: const Row(
                  children: [

                    Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.greenAccent,
                    ),

                    SizedBox(width: 5),

                    Text(
                      "ACTIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 35),

          Text(
            studentName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            studentClass,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            "CNX-2026-458921",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text(
                    "AVAILABLE BALANCE",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "₹${balance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const Icon(
                Icons.contactless_rounded,
                color: Colors.white70,
                size: 36,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =============================================================
  // INFORMATION ROW
  // =============================================================

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [

        Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(
            icon,
            color: AppTheme.primaryBlue,
            size: 21,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
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

  // =============================================================
  // USAGE TILE
  // =============================================================

  Widget _usageTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),

      leading: Container(
        width: 45,
        height: 45,

        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),

        child: Icon(
          icon,
          color: iconColor,
        ),
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(subtitle),
      ),

      trailing: const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 21,
      ),
    );
  }

  // =============================================================
  // SECURITY ITEM
  // =============================================================

  Widget _securityItem(
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Icon(
          icon,
          color: Colors.orange.shade800,
          size: 22,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}