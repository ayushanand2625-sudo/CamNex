import 'package:flutter/material.dart';

import '../data/transport_data.dart';
import '../widgets/transport_summary_card.dart';
import '../widgets/transport_details_card.dart';

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
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
          "Transport",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 8,
        radius: const Radius.circular(10),

        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==========================================
              // HEADER
              // ==========================================

              const Text(
                "Transport",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "View your bus, vehicle and transport fee information.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              // ==========================================
              // SUMMARY
              // ==========================================

              const Text(
                "Transport Summary",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [

                      TransportSummaryCard(
                        title: "Bus Number",
                        value: transportData.busNumber,
                        icon: Icons.directions_bus,
                      ),

                      TransportSummaryCard(
                        title: "Vehicle Number",
                        value: transportData.vehicleNumber,
                        icon: Icons.local_shipping,
                      ),

                      TransportSummaryCard(
                        title: "Transport Fee",
                        value: transportData.transportFee,
                        icon: Icons.currency_rupee,
                      ),

                      TransportSummaryCard(
                        title: "Fee Status",
                        value: transportData.feeStatus,
                        icon: Icons.payment,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),

              // ==========================================
              // TRANSPORT DETAILS
              // ==========================================

              const Text(
                "Transport Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              TransportDetailsCard(
                transport: transportData,
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}