import 'package:flutter/material.dart';

class TeacherHubMeetingsScreen extends StatefulWidget {
  const TeacherHubMeetingsScreen({super.key});

  @override
  State<TeacherHubMeetingsScreen> createState() =>
      _TeacherHubMeetingsScreenState();
}

class _TeacherHubMeetingsScreenState
    extends State<TeacherHubMeetingsScreen> {
  // ==========================================================
  // CAMNEX THEME
  // ==========================================================

  static const Color camnexOrange =
      Color(0xFFF59E0B);

  static const Color lightOrange =
      Color(0xFFFFF7ED);

  // ==========================================================
  // SAMPLE GROUPS
  //
  // Later this will come from backend/database.
  // ==========================================================

  final List<Map<String, dynamic>> groups = [
    {
      "id": "CLASS_VA",
      "name": "Class V-A",
      "type": "Class Group",
      "memberCount": 8,
    },
    {
      "id": "CLASS_VIA",
      "name": "Class VI-A",
      "type": "Class Group",
      "memberCount": 9,
    },
    {
      "id": "CLASS_VIIA",
      "name": "Class VII-A",
      "type": "Class Group",
      "memberCount": 10,
    },
    {
      "id": "CLASS_VIIIA",
      "name": "Class VIII-A",
      "type": "Class Group",
      "memberCount": 12,
    },
    {
      "id": "CLASS_IXA",
      "name": "Class IX-A",
      "type": "Class Group",
      "memberCount": 11,
    },
    {
      "id": "MATH",
      "name": "Mathematics Department",
      "type": "Department Group",
      "memberCount": 7,
    },
    {
      "id": "SCIENCE",
      "name": "Science Department",
      "type": "Department Group",
      "memberCount": 6,
    },
    {
      "id": "ENGLISH",
      "name": "English Department",
      "type": "Department Group",
      "memberCount": 5,
    },
  ];

  // ==========================================================
  // SAMPLE TEACHERS
  // ==========================================================

  final List<Map<String, dynamic>> teachers = [
    {
      "id": "T001",
      "name": "Rahul Sharma",
      "role": "Class Teacher",
      "department": "Mathematics",
    },
    {
      "id": "T002",
      "name": "Priya Singh",
      "role": "Subject Teacher",
      "department": "Science",
    },
    {
      "id": "T003",
      "name": "Amit Kumar",
      "role": "Subject Teacher",
      "department": "English",
    },
    {
      "id": "T004",
      "name": "Neha Verma",
      "role": "Subject Teacher",
      "department": "Mathematics",
    },
    {
      "id": "T005",
      "name": "Vivek Singh",
      "role": "Subject Teacher",
      "department": "Social Science",
    },
    {
      "id": "T006",
      "name": "Ananya Gupta",
      "role": "Subject Teacher",
      "department": "Hindi",
    },
    {
      "id": "T007",
      "name": "Rohan Kumar",
      "role": "Class Teacher",
      "department": "Science",
    },
    {
      "id": "T008",
      "name": "Sneha Sharma",
      "role": "Subject Teacher",
      "department": "Mathematics",
    },
  ];

  // ==========================================================
  // SAMPLE MEETINGS
  //
  // DateTime values are generated relative to current time
  // so the demo remains meaningful.
  // ==========================================================

  late List<Map<String, dynamic>> meetings;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    meetings = [
      {
        "id": "M001",
        "title": "Class VIII-A Discussion",
        "description":
            "Discussion regarding student performance.",
        "startTime":
            now.add(const Duration(hours: 2)),
        "duration": 60,
        "participants": [
          "Class VIII-A",
        ],
        "status": "UPCOMING",
      },
      {
        "id": "M002",
        "title": "Mathematics Department Meeting",
        "description":
            "Monthly Mathematics department discussion.",
        "startTime":
            now.add(const Duration(hours: 24)),
        "duration": 90,
        "participants": [
          "Mathematics Department",
        ],
        "status": "UPCOMING",
      },
      {
        "id": "M003",
        "title": "Previous Staff Discussion",
        "description":
            "Discussion regarding upcoming activities.",
        "startTime":
            now.subtract(const Duration(hours: 5)),
        "duration": 45,
        "participants": [
          "Class VII-A",
          "Science Department",
        ],
        "status": "COMPLETED",
      },
    ];
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final upcomingMeetings =
        meetings.where((meeting) {
      final startTime =
          meeting["startTime"] as DateTime;

      return startTime.isAfter(now);
    }).toList();

    final pastMeetings =
        meetings.where((meeting) {
      final startTime =
          meeting["startTime"] as DateTime;

      final difference =
          now.difference(startTime);

      return startTime.isBefore(now) &&
          difference.inHours <= 48;
    }).toList();

    upcomingMeetings.sort(
      (a, b) =>
          (a["startTime"] as DateTime)
              .compareTo(
            b["startTime"] as DateTime,
          ),
    );

    pastMeetings.sort(
      (a, b) =>
          (b["startTime"] as DateTime)
              .compareTo(
            a["startTime"] as DateTime,
          ),
    );

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,

        title: const Text(
          "Meetings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: false,

        actions: [
          IconButton(
            onPressed: _openScheduleMeeting,
            tooltip: "Schedule Meeting",
            icon: const Icon(
              Icons.add_circle_outline,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            final isTablet =
                constraints.maxWidth >= 600;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal:
                    isTablet ? 35 : 16,
                vertical: 18,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  _buildHeader(),

                  const SizedBox(height: 22),

                  // ==================================================
                  // UPCOMING
                  // ==================================================

                  _buildSectionTitle(
                    "Upcoming Meetings",
                    Icons.event_available_outlined,
                  ),

                  const SizedBox(height: 12),

                  if (upcomingMeetings.isEmpty)
                    _buildEmptyState(
                      "No upcoming meetings",
                      "Meetings scheduled for you will appear here.",
                      Icons.event_busy_outlined,
                    )
                  else
                    ...upcomingMeetings.map(
                      (meeting) =>
                          _buildMeetingCard(
                        meeting,
                        isUpcoming: true,
                      ),
                    ),

                  const SizedBox(height: 30),

                  // ==================================================
                  // PAST 48 HOURS
                  // ==================================================

                  _buildSectionTitle(
                    "Past 48 Hours",
                    Icons.history_outlined,
                  ),

                  const SizedBox(height: 12),

                  if (pastMeetings.isEmpty)
                    _buildEmptyState(
                      "No recent meetings",
                      "Meetings from the last 48 hours will appear here.",
                      Icons.history_toggle_off_outlined,
                    )
                  else
                    ...pastMeetings.map(
                      (meeting) =>
                          _buildMeetingCard(
                        meeting,
                        isUpcoming: false,
                      ),
                    ),

                  const SizedBox(height: 25),
                ],
              ),
            );
          },
        ),
      ),

      // ==========================================================
      // SCHEDULE BUTTON
      // ==========================================================

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: _openScheduleMeeting,

        backgroundColor:
            camnexOrange,

        foregroundColor:
            Colors.white,

        icon: const Icon(
          Icons.video_call_outlined,
        ),

        label: const Text(
          "Schedule Meeting",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF7ED),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color: Colors.orange.shade100,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Container(
            width: 54,
            height: 54,

            decoration: BoxDecoration(
              color: camnexOrange,
              borderRadius:
                  BorderRadius.circular(15),
            ),

            child: const Icon(
              Icons.video_call_outlined,
              color: Colors.white,
              size: 29,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  "Teacher Meetings",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "View your recent meetings and "
                  "schedule meetings with selected "
                  "teachers or groups.",
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color:
                        Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SECTION TITLE
  // ==========================================================

  Widget _buildSectionTitle(
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,

          decoration: BoxDecoration(
            color: lightOrange,
            borderRadius:
                BorderRadius.circular(10),
          ),

          child: Icon(
            icon,
            size: 20,
            color: camnexOrange,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // MEETING CARD
  // ==========================================================

  Widget _buildMeetingCard(
    Map<String, dynamic> meeting, {
    required bool isUpcoming,
  }) {
    final title =
        meeting["title"].toString();

    final description =
        meeting["description"].toString();

    final startTime =
        meeting["startTime"] as DateTime;

    final duration =
        meeting["duration"] as int;

    final participants =
        List<String>.from(
      meeting["participants"] ?? [],
    );

    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(17),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: 0.025,
            ),
            blurRadius: 8,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(17),

        onTap: () {
          _showMeetingDetails(
            meeting,
            isUpcoming,
          );
        },

        child: Padding(
          padding:
              const EdgeInsets.all(15),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // ==================================================
                  // DATE BOX
                  // ==================================================

                  Container(
                    width: 58,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 9,
                    ),

                    decoration: BoxDecoration(
                      color: isUpcoming
                          ? lightOrange
                          : Colors.grey.shade100,

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child: Column(
                      children: [
                        Text(
                          _monthShort(
                            startTime.month,
                          ),

                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w600,
                            color: isUpcoming
                                ? camnexOrange
                                : Colors.grey
                                    .shade600,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          startTime.day
                              .toString(),

                          style:
                              const TextStyle(
                            fontSize: 21,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 13),

                  // ==================================================
                  // MEETING INFORMATION
                  // ==================================================

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,

                          style:
                              const TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          description,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,

                          style: TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: Colors
                                .grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ==================================================
                  // STATUS
                  // ==================================================

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),

                    decoration: BoxDecoration(
                      color: isUpcoming
                          ? Colors.green.shade50
                          : Colors.grey.shade100,

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Text(
                      isUpcoming
                          ? "Upcoming"
                          : "Past",

                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w600,
                        color: isUpcoming
                            ? Colors.green.shade700
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ==================================================
              // TIME / DURATION
              // ==================================================

              Wrap(
                spacing: 14,
                runSpacing: 8,

                children: [
                  _smallMeetingInfo(
                    Icons.access_time_outlined,
                    _formatTime(startTime),
                  ),

                  _smallMeetingInfo(
                    Icons.timer_outlined,
                    "$duration min",
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ==================================================
              // PARTICIPANTS
              // ==================================================

              Wrap(
                spacing: 6,
                runSpacing: 6,

                children: participants
                    .map(
                      (participant) =>
                          Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),

                        decoration:
                            BoxDecoration(
                          color: Colors
                              .grey.shade50,

                          borderRadius:
                              BorderRadius
                                  .circular(
                            20,
                          ),

                          border:
                              Border.all(
                            color: Colors
                                .grey.shade200,
                          ),
                        ),

                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min,

                          children: [
                            const Icon(
                              Icons.groups_outlined,
                              size: 14,
                              color:
                                  camnexOrange,
                            ),

                            const SizedBox(
                              width: 5,
                            ),

                            Text(
                              participant,
                              style:
                                  const TextStyle(
                                fontSize: 11,
                                fontWeight:
                                    FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),

              if (isUpcoming) ...[
                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _joinMeeting(
                            meeting,
                          );
                        },

                        icon: const Icon(
                          Icons
                              .video_camera_front_outlined,
                          size: 18,
                        ),

                        label: const Text(
                          "Join Meeting",
                        ),

                        style:
                            OutlinedButton
                                .styleFrom(
                          foregroundColor:
                              camnexOrange,

                          side:
                              const BorderSide(
                            color:
                                camnexOrange,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              11,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    IconButton(
                      onPressed: () {
                        _confirmCancelMeeting(
                          meeting,
                        );
                      },

                      tooltip:
                          "Cancel Meeting",

                      style:
                          IconButton.styleFrom(
                        backgroundColor:
                            Colors.red.shade50,
                      ),

                      icon: Icon(
                        Icons
                            .delete_outline,
                        color:
                            Colors.red.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SMALL MEETING INFO
  // ==========================================================

  Widget _smallMeetingInfo(
    IconData icon,
    String text,
  ) {
    return Row(
      mainAxisSize:
          MainAxisSize.min,

      children: [
        Icon(
          icon,
          size: 15,
          color: camnexOrange,
        ),

        const SizedBox(width: 5),

        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
            fontWeight:
                FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _buildEmptyState(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(28),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(17),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,

            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              size: 30,
              color: Colors.grey.shade500,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            subtitle,
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SCHEDULE MEETING
  // ==========================================================

  void _openScheduleMeeting() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TeacherScheduleMeetingScreen(
          groups: groups,
          teachers: teachers,
          onMeetingCreated: (
            meeting,
          ) {
            setState(() {
              meetings.add(meeting);
            });
          },
        ),
      ),
    );
  }

  // ==========================================================
  // SHOW MEETING DETAILS
  // ==========================================================

  void _showMeetingDetails(
    Map<String, dynamic> meeting,
    bool isUpcoming,
  ) {
    final startTime =
        meeting["startTime"] as DateTime;

    final duration =
        meeting["duration"] as int;

    final participants =
        List<String>.from(
      meeting["participants"] ?? [],
    );

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor:
          Colors.transparent,

      builder: (context) {
        return SafeArea(
          child: Container(
            width: double.infinity,

            padding:
                const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              25,
            ),

            decoration:
                const BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,

                    margin:
                        const EdgeInsets.only(
                      bottom: 20,
                    ),

                    decoration: BoxDecoration(
                      color:
                          Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                ),

                Text(
                  meeting["title"].toString(),
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  meeting["description"]
                      .toString(),
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color:
                        Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 20),

                _detailRow(
                  Icons.calendar_today_outlined,
                  "Date",
                  _formatDate(startTime),
                ),

                _detailRow(
                  Icons.access_time_outlined,
                  "Time",
                  _formatTime(startTime),
                ),

                _detailRow(
                  Icons.timer_outlined,
                  "Duration",
                  "$duration minutes",
                ),

                const SizedBox(height: 12),

                const Text(
                  "Participants",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 8),

                Wrap(
                  spacing: 7,
                  runSpacing: 7,

                  children: participants
                      .map(
                        (participant) =>
                            Chip(
                          avatar:
                              const Icon(
                            Icons
                                .groups_outlined,
                            size: 16,
                            color:
                                camnexOrange,
                          ),

                          label: Text(
                            participant,
                          ),

                          backgroundColor:
                              lightOrange,

                          side: BorderSide.none,
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 20),

                if (isUpcoming)
                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child:
                        ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );

                        _joinMeeting(
                          meeting,
                        );
                      },

                      icon: const Icon(
                        Icons
                            .video_camera_front_outlined,
                      ),

                      label: const Text(
                        "Join Meeting",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            camnexOrange,
                        foregroundColor:
                            Colors.white,
                        elevation: 0,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            13,
                          ),
                        ),
                      ),
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
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),

      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,

            decoration: BoxDecoration(
              color: lightOrange,
              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: Icon(
              icon,
              size: 19,
              color: camnexOrange,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color:
                        Colors.grey.shade500,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style:
                      const TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // JOIN MEETING
  // ==========================================================

  void _joinMeeting(
    Map<String, dynamic> meeting,
  ) {
    _showMessage(
      "Meeting link will open here after "
      "the video meeting service is connected.",
    );
  }

  // ==========================================================
  // CANCEL MEETING
  // ==========================================================

  void _confirmCancelMeeting(
    Map<String, dynamic> meeting,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),

          title: const Text(
            "Cancel Meeting?",
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          content: const Text(
            "Are you sure you want to cancel "
            "this meeting? Selected participants "
            "will no longer see it as an upcoming meeting.",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                "Keep Meeting",
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  meetings.remove(
                    meeting,
                  );
                });

                _showMessage(
                  "Meeting cancelled successfully.",
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red.shade600,
                foregroundColor:
                    Colors.white,
              ),

              child: const Text(
                "Cancel Meeting",
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void _showMessage(
    String message,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  // ==========================================================
  // DATE
  // ==========================================================

  String _formatDate(
    DateTime date,
  ) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  // ==========================================================
  // TIME
  // ==========================================================

  String _formatTime(
    DateTime date,
  ) {
    final hour =
        date.hour % 12 == 0
            ? 12
            : date.hour % 12;

    final minute =
        date.minute.toString().padLeft(
              2,
              '0',
            );

    final period =
        date.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $period";
  }

  // ==========================================================
  // MONTH
  // ==========================================================

  String _monthShort(
    int month,
  ) {
    const months = [
      "JAN",
      "FEB",
      "MAR",
      "APR",
      "MAY",
      "JUN",
      "JUL",
      "AUG",
      "SEP",
      "OCT",
      "NOV",
      "DEC",
    ];

    return months[month - 1];
  }
}

// =================================================================
// SCHEDULE MEETING SCREEN
// =================================================================

class TeacherScheduleMeetingScreen
    extends StatefulWidget {
  final List<Map<String, dynamic>> groups;

  final List<Map<String, dynamic>> teachers;

  final Function(
    Map<String, dynamic> meeting,
  ) onMeetingCreated;

  const TeacherScheduleMeetingScreen({
    super.key,
    required this.groups,
    required this.teachers,
    required this.onMeetingCreated,
  });

  @override
  State<TeacherScheduleMeetingScreen>
      createState() =>
          _TeacherScheduleMeetingScreenState();
}

class _TeacherScheduleMeetingScreenState
    extends State<TeacherScheduleMeetingScreen> {
  // ==========================================================
  // THEME
  // ==========================================================

  static const Color camnexOrange =
      Color(0xFFF59E0B);

  static const Color lightOrange =
      Color(0xFFFFF7ED);

  // ==========================================================
  // CONTROLLERS
  // ==========================================================

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  final TextEditingController teacherSearchController =
      TextEditingController();

  // ==========================================================
  // DATE / TIME
  // ==========================================================

  DateTime? selectedDateTime;

  // ==========================================================
  // DURATION
  // ==========================================================

  int selectedDuration = 30;

  final List<int> durationOptions = [
    30,
    45,
    60,
    90,
    120,
  ];

  // ==========================================================
  // GROUP / TEACHER SELECTION
  // ==========================================================

  final Set<String> selectedGroupIds = {};

  final Set<String> selectedTeacherIds = {};

  String teacherSearch = "";

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    teacherSearchController.dispose();
    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final filteredTeachers =
        widget.teachers.where((teacher) {
      if (teacherSearch.trim().isEmpty) {
        return true;
      }

      final query =
          teacherSearch.toLowerCase();

      return teacher["name"]
              .toString()
              .toLowerCase()
              .contains(query) ||
          teacher["department"]
              .toString()
              .toLowerCase()
              .contains(query) ||
          teacher["role"]
              .toString()
              .toLowerCase()
              .contains(query);
    }).toList();

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,

        title: const Text(
          "Schedule Meeting",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              _buildInformationCard(),

              const SizedBox(height: 22),

              _sectionLabel(
                "Meeting Details",
              ),

              const SizedBox(height: 10),

              // ==================================================
              // TITLE
              // ==================================================

              TextField(
                controller:
                    titleController,

                decoration:
                    _inputDecoration(
                  "Meeting title",
                  Icons.title_outlined,
                ),
              ),

              const SizedBox(height: 14),

              // ==================================================
              // DESCRIPTION
              // ==================================================

              TextField(
                controller:
                    descriptionController,

                maxLines: 4,

                decoration:
                    _inputDecoration(
                  "Meeting description",
                  Icons.notes_outlined,
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // DATE & TIME
              // ==================================================

              _sectionLabel(
                "Meeting Date & Time",
              ),

              const SizedBox(height: 10),

              _buildDateTimePicker(),

              const SizedBox(height: 22),

              // ==================================================
              // DURATION
              // ==================================================

              _sectionLabel(
                "Meeting Duration",
              ),

              const SizedBox(height: 10),

              _buildDurationSelector(),

              const SizedBox(height: 22),

              // ==================================================
              // GROUPS
              // ==================================================

              _sectionLabel(
                "Select Groups",
              ),

              const SizedBox(height: 5),

              Text(
                "Everyone in selected groups will receive "
                "this meeting.",
                style: TextStyle(
                  fontSize: 12,
                  color:
                      Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 10),

              ...widget.groups.map(
                (group) =>
                    _buildGroupOption(group),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // INDIVIDUAL TEACHERS
              // ==================================================

              _sectionLabel(
                "Select Individual Teachers",
              ),

              const SizedBox(height: 5),

              Text(
                "You can also manually select individual "
                "teachers.",
                style: TextStyle(
                  fontSize: 12,
                  color:
                      Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller:
                    teacherSearchController,

                onChanged: (value) {
                  setState(() {
                    teacherSearch =
                        value;
                  });
                },

                decoration:
                    _inputDecoration(
                  "Search teachers",
                  Icons.search,
                ),
              ),

              const SizedBox(height: 10),

              ...filteredTeachers.map(
                (teacher) =>
                    _buildTeacherOption(
                  teacher,
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // SELECTED RECIPIENTS
              // ==================================================

              _buildSelectedRecipients(),

              const SizedBox(height: 25),

              // ==================================================
              // SCHEDULE
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton.icon(
                  onPressed:
                      _scheduleMeeting,

                  icon: const Icon(
                    Icons.video_call_outlined,
                  ),

                  label: const Text(
                    "Schedule Meeting",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        camnexOrange,

                    foregroundColor:
                        Colors.white,

                    elevation: 0,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // INFORMATION CARD
  // ==========================================================

  Widget _buildInformationCard() {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: lightOrange,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.orange.shade100,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Icon(
            Icons.info_outline,
            color: camnexOrange,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              "Meetings can be scheduled from "
              "30 minutes up to 72 hours in advance. "
              "Only selected groups or teachers will "
              "receive the meeting.",
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color:
                    Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SECTION LABEL
  // ==========================================================

  Widget _sectionLabel(
    String title,
  ) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ==========================================================
  // INPUT DECORATION
  // ==========================================================

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,

      prefixIcon: Icon(icon),

      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide:
            const BorderSide(
          color: camnexOrange,
          width: 1.5,
        ),
      ),
    );
  }

  // ==========================================================
  // DATE TIME PICKER
  // ==========================================================

  Widget _buildDateTimePicker() {
    return InkWell(
      onTap: _selectDateTime,

      borderRadius:
          BorderRadius.circular(14),

      child: Container(
        width: double.infinity,

        padding:
            const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(14),

          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: lightOrange,
                borderRadius:
                    BorderRadius.circular(
                  10,
                ),
              ),

              child: const Icon(
                Icons.calendar_month_outlined,
                color: camnexOrange,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Scheduled Time",
                    style: TextStyle(
                      fontSize: 11,
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

                    style:
                        const TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons
                  .arrow_forward_ios_rounded,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // DURATION SELECTOR
  // ==========================================================

  Widget _buildDurationSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,

      children:
          durationOptions.map((duration) {
        final selected =
            selectedDuration ==
                duration;

        return ChoiceChip(
          label: Text(
            "$duration min",
          ),

          selected: selected,

          onSelected: (_) {
            setState(() {
              selectedDuration =
                  duration;
            });
          },

          selectedColor:
              camnexOrange,

          backgroundColor:
              Colors.white,

          labelStyle: TextStyle(
            color: selected
                ? Colors.white
                : Colors.black87,

            fontWeight:
                FontWeight.w500,
          ),

          side: BorderSide(
            color: selected
                ? camnexOrange
                : Colors.grey.shade300,
          ),
        );
      }).toList(),
    );
  }

  // ==========================================================
  // GROUP OPTION
  // ==========================================================

  Widget _buildGroupOption(
    Map<String, dynamic> group,
  ) {
    final id =
        group["id"].toString();

    final selected =
        selectedGroupIds.contains(id);

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: selected
              ? camnexOrange
              : Colors.grey.shade200,
        ),
      ),

      child: CheckboxListTile(
        value: selected,

        activeColor:
            camnexOrange,

        onChanged: (value) {
          setState(() {
            if (value == true) {
              selectedGroupIds.add(id);
            } else {
              selectedGroupIds.remove(id);
            }
          });
        },

        title: Text(
          group["name"].toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        subtitle: Text(
          "${group["type"]} • "
          "${group["memberCount"]} members",
          style: TextStyle(
            fontSize: 11,
            color:
                Colors.grey.shade600,
          ),
        ),

        secondary: Container(
          width: 40,
          height: 40,

          decoration: BoxDecoration(
            color: lightOrange,
            borderRadius:
                BorderRadius.circular(
              10,
            ),
          ),

          child: const Icon(
            Icons.groups_outlined,
            color: camnexOrange,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // TEACHER OPTION
  // ==========================================================

  Widget _buildTeacherOption(
    Map<String, dynamic> teacher,
  ) {
    final id =
        teacher["id"].toString();

    final selected =
        selectedTeacherIds.contains(id);

    final name =
        teacher["name"].toString();

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 8,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: selected
              ? camnexOrange
              : Colors.grey.shade200,
        ),
      ),

      child: CheckboxListTile(
        value: selected,

        activeColor:
            camnexOrange,

        onChanged: (value) {
          setState(() {
            if (value == true) {
              selectedTeacherIds.add(id);
            } else {
              selectedTeacherIds.remove(id);
            }
          });
        },

        secondary: CircleAvatar(
          radius: 21,

          backgroundColor:
              lightOrange,

          child: Text(
            name
                .substring(0, 1)
                .toUpperCase(),

            style:
                const TextStyle(
              color: camnexOrange,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        title: Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        subtitle: Text(
          "${teacher["role"]} • "
          "${teacher["department"]}",
          style: TextStyle(
            fontSize: 11,
            color:
                Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SELECTED RECIPIENTS
  // ==========================================================

  Widget _buildSelectedRecipients() {
    final selectedGroups =
        widget.groups.where(
      (group) =>
          selectedGroupIds.contains(
        group["id"].toString(),
      ),
    );

    final selectedTeachers =
        widget.teachers.where(
      (teacher) =>
          selectedTeacherIds.contains(
        teacher["id"].toString(),
      ),
    );

    final total =
        selectedGroupIds.length +
            selectedTeacherIds.length;

    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              const Text(
                "Selected Recipients",
                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              Container(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: lightOrange,
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: Text(
                  "$total selected",
                  style:
                      const TextStyle(
                    color:
                        camnexOrange,
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (total == 0)
            Text(
              "No group or teacher selected.",
              style: TextStyle(
                fontSize: 12,
                color:
                    Colors.grey.shade600,
              ),
            ),

          if (selectedGroups.isNotEmpty)
            ...selectedGroups.map(
              (group) => _selectedChip(
                group["name"].toString(),
              ),
            ),

          if (selectedTeachers.isNotEmpty)
            ...selectedTeachers.map(
              (teacher) => _selectedChip(
                teacher["name"].toString(),
              ),
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // SELECTED CHIP
  // ==========================================================

  Widget _selectedChip(
    String name,
  ) {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(
        bottom: 7,
      ),

      padding:
          const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 9,
      ),

      decoration: BoxDecoration(
        color: lightOrange,

        borderRadius:
            BorderRadius.circular(10),
      ),

      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 17,
            color: camnexOrange,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight:
                    FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SELECT DATE & TIME
  //
  // Allowed:
  // minimum = now + 30 minutes
  // maximum = now + 72 hours
  // ==========================================================

  Future<void> _selectDateTime() async {
    final now = DateTime.now();

    final minimum =
        now.add(
      const Duration(
        minutes: 30,
      ),
    );

    final maximum =
        now.add(
      const Duration(
        hours: 72,
      ),
    );

    DateTime initialDate =
        selectedDateTime ?? minimum;

    if (initialDate.isBefore(minimum)) {
      initialDate = minimum;
    }

    if (initialDate.isAfter(maximum)) {
      initialDate = maximum;
    }

    final pickedDate =
        await showDatePicker(
      context: context,

      initialDate: initialDate,

      firstDate: DateTime(
        minimum.year,
        minimum.month,
        minimum.day,
      ),

      lastDate: DateTime(
        maximum.year,
        maximum.month,
        maximum.day,
      ),
    );

    if (pickedDate == null) {
      return;
    }

    TimeOfDay initialTime =
        TimeOfDay.fromDateTime(
      initialDate,
    );

    final pickedTime =
        await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime == null) {
      return;
    }

    final result = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // ==========================================================
    // VALIDATE 30 MINUTES
    // ==========================================================

    if (result.isBefore(minimum)) {
      _showError(
        "Meeting must be scheduled at least "
        "30 minutes from now.",
      );

      return;
    }

    // ==========================================================
    // VALIDATE 72 HOURS
    // ==========================================================

    if (result.isAfter(maximum)) {
      _showError(
        "Meeting cannot be scheduled more "
        "than 72 hours in advance.",
      );

      return;
    }

    setState(() {
      selectedDateTime =
          result;
    });
  }

  // ==========================================================
  // SCHEDULE
  // ==========================================================

  void _scheduleMeeting() {
    // ==========================================================
    // TITLE
    // ==========================================================

    if (titleController.text
        .trim()
        .isEmpty) {
      _showError(
        "Please enter a meeting title.",
      );

      return;
    }

    // ==========================================================
    // DATE
    // ==========================================================

    if (selectedDateTime == null) {
      _showError(
        "Please select meeting date and time.",
      );

      return;
    }

    // ==========================================================
    // RECIPIENTS
    // ==========================================================

    if (selectedGroupIds.isEmpty &&
        selectedTeacherIds.isEmpty) {
      _showError(
        "Please select at least one group "
        "or teacher.",
      );

      return;
    }

    final now = DateTime.now();

    final minimum =
        now.add(
      const Duration(
        minutes: 30,
      ),
    );

    final maximum =
        now.add(
      const Duration(
        hours: 72,
      ),
    );

    // ==========================================================
    // TIME VALIDATION
    // ==========================================================

    if (selectedDateTime!
        .isBefore(minimum)) {
      _showError(
        "Meeting must be scheduled at least "
        "30 minutes from now.",
      );

      return;
    }

    if (selectedDateTime!
        .isAfter(maximum)) {
      _showError(
        "Meeting cannot be scheduled more "
        "than 72 hours in advance.",
      );

      return;
    }

    // ==========================================================
    // PARTICIPANTS
    // ==========================================================

    final List<String>
        participantNames = [];

    for (final group
        in widget.groups) {
      if (selectedGroupIds
          .contains(
        group["id"].toString(),
      )) {
        participantNames.add(
          group["name"].toString(),
        );
      }
    }

    for (final teacher
        in widget.teachers) {
      if (selectedTeacherIds
          .contains(
        teacher["id"].toString(),
      )) {
        participantNames.add(
          teacher["name"].toString(),
        );
      }
    }

    // ==========================================================
    // CREATE MEETING
    // ==========================================================

    final meeting = {
      "id":
          "M${DateTime.now().millisecondsSinceEpoch}",

      "title":
          titleController.text.trim(),

      "description":
          descriptionController.text.trim(),

      "startTime":
          selectedDateTime,

      "duration":
          selectedDuration,

      "participants":
          participantNames,

      "status":
          "UPCOMING",
    };

    // ==========================================================
    // SEND TO PARENT SCREEN
    // ==========================================================

    widget.onMeetingCreated(
      meeting,
    );

    // ==========================================================
    // SUCCESS
    // ==========================================================

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Meeting scheduled successfully.",
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

  void _showError(
    String message,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  // ==========================================================
  // FORMAT DATE TIME
  // ==========================================================

  String _formatDateTime(
    DateTime date,
  ) {
    final hour =
        date.hour % 12 == 0
            ? 12
            : date.hour % 12;

    final minute =
        date.minute
            .toString()
            .padLeft(2, '0');

    final period =
        date.hour >= 12
            ? "PM"
            : "AM";

    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} • "
        "$hour:$minute $period";
  }
}