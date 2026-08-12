import 'package:flutter/material.dart';

class HomeworkSearchCard extends StatelessWidget {
  final String selectedTeacher;
  final String selectedSubject;
  final String selectedStatus;

  final ValueChanged<String> onTeacherChanged;
  final ValueChanged<String> onSubjectChanged;
  final ValueChanged<String> onStatusChanged;

  final ValueChanged<DateTime?> onAssignedFromChanged;
  final ValueChanged<DateTime?> onAssignedToChanged;

  final ValueChanged<DateTime?> onDueFromChanged;
  final ValueChanged<DateTime?> onDueToChanged;

  final VoidCallback onReset;

  const HomeworkSearchCard({
    super.key,
    required this.selectedTeacher,
    required this.selectedSubject,
    required this.selectedStatus,
    required this.onTeacherChanged,
    required this.onSubjectChanged,
    required this.onStatusChanged,
    required this.onAssignedFromChanged,
    required this.onAssignedToChanged,
    required this.onDueFromChanged,
    required this.onDueToChanged,
    required this.onReset,
  });

  // =============================================================
  // DATE PICKER
  // =============================================================

  Future<void> _pickDate(
    BuildContext context,
    ValueChanged<DateTime?> callback,
  ) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    );

    callback(date);
  }

  // =============================================================
  // BUILD
  // =============================================================

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          MediaQuery.sizeOf(context).width < 600 ? 16 : 22,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    color: Colors.orange.shade700,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    "Search Homework",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff172033),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =====================================================
            // TEACHER
            // =====================================================

            _sectionLabel(
              "Teacher",
              Icons.person_outline,
            ),

            const SizedBox(height: 8),

            _dropdown(
              value: selectedTeacher,
              items: const [
                "All Teachers",
                "Mrs. Priya Sharma",
                "Mr. Amit Gupta",
                "Ms. Neha Verma",
                "Mr. Arjun Khan",
                "Mrs. Kavita Singh",
              ],
              onChanged: onTeacherChanged,
            ),

            const SizedBox(height: 18),

            // =====================================================
            // SUBJECT
            // =====================================================

            _sectionLabel(
              "Subject",
              Icons.menu_book_outlined,
            ),

            const SizedBox(height: 8),

            _dropdown(
              value: selectedSubject,
              items: const [
                "All Subjects",
                "Mathematics",
                "Science",
                "English",
                "Computer",
                "Social Science",
              ],
              onChanged: onSubjectChanged,
            ),

            const SizedBox(height: 18),

            // =====================================================
            // STATUS
            // =====================================================

            _sectionLabel(
              "Status",
              Icons.flag_outlined,
            ),

            const SizedBox(height: 8),

            _dropdown(
              value: selectedStatus,
              items: const [
                "All",
                "Pending",
                "Submitted",
                "Overdue",
              ],
              onChanged: onStatusChanged,
            ),

            const SizedBox(height: 24),

            // =====================================================
            // DATE FILTERS
            // =====================================================

            _dateSection(
              context: context,
              title: "Assigned Date",
              firstLabel: "Assigned From",
              secondLabel: "Assigned To",
              firstCallback: onAssignedFromChanged,
              secondCallback: onAssignedToChanged,
            ),

            const SizedBox(height: 22),

            _dateSection(
              context: context,
              title: "Submission Date",
              firstLabel: "Submission From",
              secondLabel: "Submission To",
              firstCallback: onDueFromChanged,
              secondCallback: onDueToChanged,
            ),

            const SizedBox(height: 25),

            // =====================================================
            // RESET
            // =====================================================

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: onReset,
                icon: const Icon(
                  Icons.refresh_rounded,
                  size: 20,
                ),
                label: const Text(
                  "Reset Filters",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue.shade700,
                  side: BorderSide(
                    color: Colors.blue.shade200,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // SECTION LABEL
  // =============================================================

  Widget _sectionLabel(
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.grey.shade700,
        ),
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xff374151),
          ),
        ),
      ],
    );
  }

  // =============================================================
  // DROPDOWN
  // =============================================================

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue.shade400,
            width: 1.5,
          ),
        ),
      ),
      items: items.map(
        (item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          );
        },
      ).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }

  // =============================================================
  // DATE SECTION
  // =============================================================

  Widget _dateSection({
    required BuildContext context,
    required String title,
    required String firstLabel,
    required String secondLabel,
    required ValueChanged<DateTime?> firstCallback,
    required ValueChanged<DateTime?> secondCallback,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xff172033),
          ),
        ),

        const SizedBox(height: 12),

        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 360;

            if (isNarrow) {
              return Column(
                children: [
                  _dateButton(
                    context: context,
                    label: firstLabel,
                    callback: firstCallback,
                  ),

                  const SizedBox(height: 10),

                  _dateButton(
                    context: context,
                    label: secondLabel,
                    callback: secondCallback,
                  ),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  child: _dateButton(
                    context: context,
                    label: firstLabel,
                    callback: firstCallback,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _dateButton(
                    context: context,
                    label: secondLabel,
                    callback: secondCallback,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // =============================================================
  // DATE BUTTON
  // =============================================================

  Widget _dateButton({
    required BuildContext context,
    required String label,
    required ValueChanged<DateTime?> callback,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: OutlinedButton.icon(
        onPressed: () {
          _pickDate(context, callback);
        },
        icon: const Icon(
          Icons.calendar_today_outlined,
          size: 17,
        ),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          foregroundColor: Colors.grey.shade700,
          backgroundColor: Colors.grey.shade50,
          side: BorderSide(
            color: Colors.grey.shade200,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
        ),
      ),
    );
  }
}