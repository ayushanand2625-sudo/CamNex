import 'package:flutter/material.dart';

class CardQuickActions extends StatelessWidget {
  final VoidCallback onTransactions;
  final VoidCallback onCardDetails;

  const CardQuickActions({
    super.key,
    required this.onTransactions,
    required this.onCardDetails,
  });

  Widget _action({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.all(17),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(16),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,

                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: Icon(
                  icon,
                  color: color,
                ),
              ),

              const SizedBox(width: 12),

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
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        color:
                            Colors.grey.shade600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            _action(
              icon: Icons.receipt_long_rounded,
              title: "Transactions",
              subtitle: "View payment history",
              color: Colors.blue,
              onTap: onTransactions,
            ),

            const SizedBox(width: 14),

            _action(
              icon: Icons.credit_card_rounded,
              title: "Card Details",
              subtitle: "View card information",
              color: Colors.purple,
              onTap: onCardDetails,
            ),
          ],
        ),
      ],
    );
  }
}