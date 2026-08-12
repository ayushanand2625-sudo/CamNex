import 'package:flutter/material.dart';

class TeacherHubAnnouncementsScreen extends StatefulWidget {
  const TeacherHubAnnouncementsScreen({super.key});

  @override
  State<TeacherHubAnnouncementsScreen> createState() =>
      _TeacherHubAnnouncementsScreenState();
}

class _TeacherHubAnnouncementsScreenState
    extends State<TeacherHubAnnouncementsScreen> {
  // ==========================================================
  // FILTERS
  // ==========================================================

  String? selectedClass;
  String? selectedDepartment;

  final TextEditingController searchController =
      TextEditingController();

  // ==========================================================
  // SAMPLE ANNOUNCEMENTS
  // Later this will come from backend/database.
  // ==========================================================

  final List<Map<String, dynamic>> announcements = [
    {
      "id": "ANN001",
      "title": "Parent-Teacher Meeting",
      "message":
          "The parent-teacher meeting will be conducted this Saturday.",
      "sender": "School Administration",
      "date": DateTime(2026, 8, 8, 10, 30),
      "type": "Class",
      "class": "VIII-A",
      "department": null,
      "isImportant": true,
    },
    {
      "id": "ANN002",
      "title": "Mathematics Department Meeting",
      "message":
          "All mathematics teachers are requested to attend the department meeting.",
      "sender": "Mathematics Department",
      "date": DateTime(2026, 8, 7, 14, 15),
      "type": "Department",
      "class": null,
      "department": "Mathematics",
      "isImportant": false,
    },
    {
      "id": "ANN003",
      "title": "Sports Day Practice",
      "message":
          "Students participating in Sports Day should report to the sports ground.",
      "sender": "Sports Department",
      "date": DateTime(2026, 8, 6, 9, 0),
      "type": "Class",
      "class": "VII-A",
      "department": null,
      "isImportant": false,
    },
    {
      "id": "ANN004",
      "title": "Staff Development Programme",
      "message":
          "A professional development programme has been scheduled for all teachers.",
      "sender": "School Administration",
      "date": DateTime(2026, 8, 5, 11, 30),
      "type": "All Teachers",
      "class": null,
      "department": null,
      "isImportant": true,
    },
  ];

  final List<String> classes = [
    "V-A",
    "VI-A",
    "VII-A",
    "VIII-A",
    "IX-A",
  ];

  final List<String> departments = [
    "Mathematics",
    "Science",
    "English",
    "Computer Science",
    "Social Science",
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ==========================================================
  // FILTERED ANNOUNCEMENTS
  // ==========================================================

  List<Map<String, dynamic>> get filteredAnnouncements {
    final query = searchController.text.trim().toLowerCase();

    final result = announcements.where((announcement) {
      final matchesSearch =
          query.isEmpty ||
          announcement["title"]
              .toString()
              .toLowerCase()
              .contains(query) ||
          announcement["message"]
              .toString()
              .toLowerCase()
              .contains(query) ||
          announcement["sender"]
              .toString()
              .toLowerCase()
              .contains(query);

      final matchesClass =
          selectedClass == null ||
          announcement["class"] == selectedClass;

      final matchesDepartment =
          selectedDepartment == null ||
          announcement["department"] == selectedDepartment;

      return matchesSearch &&
          matchesClass &&
          matchesDepartment;
    }).toList();

    result.sort(
      (a, b) => (b["date"] as DateTime)
          .compareTo(a["date"] as DateTime),
    );

    return result;
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final announcementsList = filteredAnnouncements;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Announcements",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ==================================================
            // SEARCH + FILTER AREA
            // ==================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                8,
              ),
              child: Column(
                children: [
                  _buildSearchBar(),

                  const SizedBox(height: 12),

                  _buildFilterBar(),
                ],
              ),
            ),

            // ==================================================
            // ACTIVE FILTERS
            // ==================================================

            if (selectedClass != null ||
                selectedDepartment != null)
              _buildActiveFilters(),

            // ==================================================
            // ANNOUNCEMENT COUNT
            // ==================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                8,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.campaign_outlined,
                    size: 21,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    "${announcementsList.length} Announcements",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  if (selectedClass != null ||
                      selectedDepartment != null)
                    TextButton(
                      onPressed: _clearFilters,
                      child: const Text(
                        "Clear",
                      ),
                    ),
                ],
              ),
            ),

            // ==================================================
            // ANNOUNCEMENT LIST
            // ==================================================

            Expanded(
              child: announcementsList.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        4,
                        16,
                        24,
                      ),
                      itemCount:
                          announcementsList.length,
                      itemBuilder: (context, index) {
                        return _buildAnnouncementCard(
                          announcementsList[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // ========================================================
      // CREATE ANNOUNCEMENT
      // ========================================================

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateAnnouncement,
        icon: const Icon(
          Icons.campaign_outlined,
        ),
        label: const Text(
          "New Announcement",
        ),
      ),
    );
  }

  // ==========================================================
  // SEARCH BAR
  // ==========================================================

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,

      onChanged: (_) {
        setState(() {});
      },

      decoration: InputDecoration(
        hintText: "Search announcements...",

        prefixIcon: const Icon(
          Icons.search,
        ),

        suffixIcon:
            searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      searchController.clear();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  )
                : null,

        filled: true,
        fillColor: Colors.grey.shade50,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFFF8A3D),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // FILTER BAR
  // ==========================================================

  Widget _buildFilterBar() {
    return Row(
      children: [
        Expanded(
          child: _filterDropdown(
            icon: Icons.class_outlined,
            hint: "Class",
            value: selectedClass,
            items: classes,
            onChanged: (value) {
              setState(() {
                selectedClass = value;
              });
            },
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _filterDropdown(
            icon: Icons.menu_book_outlined,
            hint: "Department",
            value: selectedDepartment,
            items: departments,
            onChanged: (value) {
              setState(() {
                selectedDepartment = value;
              });
            },
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // FILTER DROPDOWN
  // ==========================================================

  Widget _filterDropdown({
    required IconData icon,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,

      isExpanded: true,

      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          size: 20,
        ),

        hintText: hint,

        filled: true,
        fillColor: Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 13,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),

      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),

      onChanged: onChanged,
    );
  }

  // ==========================================================
  // ACTIVE FILTERS
  // ==========================================================

  Widget _buildActiveFilters() {
    return SizedBox(
      height: 46,

      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),

        scrollDirection: Axis.horizontal,

        children: [
          if (selectedClass != null)
            _filterChip(
              icon: Icons.class_outlined,
              label:
                  "Class $selectedClass",
              onRemove: () {
                setState(() {
                  selectedClass = null;
                });
              },
            ),

          if (selectedDepartment != null)
            _filterChip(
              icon: Icons.menu_book_outlined,
              label: selectedDepartment!,
              onRemove: () {
                setState(() {
                  selectedDepartment = null;
                });
              },
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // FILTER CHIP
  // ==========================================================

  Widget _filterChip({
    required IconData icon,
    required String label,
    required VoidCallback onRemove,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        right: 8,
      ),

      child: Chip(
        avatar: Icon(
          icon,
          size: 17,
        ),

        label: Text(label),

        deleteIcon: const Icon(
          Icons.close,
          size: 17,
        ),

        onDeleted: onRemove,
      ),
    );
  }

  // ==========================================================
  // ANNOUNCEMENT CARD
  // ==========================================================

  Widget _buildAnnouncementCard(
    Map<String, dynamic> announcement,
  ) {
    final DateTime date =
        announcement["date"];

    final bool important =
        announcement["isImportant"] == true;

    final String? className =
        announcement["class"];

    final String? department =
        announcement["department"];

    return Container(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        border: Border.all(
          color: important
              ? Colors.orange.shade200
              : Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(18),

        onTap: () {
          _openAnnouncement(
            announcement,
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ============================================
              // TOP ROW
              // ============================================

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Container(
                    width: 48,
                    height: 48,

                    decoration: BoxDecoration(
                      color: important
                          ? Colors.orange.shade50
                          : Colors.blue.shade50,

                      borderRadius:
                          BorderRadius.circular(13),
                    ),

                    child: Icon(
                      important
                          ? Icons.priority_high
                          : Icons.campaign_outlined,

                      color: important
                          ? Colors.orange.shade700
                          : Colors.blue.shade700,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                announcement["title"],
                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),

                            if (important)
                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color:
                                      Colors.orange.shade50,
                                  borderRadius:
                                      BorderRadius.circular(
                                          8),
                                ),

                                child: Text(
                                  "Important",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Colors.orange.shade800,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Text(
                          announcement["sender"],
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ============================================
              // MESSAGE
              // ============================================

              Text(
                announcement["message"],
                maxLines: 3,
                overflow:
                    TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color:
                      Colors.grey.shade800,
                ),
              ),

              const SizedBox(height: 14),

              // ============================================
              // TARGET
              // ============================================

              Wrap(
                spacing: 7,
                runSpacing: 7,

                children: [
                  if (className != null)
                    _targetTag(
                      Icons.class_outlined,
                      "Class $className",
                    ),

                  if (department != null)
                    _targetTag(
                      Icons.menu_book_outlined,
                      department,
                    ),

                  if (announcement["type"] ==
                      "All Teachers")
                    _targetTag(
                      Icons.groups_outlined,
                      "All Teachers",
                    ),
                ],
              ),

              const SizedBox(height: 13),

              Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),

              const SizedBox(height: 10),

              // ============================================
              // DATE + VIEW
              // ============================================

              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 16,
                    color:
                        Colors.grey.shade500,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    _formatDateTime(date),
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          Colors.grey.shade600,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    "View",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          Colors.orange.shade700,
                    ),
                  ),

                  const SizedBox(width: 4),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color:
                        Colors.orange.shade700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // TARGET TAG
  // ==========================================================

  Widget _targetTag(
    IconData icon,
    String text,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius:
            BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          Icon(
            icon,
            size: 14,
            color:
                Colors.grey.shade700,
          ),

          const SizedBox(width: 5),

          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color:
                  Colors.grey.shade700,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              width: 90,
              height: 90,

              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),

              child: Icon(
                Icons.notifications_none_outlined,
                size: 45,
                color:
                    Colors.orange.shade600,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "No Announcements Found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "There are no announcements matching "
              "your current search or filters.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color:
                    Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // OPEN ANNOUNCEMENT
  // ==========================================================

  void _openAnnouncement(
    Map<String, dynamic> announcement,
  ) {
    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {
        final DateTime date =
            announcement["date"];

        return Container(
          constraints:
              const BoxConstraints(
            maxHeight: 650,
          ),

          decoration: const BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),

          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(
                              10),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.orange.shade50,
                        borderRadius:
                            BorderRadius.circular(
                                14),
                      ),

                      child: Icon(
                        Icons
                            .campaign_outlined,
                        color:
                            Colors.orange.shade700,
                      ),
                    ),

                    const SizedBox(width: 13),

                    Expanded(
                      child: Text(
                        announcement["title"],
                        style:
                            const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Text(
                  announcement["message"],
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 22),

                _detailRow(
                  Icons.person_outline,
                  "Posted By",
                  announcement["sender"],
                ),

                const SizedBox(height: 12),

                _detailRow(
                  Icons.access_time_outlined,
                  "Date",
                  _formatDateTime(date),
                ),

                const SizedBox(height: 12),

                if (announcement["class"] !=
                    null)
                  _detailRow(
                    Icons.class_outlined,
                    "Class",
                    announcement["class"],
                  ),

                if (announcement[
                        "department"] !=
                    null) ...[
                  const SizedBox(height: 12),
                  _detailRow(
                    Icons.menu_book_outlined,
                    "Department",
                    announcement[
                        "department"],
                  ),
                ],

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    style:
                        ElevatedButton.styleFrom(
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                12),
                      ),
                    ),

                    child:
                        const Text("Close"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // DETAIL ROW
  // ==========================================================

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(13),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color:
                Colors.grey.shade700,
          ),

          const SizedBox(width: 12),

          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          Expanded(
            child: Text(
              value,
              overflow:
                  TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CREATE ANNOUNCEMENT
  // ==========================================================

  void _openCreateAnnouncement() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const CreateTeacherAnnouncementScreen(),
      ),
    );
  }

  // ==========================================================
  // CLEAR FILTERS
  // ==========================================================

  void _clearFilters() {
    setState(() {
      selectedClass = null;
      selectedDepartment = null;
    });
  }

  // ==========================================================
  // DATE FORMAT
  // ==========================================================

  String _formatDateTime(DateTime date) {
    final day =
        date.day.toString().padLeft(2, '0');

    final month =
        date.month.toString().padLeft(2, '0');

    final hour =
        date.hour > 12
            ? date.hour - 12
            : date.hour == 0
                ? 12
                : date.hour;

    final minute =
        date.minute.toString().padLeft(2, '0');

    final period =
        date.hour >= 12 ? "PM" : "AM";

    return "$day/$month/${date.year} • "
        "$hour:$minute $period";
  }
}

// ============================================================
// CREATE ANNOUNCEMENT SCREEN
// ============================================================

class CreateTeacherAnnouncementScreen
    extends StatefulWidget {
  const CreateTeacherAnnouncementScreen({
    super.key,
  });

  @override
  State<CreateTeacherAnnouncementScreen> createState() =>
      _CreateTeacherAnnouncementScreenState();
}

class _CreateTeacherAnnouncementScreenState
    extends State<CreateTeacherAnnouncementScreen> {
  final titleController =
      TextEditingController();

  final messageController =
      TextEditingController();

  String announcementType =
      "Class";

  String? selectedClass;
  String? selectedDepartment;

  bool isImportant = false;

  final classes = [
    "V-A",
    "VI-A",
    "VII-A",
    "VIII-A",
    "IX-A",
  ];

  final departments = [
    "Mathematics",
    "Science",
    "English",
    "Computer Science",
    "Social Science",
  ];

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Announcement",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ==================================================
            // TITLE
            // ==================================================

            const Text(
              "Announcement Title",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText:
                    "Enter announcement title",
                prefixIcon: const Icon(
                  Icons.title_outlined,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ==================================================
            // MESSAGE
            // ==================================================

            const Text(
              "Announcement",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller:
                  messageController,
              maxLines: 7,

              decoration: InputDecoration(
                hintText:
                    "Write your announcement...",
                alignLabelWithHint: true,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ==================================================
            // TARGET
            // ==================================================

            const Text(
              "Send To",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: announcementType,

              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.groups_outlined,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),

              items: const [
                DropdownMenuItem(
                  value: "Class",
                  child: Text("Class"),
                ),
                DropdownMenuItem(
                  value: "Department",
                  child: Text("Department"),
                ),
                DropdownMenuItem(
                  value: "All Teachers",
                  child:
                      Text("All Teachers"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  announcementType =
                      value!;

                  selectedClass = null;
                  selectedDepartment =
                      null;
                });
              },
            ),

            const SizedBox(height: 15),

            if (announcementType ==
                "Class")
              DropdownButtonFormField<String>(
                value: selectedClass,

                decoration:
                    InputDecoration(
                  hintText:
                      "Select class",
                  prefixIcon:
                      const Icon(
                    Icons.class_outlined,
                  ),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius
                            .circular(14),
                  ),
                ),

                items:
                    classes.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child:
                        Text("Class $item"),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedClass =
                        value;
                  });
                },
              ),

            if (announcementType ==
                "Department")
              DropdownButtonFormField<String>(
                value: selectedDepartment,

                decoration:
                    InputDecoration(
                  hintText:
                      "Select department",
                  prefixIcon:
                      const Icon(
                    Icons.menu_book_outlined,
                  ),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius
                            .circular(14),
                  ),
                ),

                items: departments
                    .map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedDepartment =
                        value;
                  });
                },
              ),

            const SizedBox(height: 15),

            // ==================================================
            // IMPORTANT
            // ==================================================

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      Colors.grey.shade300,
                ),
                borderRadius:
                    BorderRadius.circular(
                        14),
              ),

              child:
                  SwitchListTile(
                value: isImportant,

                onChanged: (value) {
                  setState(() {
                    isImportant =
                        value;
                  });
                },

                secondary:
                    const Icon(
                  Icons.priority_high,
                ),

                title: const Text(
                  "Mark as Important",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                subtitle:
                    const Text(
                  "Highlight this announcement "
                  "for the recipients.",
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // PUBLISH
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 55,

              child:
                  ElevatedButton.icon(
                onPressed:
                    _publishAnnouncement,

                icon: const Icon(
                  Icons.send_outlined,
                ),

                label: const Text(
                  "Publish Announcement",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                style:
                    ElevatedButton.styleFrom(
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PUBLISH
  // ==========================================================

  void _publishAnnouncement() {
    if (titleController.text
        .trim()
        .isEmpty) {
      _showError(
        "Please enter announcement title.",
      );
      return;
    }

    if (messageController.text
        .trim()
        .isEmpty) {
      _showError(
        "Please enter announcement message.",
      );
      return;
    }

    if (announcementType ==
            "Class" &&
        selectedClass == null) {
      _showError(
        "Please select a class.",
      );
      return;
    }

    if (announcementType ==
            "Department" &&
        selectedDepartment == null) {
      _showError(
        "Please select a department.",
      );
      return;
    }

    final announcementData = {
      "title":
          titleController.text.trim(),

      "message":
          messageController.text.trim(),

      "type":
          announcementType,

      "class":
          selectedClass,

      "department":
          selectedDepartment,

      "isImportant":
          isImportant,

      "date":
          DateTime.now().toIso8601String(),
    };

    debugPrint(
      "ANNOUNCEMENT DATA: "
      "$announcementData",
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Announcement published successfully.",
        ),
        behavior:
            SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  // ==========================================================
  // ERROR
  // ==========================================================

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }
}