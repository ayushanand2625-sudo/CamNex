import 'package:flutter/material.dart';

class TeacherHubScheduleMeetingScreen extends StatefulWidget {
  const TeacherHubScheduleMeetingScreen({super.key});

  @override
  State<TeacherHubScheduleMeetingScreen> createState() =>
      _TeacherHubScheduleMeetingScreenState();
}

class _TeacherHubScheduleMeetingScreenState
    extends State<TeacherHubScheduleMeetingScreen> {
  // ==========================================================
  // CONTROLLERS
  // ==========================================================

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController =
      TextEditingController();
  final TextEditingController teacherSearchController =
      TextEditingController();

  // ==========================================================
  // MEETING DATA
  // ==========================================================

  DateTime? selectedDateTime;

  String selectedDuration = "30 minutes";

  final List<String> durationOptions = [
    "30 minutes",
    "45 minutes",
    "1 hour",
    "1 hour 30 minutes",
    "2 hours",
  ];

  // ==========================================================
  // GROUP DATA
  // Later this will come from backend/database.
  // ==========================================================

  final List<Map<String, dynamic>> groups = [
    {
      "id": "CLASS_V_A",
      "name": "Class V-A",
      "type": "Class",
      "members": 28,
    },
    {
      "id": "CLASS_VI_A",
      "name": "Class VI-A",
      "type": "Class",
      "members": 30,
    },
    {
      "id": "CLASS_VII_A",
      "name": "Class VII-A",
      "type": "Class",
      "members": 32,
    },
    {
      "id": "CLASS_VIII_A",
      "name": "Class VIII-A",
      "type": "Class",
      "members": 28,
    },
    {
      "id": "CLASS_IX_A",
      "name": "Class IX-A",
      "type": "Class",
      "members": 31,
    },
    {
      "id": "DEPT_MATH",
      "name": "Mathematics Department",
      "type": "Department",
      "members": 8,
    },
    {
      "id": "DEPT_SCIENCE",
      "name": "Science Department",
      "type": "Department",
      "members": 7,
    },
    {
      "id": "DEPT_ENGLISH",
      "name": "English Department",
      "type": "Department",
      "members": 6,
    },
  ];

  // ==========================================================
  // TEACHER DATA
  // ==========================================================

  final List<Map<String, dynamic>> teachers = [
    {
      "id": "T001",
      "name": "Dr. Rajesh Kumar",
      "role": "Mathematics Teacher",
      "department": "Mathematics",
    },
    {
      "id": "T002",
      "name": "Mrs. Priya Sharma",
      "role": "Science Teacher",
      "department": "Science",
    },
    {
      "id": "T003",
      "name": "Mr. Amit Verma",
      "role": "English Teacher",
      "department": "English",
    },
    {
      "id": "T004",
      "name": "Mrs. Neha Singh",
      "role": "Class Teacher",
      "department": "Mathematics",
    },
    {
      "id": "T005",
      "name": "Mr. Rahul Gupta",
      "role": "Mathematics Teacher",
      "department": "Mathematics",
    },
    {
      "id": "T006",
      "name": "Mrs. Sneha Sharma",
      "role": "Science Teacher",
      "department": "Science",
    },
    {
      "id": "T007",
      "name": "Mr. Karan Singh",
      "role": "English Teacher",
      "department": "English",
    },
  ];

  // ==========================================================
  // SELECTED GROUPS
  // ==========================================================

  final Set<String> selectedGroupIds = {};

  // ==========================================================
  // SELECTED INDIVIDUAL TEACHERS
  // ==========================================================

  final Set<String> selectedTeacherIds = {};

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Schedule Meeting",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),

                  const SizedBox(height: 25),

                  _buildMeetingDetails(),

                  const SizedBox(height: 25),

                  _buildDateTimeSection(),

                  const SizedBox(height: 25),

                  _buildDurationSection(),

                  const SizedBox(height: 25),

                  _buildAudienceSection(),

                  const SizedBox(height: 25),

                  _buildSelectedMembers(),

                  const SizedBox(height: 30),

                  _buildScheduleButton(),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Schedule a Meeting",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "Create a meeting for selected classes, departments "
          "or individual teachers.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // MEETING DETAILS
  // ==========================================================

  Widget _buildMeetingDetails() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: Icons.meeting_room_outlined,
            title: "Meeting Details",
          ),

          const SizedBox(height: 20),

          const Text(
            "Meeting Title",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: titleController,
            textInputAction: TextInputAction.next,
            decoration: _inputDecoration(
              hintText: "e.g. Monthly Class Teacher Meeting",
              icon: Icons.title_outlined,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "Description",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: descriptionController,
            maxLines: 4,
            decoration: _inputDecoration(
              hintText: "Enter meeting agenda or instructions...",
              icon: Icons.notes_outlined,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DATE & TIME
  // ==========================================================

  Widget _buildDateTimeSection() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: Icons.calendar_month_outlined,
            title: "Meeting Date & Time",
          ),

          const SizedBox(height: 10),

          Text(
            "Meeting can be scheduled from 30 minutes "
            "up to 72 hours in advance.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 18),

          InkWell(
            onTap: _selectDateTime,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE4D1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xFFE86F2D),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Meeting Date & Time",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          selectedDateTime == null
                              ? "Select date and time"
                              : _formatDateTime(
                                  selectedDateTime!,
                                ),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DURATION
  // ==========================================================

  Widget _buildDurationSection() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: Icons.timer_outlined,
            title: "Meeting Duration",
          ),

          const SizedBox(height: 18),

          DropdownButtonFormField<String>(
            value: selectedDuration,
            decoration: _inputDecoration(
              hintText: "Select duration",
              icon: Icons.schedule_outlined,
            ),
            items: durationOptions.map((duration) {
              return DropdownMenuItem<String>(
                value: duration,
                child: Text(duration),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                selectedDuration = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // AUDIENCE
  // ==========================================================

  Widget _buildAudienceSection() {
    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: Icons.people_alt_outlined,
            title: "Who Can Join?",
          ),

          const SizedBox(height: 8),

          Text(
            "Select groups or individual teachers. "
            "Only selected members will receive the meeting.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            "Select Groups",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          ...groups.map(
            (group) => _buildGroupTile(group),
          ),

          const SizedBox(height: 20),

          const Divider(),

          const SizedBox(height: 18),

          const Text(
            "Select Individual Teachers",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: teacherSearchController,
            onChanged: (_) {
              setState(() {});
            },
            decoration: _inputDecoration(
              hintText: "Search teacher...",
              icon: Icons.search,
            ),
          ),

          const SizedBox(height: 12),

          ..._filteredTeachers.map(
            (teacher) => _buildTeacherTile(teacher),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // GROUP TILE
  // ==========================================================

  Widget _buildGroupTile(
    Map<String, dynamic> group,
  ) {
    final id = group["id"] as String;
    final isSelected = selectedGroupIds.contains(id);

    final bool isClass = group["type"] == "Class";

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFFFE4D1)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: isSelected
              ? const Color(0xFFE86F2D)
              : Colors.grey.shade200,
        ),
      ),
      child: CheckboxListTile(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              selectedGroupIds.add(id);
            } else {
              selectedGroupIds.remove(id);
            }
          });
        },
        activeColor: const Color(0xFFE86F2D),
        secondary: Icon(
          isClass
              ? Icons.class_outlined
              : Icons.account_tree_outlined,
          color: isSelected
              ? const Color(0xFFE86F2D)
              : Colors.grey.shade700,
        ),
        title: Text(
          group["name"],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${group["type"]} • ${group["members"]} members",
        ),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  // ==========================================================
  // TEACHER TILE
  // ==========================================================

  Widget _buildTeacherTile(
    Map<String, dynamic> teacher,
  ) {
    final id = teacher["id"] as String;
    final isSelected = selectedTeacherIds.contains(id);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFFFE4D1)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: isSelected
              ? const Color(0xFFE86F2D)
              : Colors.grey.shade200,
        ),
      ),
      child: CheckboxListTile(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              selectedTeacherIds.add(id);
            } else {
              selectedTeacherIds.remove(id);
            }
          });
        },
        activeColor: const Color(0xFFE86F2D),
        secondary: CircleAvatar(
          backgroundColor: const Color(0xFFFFE4D1),
          child: Text(
            teacher["name"]
                .toString()
                .substring(0, 1)
                .toUpperCase(),
            style: const TextStyle(
              color: Color(0xFFE86F2D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          teacher["name"],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${teacher["role"]} • ${teacher["department"]}",
        ),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  // ==========================================================
  // SELECTED MEMBERS
  // ==========================================================

  Widget _buildSelectedMembers() {
    if (selectedGroupIds.isEmpty &&
        selectedTeacherIds.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.amber.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.amber.shade800,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                "No participants selected yet. "
                "Select at least one group or individual teacher.",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.amber.shade900,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return _sectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: Icons.check_circle_outline,
            title: "Selected Participants",
          ),

          const SizedBox(height: 15),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...selectedGroupIds.map((id) {
                final group = groups.firstWhere(
                  (item) => item["id"] == id,
                );

                return Chip(
                  avatar: const Icon(
                    Icons.groups_outlined,
                    size: 18,
                  ),
                  label: Text(group["name"]),
                  deleteIcon: const Icon(
                    Icons.close,
                    size: 17,
                  ),
                  onDeleted: () {
                    setState(() {
                      selectedGroupIds.remove(id);
                    });
                  },
                );
              }),

              ...selectedTeacherIds.map((id) {
                final teacher = teachers.firstWhere(
                  (item) => item["id"] == id,
                );

                return Chip(
                  avatar: const Icon(
                    Icons.person_outline,
                    size: 18,
                  ),
                  label: Text(teacher["name"]),
                  deleteIcon: const Icon(
                    Icons.close,
                    size: 17,
                  ),
                  onDeleted: () {
                    setState(() {
                      selectedTeacherIds.remove(id);
                    });
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SCHEDULE BUTTON
  // ==========================================================

  Widget _buildScheduleButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _scheduleMeeting,
        icon: const Icon(
          Icons.video_call_outlined,
        ),
        label: const Text(
          "Schedule Meeting",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE86F2D),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // FILTERED TEACHERS
  // ==========================================================

  List<Map<String, dynamic>> get _filteredTeachers {
    final query =
        teacherSearchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return teachers;
    }

    return teachers.where((teacher) {
      final name =
          teacher["name"].toString().toLowerCase();

      final role =
          teacher["role"].toString().toLowerCase();

      final department =
          teacher["department"]
              .toString()
              .toLowerCase();

      return name.contains(query) ||
          role.contains(query) ||
          department.contains(query);
    }).toList();
  }

  // ==========================================================
  // SELECT DATE & TIME
  // ==========================================================

  Future<void> _selectDateTime() async {
    final now = DateTime.now();

    final minimumTime =
        now.add(const Duration(minutes: 30));

    final maximumTime =
        now.add(const Duration(hours: 72));

    DateTime initialDate =
        selectedDateTime ?? minimumTime;

    if (initialDate.isBefore(minimumTime)) {
      initialDate = minimumTime;
    }

    if (initialDate.isAfter(maximumTime)) {
      initialDate = maximumTime;
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(
        minimumTime.year,
        minimumTime.month,
        minimumTime.day,
      ),
      lastDate: DateTime(
        maximumTime.year,
        maximumTime.month,
        maximumTime.day,
      ),
    );

    if (pickedDate == null) {
      return;
    }

    TimeOfDay initialTime =
        TimeOfDay.fromDateTime(initialDate);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime == null) {
      return;
    }

    final finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (finalDateTime.isBefore(minimumTime)) {
      _showMessage(
        "Meeting must be scheduled at least "
        "30 minutes from now.",
      );
      return;
    }

    if (finalDateTime.isAfter(maximumTime)) {
      _showMessage(
        "Meeting cannot be scheduled more than "
        "72 hours in advance.",
      );
      return;
    }

    setState(() {
      selectedDateTime = finalDateTime;
    });
  }

  // ==========================================================
  // SCHEDULE MEETING
  // ==========================================================

  void _scheduleMeeting() {
    if (titleController.text.trim().isEmpty) {
      _showMessage(
        "Please enter a meeting title.",
      );
      return;
    }

    if (selectedDateTime == null) {
      _showMessage(
        "Please select meeting date and time.",
      );
      return;
    }

    if (selectedGroupIds.isEmpty &&
        selectedTeacherIds.isEmpty) {
      _showMessage(
        "Please select at least one group or teacher.",
      );
      return;
    }

    final meetingData = {
      "title": titleController.text.trim(),
      "description":
          descriptionController.text.trim(),
      "dateTime":
          selectedDateTime!.toIso8601String(),
      "duration": selectedDuration,
      "groups": selectedGroupIds.toList(),
      "individualTeachers":
          selectedTeacherIds.toList(),
    };

    debugPrint(
      "MEETING DATA: $meetingData",
    );

    _showSuccessDialog();
  }

  // ==========================================================
  // SUCCESS DIALOG
  // ==========================================================

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Meeting Scheduled",
                ),
              ),
            ],
          ),
          content: const Text(
            "The meeting has been scheduled successfully. "
            "Only the selected groups and teachers will "
            "receive the meeting on their dashboard.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "Done",
                style: TextStyle(
                  color: Color(0xFFE86F2D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // SECTION CONTAINER
  // ==========================================================

  Widget _sectionContainer({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.035,
            ),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  // ==========================================================
  // SECTION TITLE
  // ==========================================================

  Widget _sectionTitle({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE4D1),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFE86F2D),
          ),
        ),

        const SizedBox(width: 12),

        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // INPUT DECORATION
  // ==========================================================

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
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
          color: Color(0xFFE86F2D),
          width: 1.5,
        ),
      ),
    );
  }

  // ==========================================================
  // DATE FORMAT
  // ==========================================================

  String _formatDateTime(DateTime dateTime) {
    final date =
        "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year}";

    final hour =
        dateTime.hour == 0
            ? 12
            : dateTime.hour > 12
                ? dateTime.hour - 12
                : dateTime.hour;

    final minute =
        dateTime.minute.toString().padLeft(2, '0');

    final period =
        dateTime.hour >= 12 ? "PM" : "AM";

    return "$date • $hour:$minute $period";
  }

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    teacherSearchController.dispose();
    super.dispose();
  }
}