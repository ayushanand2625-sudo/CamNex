import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CamNex Dashboard"),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back, Ayush!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Wallet + CamNex Credits
            Row(
              children: [
                Expanded(
                  child: _buildCard(
                    "Wallet",
                    "₹2,450",
                    Icons.account_balance_wallet,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildCard(
                    "CamNex Credits",
                    "0",
                    Icons.emoji_events,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // School Rank + Status
            Row(
              children: [
                Expanded(
                  child: _buildCard(
                    "School Rank",
                    "#27",
                    Icons.leaderboard,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildCard(
                    "Status",
                    "Active",
                    Icons.verified,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Recharge"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Transactions"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Purchases"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Profile"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Monthly Challenge
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🏆 Monthly Challenge",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Reach the Top 20 students to earn:",
                  ),
                  SizedBox(height: 8),
                  Text("• Top 1-10   → 500 CamNex Credits"),
                  Text("• Top 11-20 → 250 CamNex Credits"),
                  SizedBox(height: 8),
                  Text(
                    "1 CamNex Credit = ₹1",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const ListTile(
              leading: Icon(Icons.fastfood),
              title: Text("Sandwich"),
              subtitle: Text("Today"),
              trailing: Text("- ₹40"),
            ),

            const ListTile(
              leading: Icon(Icons.local_drink),
              title: Text("Juice"),
              subtitle: Text("Today"),
              trailing: Text("- ₹25"),
            ),

            const ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("Wallet Recharge"),
              subtitle: Text("Yesterday"),
              trailing: Text("+ ₹500"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value, IconData icon) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 35),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}