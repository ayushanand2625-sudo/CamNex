import 'package:flutter/material.dart';

class CanteenSearchCard extends StatefulWidget {
  const CanteenSearchCard({
    super.key,
  });

  @override
  State<CanteenSearchCard> createState() =>
      _CanteenSearchCardState();
}

class _CanteenSearchCardState
    extends State<CanteenSearchCard> {
  DateTime? purchaseFrom;
  DateTime? purchaseTo;

  Future<void> _selectDate({
    required bool isFrom,
  }) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate:
          isFrom
              ? purchaseFrom ?? DateTime.now()
              : purchaseTo ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
    );

    if (selectedDate == null) return;

    setState(() {
      if (isFrom) {
        purchaseFrom = selectedDate;
      } else {
        purchaseTo = selectedDate;
      }
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "Select date";

    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  void _reset() {
    setState(() {
      purchaseFrom = null;
      purchaseTo = null;
    });
  }

  void _search() {
    // Add filtering logic later.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Purchase filter applied"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------
          // HEADER
          // --------------------------------------------------

          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search Purchases",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      "Filter by purchase date",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // --------------------------------------------------
          // FROM DATE
          // --------------------------------------------------

          const Text(
            "Purchase Date From",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          InkWell(
            onTap: () => _selectDate(isFrom: true),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius:
                    BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: Colors.blue,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      _formatDate(purchaseFrom),
                      style: TextStyle(
                        color: purchaseFrom == null
                            ? Colors.grey.shade500
                            : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // --------------------------------------------------
          // TO DATE
          // --------------------------------------------------

          const Text(
            "Purchase Date To",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          InkWell(
            onTap: () => _selectDate(isFrom: false),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius:
                    BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: Colors.blue,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      _formatDate(purchaseTo),
                      style: TextStyle(
                        color: purchaseTo == null
                            ? Colors.grey.shade500
                            : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          // --------------------------------------------------
          // BUTTONS
          // --------------------------------------------------

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(
                    Icons.refresh,
                    size: 17,
                  ),
                  label: const Text("Reset"),
                  style: OutlinedButton.styleFrom(
                    minimumSize:
                        const Size.fromHeight(44),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _search,
                  icon: const Icon(
                    Icons.search,
                    size: 17,
                  ),
                  label: const Text("Search"),
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        const Size.fromHeight(44),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}