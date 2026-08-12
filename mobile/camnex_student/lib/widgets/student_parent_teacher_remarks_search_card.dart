import 'package:flutter/material.dart';

class TeacherRemarkSearchCard extends StatefulWidget {
  final String selectedTeacher;
  final String selectedSubject;

  final ValueChanged<String> onTeacherChanged;
  final ValueChanged<String> onSubjectChanged;

  final ValueChanged<DateTime?> onFromDateChanged;
  final ValueChanged<DateTime?> onToDateChanged;

  final VoidCallback onReset;

  const TeacherRemarkSearchCard({
    super.key,
    required this.selectedTeacher,
    required this.selectedSubject,
    required this.onTeacherChanged,
    required this.onSubjectChanged,
    required this.onFromDateChanged,
    required this.onToDateChanged,
    required this.onReset,
  });

  @override
  State<TeacherRemarkSearchCard> createState() =>
      _TeacherRemarkSearchCardState();
}

class _TeacherRemarkSearchCardState
    extends State<TeacherRemarkSearchCard> {
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _pickDate(
    BuildContext context, {
    required bool isFromDate,
  }) async {
    final initialDate = isFromDate
        ? (fromDate ?? DateTime.now())
        : (toDate ?? fromDate ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
    );

    if (picked == null) return;

    // Prevent invalid range
    if (!isFromDate &&
        fromDate != null &&
        picked.isBefore(fromDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "To Date cannot be earlier than From Date.",
          ),
        ),
      );
      return;
    }

    if (isFromDate &&
        toDate != null &&
        picked.isAfter(toDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "From Date cannot be later than To Date.",
          ),
        ),
      );
      return;
    }

    setState(() {
      if (isFromDate) {
        fromDate = picked;
      } else {
        toDate = picked;
      }
    });

    if (isFromDate) {
      widget.onFromDateChanged(picked);
    } else {
      widget.onToDateChanged(picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "Select Date";
    }

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return "$day/$month/${date.year}";
  }

  void _resetFilters() {
    setState(() {
      fromDate = null;
      toDate = null;
    });

    widget.onReset();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==========================
                // HEADER
                // ==========================

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(
                          alpha: 0.10,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.indigo,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Text(
                        "Search Remarks",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // ==========================
                // TEACHER
                // ==========================

                const Text(
                  "Teacher",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  initialValue: widget.selectedTeacher,
                  isExpanded: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_outline,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "All Teachers",
                      child: Text("All Teachers"),
                    ),
                    DropdownMenuItem(
                      value: "Mrs. Priya Sharma",
                      child: Text("Mrs. Priya Sharma"),
                    ),
                    DropdownMenuItem(
                      value: "Mr. Amit Gupta",
                      child: Text("Mr. Amit Gupta"),
                    ),
                    DropdownMenuItem(
                      value: "Ms. Neha Verma",
                      child: Text("Ms. Neha Verma"),
                    ),
                    DropdownMenuItem(
                      value: "Mr. Arjun Khan",
                      child: Text("Mr. Arjun Khan"),
                    ),
                    DropdownMenuItem(
                      value: "Mrs. Kavita Singh",
                      child: Text("Mrs. Kavita Singh"),
                    ),
                    DropdownMenuItem(
                      value: "Mrs. Sonia Mehta",
                      child: Text("Mrs. Sonia Mehta"),
                    ),
                    DropdownMenuItem(
                      value: "Mr. Vivek Rao",
                      child: Text("Mr. Vivek Rao"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      widget.onTeacherChanged(value);
                    }
                  },
                ),

                const SizedBox(height: 20),

                // ==========================
                // SUBJECT
                // ==========================

                const Text(
                  "Subject",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  initialValue: widget.selectedSubject,
                  isExpanded: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.menu_book_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "All Subjects",
                      child: Text("All Subjects"),
                    ),
                    DropdownMenuItem(
                      value: "Mathematics",
                      child: Text("Mathematics"),
                    ),
                    DropdownMenuItem(
                      value: "Science",
                      child: Text("Science"),
                    ),
                    DropdownMenuItem(
                      value: "English",
                      child: Text("English"),
                    ),
                    DropdownMenuItem(
                      value: "Computer Science",
                      child: Text("Computer Science"),
                    ),
                    DropdownMenuItem(
                      value: "Social Science",
                      child: Text("Social Science"),
                    ),
                    DropdownMenuItem(
                      value: "Hindi",
                      child: Text("Hindi"),
                    ),
                    DropdownMenuItem(
                      value: "Physical Education",
                      child: Text("Physical Education"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      widget.onSubjectChanged(value);
                    }
                  },
                ),

                const SizedBox(height: 25),

                const Divider(),

                const SizedBox(height: 18),

                // ==========================
                // DATE RANGE
                // ==========================

                const Text(
                  "Date Range",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // From Date
                _dateSelector(
                  context,
                  label: "From Date",
                  date: fromDate,
                  isFromDate: true,
                ),

                const SizedBox(height: 15),

                // To Date
                _dateSelector(
                  context,
                  label: "To Date",
                  date: toDate,
                  isFromDate: false,
                ),

                const SizedBox(height: 25),

                // ==========================
                // ACTIVE FILTER INFO
                // ==========================

                if (fromDate != null || toDate != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(
                        alpha: 0.07,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Colors.indigo,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Filtering remarks from "
                            "${_formatDate(fromDate)}"
                            " to "
                            "${_formatDate(toDate)}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 25),

                // ==========================
                // ACTION BUTTONS
                // ==========================

                if (constraints.maxWidth < 350)
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _resetFilters,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Reset Filters"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Filters are applied immediately
                            // through the callbacks.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Filters applied",
                                ),
                                duration:
                                    Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: const Icon(Icons.search),
                          label: const Text("Search"),
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _resetFilters,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Reset"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Filters applied",
                                ),
                                duration:
                                    Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: const Icon(Icons.search),
                          label: const Text("Search"),
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ==========================
  // DATE SELECTOR
  // ==========================

  Widget _dateSelector(
    BuildContext context, {
    required String label,
    required DateTime? date,
    required bool isFromDate,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        _pickDate(
          context,
          isFromDate: isFromDate,
        );
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(
            Icons.calendar_today_outlined,
          ),
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
        child: Text(
          _formatDate(date),
          style: TextStyle(
            color: date == null
                ? Colors.grey.shade600
                : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}