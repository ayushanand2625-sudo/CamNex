import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CardBalanceCard extends StatelessWidget {
  final String studentName;
  final String studentClass;
  final double balance;
  final VoidCallback onRecharge;

  const CardBalanceCard({
    super.key,
    required this.studentName,
    required this.studentClass,
    required this.balance,
    required this.onRecharge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            AppTheme.primaryBlue,
            AppTheme.primaryBlue.withOpacity(0.78),
          ],
        ),

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue
                .withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // ======================================
          // CARD HEADER
          // ======================================

          Row(
            children: [
              Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.15),
                  borderRadius:
                      BorderRadius.circular(14),
                ),

                child: const Icon(
                  Icons.contactless_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 13),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CAMPUS SMART CARD",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      "CamNex Digital Wallet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.15),
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: const Text(
                  "ACTIVE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ======================================
          // CHIP + CARD NUMBER
          // ======================================

          Row(
            children: [
              Container(
                width: 42,
                height: 32,

                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  borderRadius:
                      BorderRadius.circular(7),
                ),

                child: const Icon(
                  Icons.memory_rounded,
                  color: Colors.black54,
                  size: 23,
                ),
              ),

              const SizedBox(width: 15),

              const Text(
                "4582  ••••  ••••  9214",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // ======================================
          // STUDENT DETAILS
          // ======================================

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "CARD HOLDER",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 9,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      studentName.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  const Text(
                    "CLASS",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 9,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    studentClass,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 25),

          // ======================================
          // BALANCE
          // ======================================

          Container(
            padding: const EdgeInsets.all(17),

            decoration: BoxDecoration(
              color: Colors.black
                  .withOpacity(0.12),
              borderRadius:
                  BorderRadius.circular(16),
            ),

            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AVAILABLE BALANCE",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),

                      SizedBox(height: 5),
                    ],
                  ),
                ),

                Text(
                  "₹${balance.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ======================================
          // RECHARGE
          // ======================================

          SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(
              onPressed: onRecharge,

              icon: const Icon(
                Icons.add_circle_outline,
              ),

              label: const Text(
                "Recharge Smart Card",
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor:
                    AppTheme.primaryBlue,

                elevation: 0,

                padding:
                    const EdgeInsets.symmetric(
                  vertical: 15,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}