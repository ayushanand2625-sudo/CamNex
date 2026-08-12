import 'package:flutter/material.dart';

import 'dashboard_card.dart';
import 'quick_action.dart';

class DashboardContent
    extends StatelessWidget {
  const DashboardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.all(25),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            "Welcome, Ayush",
            style: TextStyle(
              fontSize: 34,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const Text(
            "Class 10 • Roll No. 23",
          ),

          const SizedBox(height: 30),

Wrap(
  spacing: 20,
  runSpacing: 20,
  children: const [

    DashboardCard(
      title: "CamNex Credits",
      subtitle: "500 Credits",
      color: Colors.orange,
      icon: Icons.emoji_events,
    ),

    DashboardCard(
      title: "Attendance",
      subtitle: "96%",
      color: Colors.blue,
      icon: Icons.school,
    ),

    DashboardCard(
      title: "School Rank",
      subtitle: "#27",
      color: Colors.purple,
      icon: Icons.leaderboard,
    ),

    DashboardCard(
      title: "Homework",
      subtitle: "3 Pending",
      color: Colors.indigo,
      icon: Icons.menu_book,
    ),

    DashboardCard(
      title: "Wallet",
      subtitle: "₹500",
      color: Colors.green,
      icon: Icons.account_balance_wallet,
    ),

    DashboardCard(
      title: "Transport",
      subtitle: "Bus-07",
      color: Colors.red,
      icon: Icons.directions_bus,
    ),
  ],
),
          const SizedBox(height: 30),

          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          const Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceAround,
            children: [

              QuickAction(
                icon:
                    Icons.qr_code,
                title:
                    "Scan Pay",
              ),

              QuickAction(
                icon:
                    Icons.add_card,
                title:
                    "Add Money",
              ),

              QuickAction(
                icon:
                    Icons.receipt,
                title:
                    "Bills",
              ),

              QuickAction(
                icon:
                    Icons.card_giftcard,
                title:
                    "Rewards",
              ),
            ],
          ),
        ],
      ),
    );
  }
}