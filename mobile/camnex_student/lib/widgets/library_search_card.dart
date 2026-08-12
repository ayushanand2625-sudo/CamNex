import 'package:flutter/material.dart';

class LibrarySearchCard extends StatefulWidget {
  final String searchText;
  final String selectedStatus;

  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onStatusChanged;

  final ValueChanged<DateTime?> onIssueFromChanged;
  final ValueChanged<DateTime?> onIssueToChanged;

  final ValueChanged<DateTime?> onDueFromChanged;
  final ValueChanged<DateTime?> onDueToChanged;

  final ValueChanged<DateTime?> onReturnFromChanged;
  final ValueChanged<DateTime?> onReturnToChanged;

  final VoidCallback onReset;

  const LibrarySearchCard({
    super.key,
    required this.searchText,
    required this.selectedStatus,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onIssueFromChanged,
    required this.onIssueToChanged,
    required this.onDueFromChanged,
    required this.onDueToChanged,
    required this.onReturnFromChanged,
    required this.onReturnToChanged,
    required this.onReset,
  });

  @override
  State<LibrarySearchCard> createState() =>
      _LibrarySearchCardState();
}

class _LibrarySearchCardState
    extends State<LibrarySearchCard> {
  late TextEditingController _searchController;

  DateTime? issueFrom;
  DateTime? issueTo;

  DateTime? dueFrom;
  DateTime? dueTo;

  DateTime? returnFrom;
  DateTime? returnTo;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(
      text: widget.searchText,
    );
  }

  @override
  void didUpdateWidget(
    covariant LibrarySearchCard oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (widget.searchText !=
        _searchController.text) {
      _searchController.text = widget.searchText;

      _searchController.selection =
          TextSelection.fromPosition(
        TextPosition(
          offset: _searchController.text.length,
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _pickDate({
    required DateTime? currentDate,
    required ValueChanged<DateTime?> callback,
  }) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: currentDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: const DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null) {
      setState(() {
        callback(selected);
      });
    }
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatDate(DateTime? date) {
    if (date == null) {
      return "Select";
    }

    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  // ============================================================
  // DATE BUTTON
  // ============================================================

  Widget _dateButton({
    required String label,
    required DateTime? date,
    required VoidCallback onPressed,
  }) {
    final hasDate = date != null;

    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          Icons.calendar_today_outlined,
          size: 17,
          color: hasDate
              ? Colors.blue
              : Colors.grey.shade600,
        ),
        label: Text(
          hasDate
              ? _formatDate(date)
              : label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            color: hasDate
                ? Colors.blue.shade700
                : Colors.grey.shade700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 13,
          ),
          side: BorderSide(
            color: hasDate
                ? Colors.blue.shade300
                : Colors.grey.shade300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DATE RANGE
  // ============================================================

  Widget _dateRangeSection({
    required String title,
    required DateTime? from,
    required DateTime? to,
    required VoidCallback onFrom,
    required VoidCallback onTo,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 9),

        Row(
          children: [

            _dateButton(
              label: "From",
              date: from,
              onPressed: onFrom,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 7,
              ),
              child: Icon(
                Icons.arrow_forward,
                size: 16,
                color: Colors.grey,
              ),
            ),

            _dateButton(
              label: "To",
              date: to,
              onPressed: onTo,
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // CLEAR SEARCH
  // ============================================================

  void _clearSearch() {
    _searchController.clear();
    widget.onSearchChanged("");
  }

  // ============================================================
  // RESET
  // ============================================================

  void _reset() {
    setState(() {
      issueFrom = null;
      issueTo = null;

      dueFrom = null;
      dueTo = null;

      returnFrom = null;
      returnTo = null;
    });

    _searchController.clear();

    widget.onReset();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: Colors.blue,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Search & Filter",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      "Find books quickly",
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

          // =====================================================
          // BOOK SEARCH
          // =====================================================

          const Text(
            "Book Name",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _searchController,
            onChanged: widget.onSearchChanged,
            textInputAction:
                TextInputAction.search,
            decoration: InputDecoration(
              hintText: "Search by book name...",
              prefixIcon: const Icon(
                Icons.search_rounded,
              ),
              suffixIcon:
                  _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: _clearSearch,
                          icon: const Icon(
                            Icons.clear,
                          ),
                        )
                      : null,
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding:
                  const EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(11),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
              enabledBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(11),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
              focusedBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(11),
                borderSide:
                    const BorderSide(
                  color: Colors.blue,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // =====================================================
          // STATUS
          // =====================================================

          const Text(
            "Book Status",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue:
                widget.selectedStatus,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.filter_list_rounded,
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding:
                  const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(11),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
              enabledBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(11),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            items: const [

              DropdownMenuItem(
                value: "All",
                child: Text("All Books"),
              ),

              DropdownMenuItem(
                value: "Available",
                child: Text("Available"),
              ),

              DropdownMenuItem(
                value: "Issued",
                child: Text("Issued"),
              ),

              DropdownMenuItem(
                value: "Returned",
                child: Text("Returned"),
              ),

              DropdownMenuItem(
                value: "Overdue",
                child: Text("Overdue"),
              ),
            ],
            onChanged:
                widget.onStatusChanged,
          ),

          const SizedBox(height: 22),

          // =====================================================
          // DATE FILTERS
          // =====================================================

          const Text(
            "Date Filters",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          _dateRangeSection(
            title: "Issue Date",
            from: issueFrom,
            to: issueTo,
            onFrom: () {
              _pickDate(
                currentDate: issueFrom,
                callback: (date) {
                  issueFrom = date;
                  widget
                      .onIssueFromChanged(date);
                },
              );
            },
            onTo: () {
              _pickDate(
                currentDate: issueTo,
                callback: (date) {
                  issueTo = date;
                  widget
                      .onIssueToChanged(date);
                },
              );
            },
          ),

          const SizedBox(height: 16),

          _dateRangeSection(
            title: "Due Date",
            from: dueFrom,
            to: dueTo,
            onFrom: () {
              _pickDate(
                currentDate: dueFrom,
                callback: (date) {
                  dueFrom = date;
                  widget
                      .onDueFromChanged(date);
                },
              );
            },
            onTo: () {
              _pickDate(
                currentDate: dueTo,
                callback: (date) {
                  dueTo = date;
                  widget
                      .onDueToChanged(date);
                },
              );
            },
          ),

          const SizedBox(height: 16),

          _dateRangeSection(
            title: "Return Date",
            from: returnFrom,
            to: returnTo,
            onFrom: () {
              _pickDate(
                currentDate: returnFrom,
                callback: (date) {
                  returnFrom = date;
                  widget
                      .onReturnFromChanged(date);
                },
              );
            },
            onTo: () {
              _pickDate(
                currentDate: returnTo,
                callback: (date) {
                  returnTo = date;
                  widget
                      .onReturnToChanged(date);
                },
              );
            },
          ),

          const SizedBox(height: 22),

          // =====================================================
          // ACTION BUTTONS
          // =====================================================

          Row(
            children: [

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 18,
                  ),
                  label: const Text("Reset"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        Colors.grey.shade700,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),
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
                  onPressed: () {
                    FocusScope.of(context)
                        .unfocus();
                  },
                  icon: const Icon(
                    Icons.check_rounded,
                    size: 18,
                  ),
                  label:
                      const Text("Apply"),
                  style:
                      ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
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