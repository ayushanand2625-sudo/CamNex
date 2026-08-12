import 'package:flutter/material.dart';

import '../data/canteen_menu_data.dart';
import '../data/canteen_purchase_data.dart';

import '../widgets/canteen_summary_card.dart';
import '../widgets/canteen_menu_card.dart';
import '../widgets/canteen_purchase_tile.dart';
import '../widgets/canteen_search_card.dart';

class CanteenScreen extends StatefulWidget {
  const CanteenScreen({super.key});

  @override
  State<CanteenScreen> createState() => _CanteenScreenState();
}

class _CanteenScreenState extends State<CanteenScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,

        title: const Text(
          "Canteen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xff2563EB),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xff2563EB),

          tabs: const [
            Tab(
              icon: Icon(Icons.restaurant_menu),
              text: "Menu",
            ),
            Tab(
              icon: Icon(Icons.receipt_long),
              text: "My Purchases",
            ),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,

        children: [
          // =====================================================
          // MENU TAB
          // =====================================================

          Scrollbar(
            thumbVisibility: true,

            child: ListView(
              padding: const EdgeInsets.all(20),

              children: [
                const Text(
                  "Canteen",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "View available food items and prices.",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 20),

                // Summary cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: const [
                      CanteenSummaryCard(
                        title: "Card Balance",
                        value: "₹820",
                        subtitle: "Available Balance",
                        icon: Icons.wallet,
                      ),

                      SizedBox(width: 15),

                      CanteenSummaryCard(
                        title: "Today's Spend",
                        value: "₹120",
                        subtitle: "Today's Purchases",
                        icon: Icons.shopping_bag,
                      ),

                      SizedBox(width: 15),

                      CanteenSummaryCard(
                        title: "This Month Spent",
                        value: "₹1,460",
                        subtitle: "Monthly Spending",
                        icon: Icons.bar_chart,
                      ),

                      SizedBox(width: 15),

                      CanteenSummaryCard(
                        title: "Total Orders",
                        value: "28",
                        subtitle: "Completed Orders",
                        icon: Icons.receipt_long,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Available Menu",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                ...canteenMenuItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CanteenMenuCard(
                      item: item,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // =====================================================
          // MY PURCHASES TAB
          // =====================================================

          Scrollbar(
            thumbVisibility: true,

            child: ListView(
              padding: const EdgeInsets.all(20),

              children: [
                const Text(
                  "My Purchases",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "View your canteen purchase history.",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 20),

                // Summary cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: const [
                      CanteenSummaryCard(
                        title: "Card Balance",
                        value: "₹820",
                        subtitle: "Available Balance",
                        icon: Icons.wallet,
                      ),

                      SizedBox(width: 15),

                      CanteenSummaryCard(
                        title: "Today's Spend",
                        value: "₹120",
                        subtitle: "Today's Purchases",
                        icon: Icons.shopping_bag,
                      ),

                      SizedBox(width: 15),

                      CanteenSummaryCard(
                        title: "This Month Spent",
                        value: "₹1,460",
                        subtitle: "Monthly Spending",
                        icon: Icons.bar_chart,
                      ),

                      SizedBox(width: 15),

                      CanteenSummaryCard(
                        title: "Total Orders",
                        value: "28",
                        subtitle: "Completed Orders",
                        icon: Icons.receipt_long,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // =================================================
                // SEARCH CARD
                // =================================================

                const CanteenSearchCard(),

                const SizedBox(height: 25),

                const Text(
                  "Purchase History",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // =================================================
                // PURCHASE LIST
                // =================================================

                ...canteenPurchases.map(
                  (purchase) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CanteenPurchaseTile(
                      purchase: purchase,
                    ),
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