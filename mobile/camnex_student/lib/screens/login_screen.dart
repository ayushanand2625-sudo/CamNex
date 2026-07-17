import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0057D9),
        elevation: 0,
        title: const Text(
          "CamNex",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 15),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          ),
          SizedBox(width: 15),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Good Morning,",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const Text(
              "Ayush Anand",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Bright Future School",
              style: TextStyle(fontSize: 16),
            ),

            const Text(
              "Class 10-A",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: buildCard(
                    "Wallet",
                    "₹500",
                    Icons.account_balance_wallet,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildCard(
                    "CamNex Credits",
                    "0",
                    Icons.emoji_events,
                    Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: buildCard(
                    "Attendance",
                    "96%",
                    Icons.school,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildCard(
                    "School Rank",
                    "#27",
                    Icons.leaderboard,
                    Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(15),
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

            const SizedBox(height: 25),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                quickAction(Icons.add_circle, "Add Money"),
                quickAction(Icons.receipt, "Transactions"),
                quickAction(Icons.shopping_bag, "Purchases"),
                quickAction(Icons.person, "Profile"),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.fastfood),
                title: Text("Lunch"),
                trailing: Text("-₹50"),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text("Wallet Recharge"),
                trailing: Text("+₹500"),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.local_drink),
                title: Text("Juice"),
                trailing: Text("-₹25"),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Alerts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget buildCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 35),
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
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quickAction(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon),
        ),
        const SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}