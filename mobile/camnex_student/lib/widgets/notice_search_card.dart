import 'package:flutter/material.dart';

class NoticeSearchCard extends StatelessWidget {
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String importantFilter;

  final ValueChanged<DateTime?> onDateFromChanged;
  final ValueChanged<DateTime?> onDateToChanged;
  final ValueChanged<String?> onImportantChanged;

  final VoidCallback onReset;
  final VoidCallback onSearch;

  const NoticeSearchCard({
    super.key,
    required this.dateFrom,
    required this.dateTo,
    required this.importantFilter,
    required this.onDateFromChanged,
    required this.onDateToChanged,
    required this.onImportantChanged,
    required this.onReset,
    required this.onSearch,
  });

  Future<void> _pickDate(
    BuildContext context,
    ValueChanged<DateTime?> callback,
  ) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
    );

    if (selectedDate != null) {
      callback(selectedDate);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "Select Date";
    }

    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Search Notices",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // --------------------------------------------------
            // DATE FROM
            // --------------------------------------------------

            const Text(
              "Date From",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(
                  Icons.calendar_today,
                  size: 18,
                ),

                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _formatDate(dateFrom),
                  ),
                ),

                onPressed: () {
                  _pickDate(
                    context,
                    onDateFromChanged,
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // DATE TO
            // --------------------------------------------------

            const Text(
              "Date To",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(
                  Icons.calendar_today,
                  size: 18,
                ),

                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _formatDate(dateTo),
                  ),
                ),

                onPressed: () {
                  _pickDate(
                    context,
                    onDateToChanged,
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // IMPORTANT
            // --------------------------------------------------

            const Text(
              "Important",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: importantFilter,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),

              items: const [

                DropdownMenuItem(
                  value: "All",
                  child: Text(
                    "All Notices",
                  ),
                ),

                DropdownMenuItem(
                  value: "Important",
                  child: Text(
                    "Important Only",
                  ),
                ),
              ],

              onChanged: onImportantChanged,
            ),

            const SizedBox(height: 25),

            // --------------------------------------------------
            // BUTTONS
            // --------------------------------------------------

            Row(
              children: [

                Expanded(
                  child: OutlinedButton(
                    onPressed: onReset,
                    child: const Text(
                      "Reset",
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: onSearch,
                    child: const Text(
                      "Search",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}