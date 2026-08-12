import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_provider.dart';
import '../theme/app_theme.dart';
import 'payment_summary_screen.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final TextEditingController customAmountController =
      TextEditingController();

  int? selectedAmount;

  final List<int> amounts = [
    100,
    200,
    500,
    1000,
  ];

  @override
  void dispose() {
    customAmountController.dispose();
    super.dispose();
  }

  double get rechargeAmount {
    if (selectedAmount != null) {
      return selectedAmount!.toDouble();
    }

    return double.tryParse(
          customAmountController.text.trim(),
        ) ??
        0;
  }

  void selectAmount(int amount) {
    setState(() {
      selectedAmount = amount;
      customAmountController.clear();
    });
  }

  void proceedToPayment() {
    final amount = rechargeAmount;

    if (amount < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Minimum recharge amount is ₹10."),
        ),
      );
      return;
    }

    if (amount > 2000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Maximum recharge amount is ₹2000."),
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentSummaryScreen(
          rechargeAmount: amount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final student =
        context.watch<StudentProvider>().selectedStudent;

    final amount = rechargeAmount;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryBlue,
        elevation: 0,

        title: const Text(
          "Recharge Smart Card",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          18,
          20,
          25,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =================================================
            // STUDENT
            // =================================================

            Row(
              children: [

                CircleAvatar(
                  radius: 22,
                  backgroundColor:
                      AppTheme.primaryBlue.withOpacity(0.10),

                  child: const Icon(
                    Icons.person_outline,
                    color: AppTheme.primaryBlue,
                    size: 23,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Recharge for",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        student.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        student.studentClass,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // =================================================
            // CURRENT BALANCE - COMPACT
            // =================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 17,
              ),

              decoration: BoxDecoration(
                color: AppTheme.primaryBlue,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                children: [

                  Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.14),
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),

                  const SizedBox(width: 13),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Current Balance",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),

                        SizedBox(height: 3),

                        Text(
                          "Available Smart Card balance",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "₹${student.cardBalance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // SELECT AMOUNT
            // =================================================

            const Text(
              "Select Recharge Amount",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Choose an amount below",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 14),

            // =================================================
            // SMALL AMOUNT CARDS
            // =================================================

            Wrap(
              spacing: 10,
              runSpacing: 10,

              children: amounts.map((amount) {

                final isSelected =
                    selectedAmount == amount;

                return InkWell(
                  borderRadius:
                      BorderRadius.circular(11),

                  onTap: () {
                    selectAmount(amount);
                  },

                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 180),

                    width: 88,
                    height: 48,

                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryBlue
                          : Colors.white,

                      borderRadius:
                          BorderRadius.circular(11),

                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryBlue
                            : Colors.grey.shade300,

                        width: isSelected ? 1.5 : 1,
                      ),

                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppTheme.primaryBlue
                                    .withOpacity(0.18),
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),

                    child: Center(
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          if (isSelected)
                            const Padding(
                              padding:
                                  EdgeInsets.only(right: 4),

                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),

                          Text(
                            "₹$amount",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.bold,

                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // =================================================
            // OR
            // =================================================

            Row(
              children: [

                Expanded(
                  child: Divider(
                    color: Colors.grey.shade300,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Expanded(
                  child: Divider(
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =================================================
            // CUSTOM AMOUNT
            // =================================================

            TextField(
              controller: customAmountController,

              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: InputDecoration(
                labelText: "Custom Amount",

                hintText: "Enter ₹10 - ₹2000",

                prefixText: "₹ ",

                prefixIcon: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                ),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),

                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),

                  borderSide: const BorderSide(
                    color: AppTheme.primaryBlue,
                    width: 1.5,
                  ),
                ),

                helperText:
                    "Minimum ₹10 • Maximum ₹2000",
              ),

              onChanged: (value) {

                setState(() {
                  selectedAmount = null;
                });

                final parsed =
                    double.tryParse(value);

                if (parsed != null &&
                    parsed > 2000) {

                  customAmountController.text =
                      "2000";

                  customAmountController.selection =
                      TextSelection.fromPosition(
                    TextPosition(
                      offset:
                          customAmountController.text
                              .length,
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 18),

            // =================================================
            // SELECTED AMOUNT
            // =================================================

            if (amount > 0)
              Container(
                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),

                decoration: BoxDecoration(
                  color: Colors.green.shade50,

                  borderRadius:
                      BorderRadius.circular(12),

                  border: Border.all(
                    color: Colors.green.shade100,
                  ),
                ),

                child: Row(
                  children: [

                    Icon(
                      Icons.check_circle,
                      color: Colors.green.shade700,
                      size: 20,
                    ),

                    const SizedBox(width: 9),

                    const Expanded(
                      child: Text(
                        "Recharge Amount",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Text(
                      "₹${amount.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 18),

            // =================================================
            // SECURITY NOTICE
            // =================================================

            Container(
              padding: const EdgeInsets.all(13),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,

                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Icon(
                    Icons.lock_outline,
                    color: AppTheme.primaryBlue,
                    size: 20,
                  ),

                  const SizedBox(width: 9),

                  const Expanded(
                    child: Text(
                      "Payment is securely processed. "
                      "The amount will be added to the Smart Card "
                      "after successful payment.",
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // PAYMENT BUTTON
            // =================================================

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton.icon(
                onPressed: proceedToPayment,

                icon: const Icon(
                  Icons.lock_outline,
                  size: 19,
                ),

                label: const Text(
                  "Proceed to Payment",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppTheme.primaryBlue,

                  foregroundColor: Colors.white,

                  elevation: 1,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Center(
              child: Text(
                "Secure • Official CamNex Smart Card",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}