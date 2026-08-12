import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ParentRecentTransactions extends StatelessWidget {
  final VoidCallback? onViewAll;

  const ParentRecentTransactions({
    super.key,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return _sectionCard(
      title: 'Card Transactions',
      icon: Icons.receipt_long_outlined,
      onViewAll: onViewAll,
      child: Column(
        children: [
          _transactionItem(
            icon: Icons.restaurant_outlined,
            title: 'Canteen',
            date: 'Today, 10:30 AM',
            amount: '- ₹50',
          ),

          const Divider(
            height: 1,
            color: AppTheme.border,
          ),

          _transactionItem(
            icon: Icons.local_library_outlined,
            title: 'Library Fine',
            date: 'Yesterday, 2:15 PM',
            amount: '- ₹20',
          ),

          const Divider(
            height: 1,
            color: AppTheme.border,
          ),

          _transactionItem(
            icon: Icons.directions_bus_outlined,
            title: 'Bus Fee',
            date: '12 Jun 2026',
            amount: '- ₹800',
          ),
        ],
      ),
    );
  }

  // ============================================
  // TRANSACTION ITEM
  // ============================================

  Widget _transactionItem({
    required IconData icon,
    required String title,
    required String date,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),

      child: Row(
        children: [
          // ==========================================
          // TRANSACTION ICON
          // ==========================================

          Container(
            width: 40,
            height: 40,

            decoration: BoxDecoration(
              // Light Blue Background
              color: AppTheme.lightBlue,

              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: Icon(
              icon,

              // Primary Blue
              color: AppTheme.primaryBlue,

              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          // ==========================================
          // TRANSACTION DETAILS
          // ==========================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w600,

                    color:
                        AppTheme.textPrimary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  date,

                  style: const TextStyle(
                    fontSize: 12,

                    color:
                        AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // ==========================================
          // AMOUNT
          // ==========================================

          Text(
            amount,

            style: const TextStyle(
              fontSize: 14,
              fontWeight:
                  FontWeight.w700,

              // Red = Expense
              color:
                  AppTheme.danger,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // SECTION CARD
  // ============================================

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
    VoidCallback? onViewAll,
  }) {
    return Container(
      padding:
          const EdgeInsets.all(20),

      decoration:
          BoxDecoration(
        // White Card
        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border:
            Border.all(
          color:
              AppTheme.border,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.02),

            blurRadius: 8,

            offset:
                const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        children: [
          // ==========================================
          // HEADER
          // ==========================================

          Row(
            children: [
              // Blue Section Icon
              Icon(
                icon,

                color:
                    AppTheme.primaryBlue,

                size: 22,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,

                  style:
                      const TextStyle(
                    fontSize: 17,

                    fontWeight:
                        FontWeight.w700,

                    color:
                        AppTheme.textPrimary,
                  ),
                ),
              ),

              // ========================================
              // VIEW ALL
              // ========================================

              TextButton(
                onPressed:
                    onViewAll,

                child:
                    const Text(
                  'View All',

                  style:
                      TextStyle(
                    color:
                        AppTheme.primaryBlue,

                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          child,
        ],
      ),
    );
  }
}