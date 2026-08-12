import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import '../theme/app_theme.dart';

import '../widgets/card_balance_card.dart';
import '../widgets/card_quick_actions.dart';
import '../widgets/card_transaction_tile.dart';

import '../data/card_transaction_data.dart';

import 'recharge_screen.dart';
import 'transaction_screen.dart';
import 'card_details_screen.dart';

class CardScreen extends StatelessWidget {
  final bool isStudent;

  const CardScreen({
    super.key,
    this.isStudent = false,
  });

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryBlue,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Smart Card",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              "Campus digital wallet",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            tooltip: "Card Details",
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CardDetailsScreen(),
                ),
              );
            },
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          30,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==================================================
            // WELCOME SECTION
            // ==================================================

            Text(
              "Hello, ${student.name.split(" ").first} 👋",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Manage your campus Smart Card",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 22),

            // ==================================================
            // SMART CARD
            // ==================================================

            CardBalanceCard(
              studentName: student.name,
              studentClass: student.studentClass,
              balance: student.cardBalance,

              onRecharge: () {
                if (isStudent) {
                  _showStudentRechargeInfo(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RechargeScreen(),
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 22),

            // ==================================================
            // CARD STATUS
            // ==================================================

            _buildStatusCard(),

            const SizedBox(height: 30),

            // ==================================================
            // QUICK ACTIONS
            // ==================================================

            CardQuickActions(
              onTransactions: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TransactionScreen(
                      studentName: student.name,
                      studentClass: student.studentClass,
                    ),
                  ),
                );
              },

              onCardDetails: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CardDetailsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            // ==================================================
            // USAGE SUMMARY
            // ==================================================

            const Text(
              "Card Usage",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _buildUsageCard(
                    icon: Icons.restaurant_rounded,
                    title: "Canteen",
                    value: "₹1,240",
                    color: Colors.orange,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: _buildUsageCard(
                    icon: Icons.menu_book_rounded,
                    title: "Library",
                    value: "₹120",
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _buildUsageCard(
                    icon: Icons.local_printshop_rounded,
                    title: "Printing",
                    value: "₹85",
                    color: Colors.purple,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: _buildUsageCard(
                    icon: Icons.payments_rounded,
                    title: "Total Used",
                    value: "₹1,445",
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ==================================================
            // RECENT TRANSACTIONS HEADER
            // ==================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Transactions",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransactionScreen(
                          studentName: student.name,
                          studentClass: student.studentClass,
                        ),
                      ),
                    );
                  },
                  child: const Text("View All"),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ==================================================
            // TRANSACTIONS
            // ==================================================

            Card(
              elevation: 1,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: cardTransactions.isEmpty
                  ? _emptyTransactions()
                  : ListView.separated(
                      shrinkWrap: true,

                      physics:
                          const NeverScrollableScrollPhysics(),

                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),

                      itemCount:
                          cardTransactions.length > 5
                              ? 5
                              : cardTransactions.length,

                      separatorBuilder: (_, _) =>
                          const Divider(
                            height: 1,
                            indent: 75,
                          ),

                      itemBuilder: (context, index) {
                        return CardTransactionTile(
                          transaction:
                              cardTransactions[index],
                        );
                      },
                    ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // SECURITY NOTICE
            // ==================================================

            _buildSecurityNotice(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // STUDENT RECHARGE INFORMATION
  // ============================================================

  void _showStudentRechargeInfo(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Row(
            children: [
              Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.blue,
              ),

              SizedBox(width: 10),

              Expanded(
                child: Text(
                  "Recharge Smart Card",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),

          content: const Text(
            "Smart Card recharge is available only through the Parent Portal.\n\n"
            "Please ask your parent or guardian to login to the Parent Portal and recharge your card.\n\n"
            "This keeps payments secure and maintains accurate transaction records.",
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),

          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Got it"),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // STATUS CARD
  // ============================================================

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.green.shade100,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,

            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Card Active",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "Your Smart Card is ready to use",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),

            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: const Text(
              "ACTIVE",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // USAGE CARD
  // ============================================================

  Widget _buildUsageCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(height: 13),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY TRANSACTIONS
  // ============================================================

  Widget _emptyTransactions() {
    return Padding(
      padding: const EdgeInsets.all(35),

      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 50,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 12),

          Text(
            "No transactions yet",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "Your Smart Card transactions will appear here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECURITY NOTICE
  // ============================================================

  Widget _buildSecurityNotice() {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius:
            BorderRadius.circular(15),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.security_rounded,
            color: Colors.blue.shade700,
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Secure Campus Payments",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "All Smart Card transactions are securely recorded and can be reviewed from your transaction history.",
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}