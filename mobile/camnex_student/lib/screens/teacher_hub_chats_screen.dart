import 'package:flutter/material.dart';

class TeacherHubChatsScreen extends StatefulWidget {
  const TeacherHubChatsScreen({super.key});

  @override
  State<TeacherHubChatsScreen> createState() =>
      _TeacherHubChatsScreenState();
}

class _TeacherHubChatsScreenState extends State<TeacherHubChatsScreen> {
  // ==========================================================
  // SEARCH
  // ==========================================================

  final TextEditingController searchController =
      TextEditingController();

  final TextEditingController messageController =
      TextEditingController();

  String searchQuery = "";

  // ==========================================================
  // FILTERS
  // ==========================================================

  String? selectedClassFilter;
  String? selectedDepartmentFilter;

  // ==========================================================
  // SELECTED GROUP
  // ==========================================================

  Map<String, dynamic>? selectedGroup;

  // ==========================================================
  // AVAILABLE CLASSES
  // ==========================================================

  final List<String> classes = [
    "V-A",
    "VI-A",
    "VII-A",
    "VIII-A",
    "IX-A",
  ];

  // ==========================================================
  // DEPARTMENTS
  // ==========================================================

  final List<String> departments = [
    "Mathematics",
    "Science",
    "English",
    "Social Science",
    "Computer Science",
  ];

  // ==========================================================
  // GROUP DATA
  //
  // Later this will come from backend/database.
  // ==========================================================

  final List<Map<String, dynamic>> groups = [
    {
      "id": "CLASS_V_A",
      "name": "Class V-A Teachers",
      "type": "class",
      "class": "V-A",
      "department": null,
      "description":
          "Official teacher group for Class V-A.",
      "members": [
        {
          "id": "T001",
          "name": "Rahul Sharma",
          "role": "Class Teacher",
          "subject": "Mathematics",
          "initial": "R",
        },
        {
          "id": "T002",
          "name": "Priya Singh",
          "role": "Subject Teacher",
          "subject": "Science",
          "initial": "P",
        },
        {
          "id": "T003",
          "name": "Amit Kumar",
          "role": "Subject Teacher",
          "subject": "English",
          "initial": "A",
        },
      ],
      "lastMessage":
          "Please submit the class activity report.",
      "lastMessageTime": "10:42 AM",
      "date": "Today",
      "unread": 3,
      "messages": [
        {
          "sender": "Rahul Sharma",
          "message":
              "Please submit the class activity report.",
          "time": "10:42 AM",
          "isMe": false,
        },
        {
          "sender": "You",
          "message":
              "I will submit it before lunch.",
          "time": "10:45 AM",
          "isMe": true,
        },
      ],
    },
    {
      "id": "CLASS_VIII_A",
      "name": "Class VIII-A Teachers",
      "type": "class",
      "class": "VIII-A",
      "department": null,
      "description":
          "Official teacher group for Class VIII-A.",
      "members": [
        {
          "id": "T004",
          "name": "Anita Verma",
          "role": "Class Teacher",
          "subject": "Science",
          "initial": "A",
        },
        {
          "id": "T005",
          "name": "Vikas Kumar",
          "role": "Subject Teacher",
          "subject": "Mathematics",
          "initial": "V",
        },
        {
          "id": "T006",
          "name": "Neha Singh",
          "role": "Subject Teacher",
          "subject": "English",
          "initial": "N",
        },
      ],
      "lastMessage":
          "Tomorrow's timetable has been updated.",
      "lastMessageTime": "Yesterday",
      "date": "Yesterday",
      "unread": 0,
      "messages": [
        {
          "sender": "Anita Verma",
          "message":
              "Tomorrow's timetable has been updated.",
          "time": "4:15 PM",
          "isMe": false,
        },
        {
          "sender": "You",
          "message":
              "Thanks for the update.",
          "time": "4:19 PM",
          "isMe": true,
        },
      ],
    },
    {
      "id": "CLASS_IX_A",
      "name": "Class IX-A Teachers",
      "type": "class",
      "class": "IX-A",
      "department": null,
      "description":
          "Official teacher group for Class IX-A.",
      "members": [
        {
          "id": "T007",
          "name": "Sanjay Kumar",
          "role": "Class Teacher",
          "subject": "Mathematics",
          "initial": "S",
        },
        {
          "id": "T008",
          "name": "Pooja Sharma",
          "role": "Subject Teacher",
          "subject": "Science",
          "initial": "P",
        },
      ],
      "lastMessage":
          "Unit test schedule needs confirmation.",
      "lastMessageTime": "Yesterday",
      "date": "Yesterday",
      "unread": 5,
      "messages": [
        {
          "sender": "Sanjay Kumar",
          "message":
              "Unit test schedule needs confirmation.",
          "time": "3:30 PM",
          "isMe": false,
        },
      ],
    },
    {
      "id": "DEPT_MATH",
      "name": "Mathematics Department",
      "type": "department",
      "class": null,
      "department": "Mathematics",
      "description":
          "Official Mathematics department group.",
      "members": [
        {
          "id": "T009",
          "name": "Rakesh Gupta",
          "role": "HOD",
          "subject": "Mathematics",
          "initial": "R",
        },
        {
          "id": "T010",
          "name": "Aman Sharma",
          "role": "Subject Teacher",
          "subject": "Mathematics",
          "initial": "A",
        },
        {
          "id": "T011",
          "name": "Kavita Singh",
          "role": "Subject Teacher",
          "subject": "Mathematics",
          "initial": "K",
        },
      ],
      "lastMessage":
          "Department meeting is scheduled for Friday.",
      "lastMessageTime": "Monday",
      "date": "Monday",
      "unread": 2,
      "messages": [
        {
          "sender": "Rakesh Gupta",
          "message":
              "Department meeting is scheduled for Friday.",
          "time": "11:20 AM",
          "isMe": false,
        },
        {
          "sender": "You",
          "message":
              "Noted, sir.",
          "time": "11:25 AM",
          "isMe": true,
        },
      ],
    },
    {
      "id": "DEPT_SCIENCE",
      "name": "Science Department",
      "type": "department",
      "class": null,
      "department": "Science",
      "description":
          "Official Science department group.",
      "members": [
        {
          "id": "T012",
          "name": "Meena Verma",
          "role": "HOD",
          "subject": "Science",
          "initial": "M",
        },
        {
          "id": "T013",
          "name": "Arun Kumar",
          "role": "Subject Teacher",
          "subject": "Science",
          "initial": "A",
        },
      ],
      "lastMessage":
          "Please review the practical schedule.",
      "lastMessageTime": "Monday",
      "date": "Monday",
      "unread": 0,
      "messages": [
        {
          "sender": "Meena Verma",
          "message":
              "Please review the practical schedule.",
          "time": "9:40 AM",
          "isMe": false,
        },
      ],
    },
    {
      "id": "DEPT_ENGLISH",
      "name": "English Department",
      "type": "department",
      "class": null,
      "department": "English",
      "description":
          "Official English department group.",
      "members": [
        {
          "id": "T014",
          "name": "Sunita Sharma",
          "role": "HOD",
          "subject": "English",
          "initial": "S",
        },
        {
          "id": "T015",
          "name": "Nitin Kumar",
          "role": "Subject Teacher",
          "subject": "English",
          "initial": "N",
        },
      ],
      "lastMessage":
          "New reading material has been uploaded.",
      "lastMessageTime": "Sunday",
      "date": "Sunday",
      "unread": 0,
      "messages": [
        {
          "sender": "Sunita Sharma",
          "message":
              "New reading material has been uploaded.",
          "time": "2:10 PM",
          "isMe": false,
        },
      ],
    },
  ];

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {
        searchQuery =
            searchController.text.trim().toLowerCase();
      });
    });
  }

  // ==========================================================
  // FILTERED GROUPS
  // ==========================================================

  List<Map<String, dynamic>> get filteredGroups {
    List<Map<String, dynamic>> result =
        List<Map<String, dynamic>>.from(groups);

    // Class filter
    if (selectedClassFilter != null) {
      result = result.where((group) {
        return group["type"] == "class" &&
            group["class"] == selectedClassFilter;
      }).toList();
    }

    // Department filter
    if (selectedDepartmentFilter != null) {
      result = result.where((group) {
        return group["type"] == "department" &&
            group["department"] ==
                selectedDepartmentFilter;
      }).toList();
    }

    // Search
    if (searchQuery.isNotEmpty) {
      result = result.where((group) {
        final name =
            group["name"].toString().toLowerCase();

        final description =
            group["description"]
                .toString()
                .toLowerCase();

        final className =
            group["class"]
                ?.toString()
                .toLowerCase() ??
            "";

        final department =
            group["department"]
                ?.toString()
                .toLowerCase() ??
            "";

        return name.contains(searchQuery) ||
            description.contains(searchQuery) ||
            className.contains(searchQuery) ||
            department.contains(searchQuery);
      }).toList();
    }

    return result;
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          "Teacher Hub • Chats",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Group information",
            onPressed: selectedGroup == null
                ? null
                : () {
                    _showGroupInfo(selectedGroup!);
                  },
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
      body: isMobile
          ? _buildMobileLayout()
          : _buildDesktopLayout(),
    );
  }

  // ==========================================================
  // DESKTOP / TABLET
  // ==========================================================

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        SizedBox(
          width: 360,
          child: _buildGroupList(),
        ),
        Expanded(
          child: selectedGroup == null
              ? _buildEmptyChat()
              : _buildChatWindow(),
        ),
      ],
    );
  }

  // ==========================================================
  // MOBILE
  // ==========================================================

  Widget _buildMobileLayout() {
    return _buildGroupList();
  }

  // ==========================================================
  // GROUP LIST
  // ==========================================================

  Widget _buildGroupList() {
    final groupsToShow = filteredGroups;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // ==================================================
          // SEARCH
          // ==================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              8,
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText:
                    "Search classes or departments...",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                        ),
                      )
                    : null,
                filled: true,
                fillColor:
                    const Color(0xFFF2F3F5),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ==================================================
          // FILTER BUTTONS
          // ==================================================

          _buildFilterBar(),

          const Divider(
            height: 1,
          ),

          // ==================================================
          // GROUP LIST
          // ==================================================

          Expanded(
            child: groupsToShow.isEmpty
                ? _buildNoGroups()
                : ListView.builder(
                    padding:
                        const EdgeInsets.only(
                      top: 8,
                      bottom: 20,
                    ),
                    itemCount:
                        groupsToShow.length,
                    itemBuilder:
                        (context, index) {
                      final group =
                          groupsToShow[index];

                      return _buildGroupTile(
                        group,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // FILTER BAR
  // ==========================================================

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _filterChip(
              icon: Icons.class_outlined,
              label: selectedClassFilter ??
                  "Class",
              active:
                  selectedClassFilter != null,
              onTap: _showClassFilter,
            ),
            const SizedBox(width: 8),
            _filterChip(
              icon: Icons.menu_book_outlined,
              label:
                  selectedDepartmentFilter ??
                      "Department",
              active:
                  selectedDepartmentFilter !=
                      null,
              onTap:
                  _showDepartmentFilter,
            ),
            if (selectedClassFilter != null ||
                selectedDepartmentFilter != null)
              Padding(
                padding:
                    const EdgeInsets.only(
                  left: 8,
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedClassFilter =
                          null;
                      selectedDepartmentFilter =
                          null;
                    });
                  },
                  child: const Text(
                    "Clear",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // FILTER CHIP
  // ==========================================================

  Widget _filterChip({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(20),
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFFFE8DA)
              : const Color(0xFFF3F4F6),
          borderRadius:
              BorderRadius.circular(20),
          border: Border.all(
            color: active
                ? const Color(0xFFFF8A4C)
                : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: active
                  ? const Color(0xFFE86F2D)
                  : Colors.grey.shade700,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: active
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: active
                    ? const Color(0xFFE86F2D)
                    : Colors.grey.shade800,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // GROUP TILE
  // ==========================================================

  Widget _buildGroupTile(
      Map<String, dynamic> group) {
    final isSelected =
        selectedGroup?["id"] == group["id"];

    final int unread =
        group["unread"] ?? 0;

    return InkWell(
      onTap: () {
        _openGroup(group);
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFF3EC)
              : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade100,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildGroupAvatar(group),
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
                          group["name"],
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        group["lastMessageTime"],
                        style: TextStyle(
                          fontSize: 11,
                          color: unread > 0
                              ? const Color(
                                  0xFFE86F2D,
                                )
                              : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          group["lastMessage"],
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color:
                                Colors.grey.shade600,
                          ),
                        ),
                      ),
                      if (unread > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          constraints:
                              const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 6,
                          ),
                          decoration:
                              const BoxDecoration(
                            color: Color(
                              0xFFE86F2D,
                            ),
                            shape: BoxShape.circle,
                          ),
                          alignment:
                              Alignment.center,
                          child: Text(
                            unread.toString(),
                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // GROUP AVATAR
  // ==========================================================

  Widget _buildGroupAvatar(
      Map<String, dynamic> group) {
    final bool isClass =
        group["type"] == "class";

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: isClass
            ? const Color(0xFFFFE8DA)
            : const Color(0xFFFFF1E8),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isClass
            ? Icons.groups_outlined
            : Icons.menu_book_outlined,
        color:
            const Color(0xFFE86F2D),
        size: 26,
      ),
    );
  }

  // ==========================================================
  // EMPTY CHAT
  // ==========================================================

  Widget _buildEmptyChat() {
    return Container(
      color: const Color(0xFFF7F8FA),
      child: Center(
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xFFFFE8DA),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.forum_outlined,
                size: 45,
                color: Color(0xFFE86F2D),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Teacher Hub Chats",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Select a class or department group\n"
              "to start viewing conversations.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // CHAT WINDOW
  // ==========================================================

  Widget _buildChatWindow() {
    final group = selectedGroup!;

    final messages =
        group["messages"]
            as List<dynamic>;

    return Container(
      color: const Color(0xFFF7F8FA),
      child: Column(
        children: [
          // ==================================================
          // CHAT HEADER
          // ==================================================

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),
            decoration:
                const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE5E7EB),
                ),
              ),
            ),
            child: Row(
              children: [
                _buildGroupAvatar(group),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _showGroupInfo(group);
                    },
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          group["name"],
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "${group["members"].length} members",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors
                                .grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "Group info",
                  onPressed: () {
                    _showGroupInfo(group);
                  },
                  icon: const Icon(
                    Icons.info_outline,
                  ),
                ),
              ],
            ),
          ),

          // ==================================================
          // MESSAGES
          // ==================================================

          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Text(
                      "No messages yet.",
                      style: TextStyle(
                        color:
                            Colors.grey.shade600,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.all(18),
                    itemCount:
                        messages.length,
                    itemBuilder:
                        (context, index) {
                      final message =
                          messages[index]
                              as Map<String,
                                  dynamic>;

                      return _buildMessageBubble(
                        message,
                      );
                    },
                  ),
          ),

          // ==================================================
          // MESSAGE INPUT
          // ==================================================

          _buildMessageInput(),
        ],
      ),
    );
  }

  // ==========================================================
  // MESSAGE BUBBLE
  // ==========================================================

  Widget _buildMessageBubble(
      Map<String, dynamic> message) {
    final bool isMe =
        message["isMe"] == true;

    return Align(
      alignment: isMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints:
            const BoxConstraints(
          maxWidth: 520,
        ),
        margin:
            const EdgeInsets.only(
          bottom: 10,
        ),
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFFFFE8DA)
              : Colors.white,
          borderRadius:
              BorderRadius.only(
            topLeft:
                const Radius.circular(16),
            topRight:
                const Radius.circular(16),
            bottomLeft:
                Radius.circular(
              isMe ? 16 : 4,
            ),
            bottomRight:
                Radius.circular(
              isMe ? 4 : 16,
            ),
          ),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 4,
                ),
                child: Text(
                  message["sender"],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFFE86F2D),
                  ),
                ),
              ),
            Text(
              message["message"],
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment:
                  Alignment.bottomRight,
              child: Text(
                message["time"],
                style: TextStyle(
                  fontSize: 10,
                  color:
                      Colors.grey.shade500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // MESSAGE INPUT
  // ==========================================================

  Widget _buildMessageInput() {
    return SafeArea(
      top: false,
      child: Container(
        padding:
            const EdgeInsets.fromLTRB(
          12,
          10,
          12,
          10,
        ),
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              tooltip: "Attachment",
              onPressed: () {
                _showMessage(
                  "Attachment feature will be connected to backend.",
                );
              },
              icon: const Icon(
                Icons.attach_file,
              ),
            ),
            Expanded(
              child: TextField(
                controller:
                    messageController,
                textInputAction:
                    TextInputAction.send,
                onSubmitted: (_) {
                  _sendMessage();
                },
                decoration:
                    InputDecoration(
                  hintText:
                      "Type a message...",
                  filled: true,
                  fillColor:
                      const Color(
                    0xFFF2F3F5,
                  ),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),
                    borderSide:
                        BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration:
                  const BoxDecoration(
                color:
                    Color(0xFFE86F2D),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _sendMessage,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SEND MESSAGE
  // ==========================================================

  void _sendMessage() {
    if (selectedGroup == null) {
      return;
    }

    final text =
        messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      final messages =
          selectedGroup!["messages"]
              as List<dynamic>;

      messages.add({
        "sender": "You",
        "message": text,
        "time": _currentTime(),
        "isMe": true,
      });

      selectedGroup!["lastMessage"] =
          text;
      selectedGroup!["lastMessageTime"] =
          "Now";
    });

    messageController.clear();
  }

  // ==========================================================
  // OPEN GROUP
  // ==========================================================

  void _openGroup(
      Map<String, dynamic> group) {
    setState(() {
      selectedGroup = group;

      group["unread"] = 0;
    });

    // On mobile open chat page.
    if (MediaQuery.of(context).size.width <
        700) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              _TeacherHubMobileChatScreen(
            group: group,
            onMessageSent: () {
              setState(() {});
            },
          ),
        ),
      );
    }
  }

  // ==========================================================
  // CLASS FILTER
  // ==========================================================

  void _showClassFilter() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding:
                const EdgeInsets.all(16),
            children: [
              const Text(
                "Select Class",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...classes.map(
                (className) {
                  return ListTile(
                    leading: const Icon(
                      Icons.class_outlined,
                    ),
                    title: Text(
                      "Class $className",
                    ),
                    trailing:
                        selectedClassFilter ==
                                className
                            ? const Icon(
                                Icons.check,
                                color: Color(
                                  0xFFE86F2D,
                                ),
                              )
                            : null,
                    onTap: () {
                      setState(() {
                        selectedClassFilter =
                            className;
                        selectedDepartmentFilter =
                            null;
                      });

                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // DEPARTMENT FILTER
  // ==========================================================

  void _showDepartmentFilter() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding:
                const EdgeInsets.all(16),
            children: [
              const Text(
                "Select Department",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...departments.map(
                (department) {
                  return ListTile(
                    leading: const Icon(
                      Icons.menu_book_outlined,
                    ),
                    title:
                        Text(department),
                    trailing:
                        selectedDepartmentFilter ==
                                department
                            ? const Icon(
                                Icons.check,
                                color: Color(
                                  0xFFE86F2D,
                                ),
                              )
                            : null,
                    onTap: () {
                      setState(() {
                        selectedDepartmentFilter =
                            department;
                        selectedClassFilter =
                            null;
                      });

                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // GROUP INFORMATION
  // ==========================================================

  void _showGroupInfo(
      Map<String, dynamic> group) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final members =
            group["members"]
                as List<dynamic>;

        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.72,
            minChildSize: 0.45,
            maxChildSize: 0.92,
            builder:
                (context, scrollController) {
              return Column(
                children: [
                  // =========================================
                  // GROUP HEADER
                  // =========================================

                  Padding(
                    padding:
                        const EdgeInsets.all(
                      20,
                    ),
                    child: Column(
                      children: [
                        _buildGroupAvatar(
                          group,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          group["name"],
                          textAlign:
                              TextAlign.center,
                          style:
                              const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          group["description"],
                          textAlign:
                              TextAlign.center,
                          style: TextStyle(
                            color: Colors
                                .grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${members.length} members",
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(),

                  Padding(
                    padding:
                        const EdgeInsets
                            .fromLTRB(
                      20,
                      12,
                      20,
                      8,
                    ),
                    child: Align(
                      alignment:
                          Alignment.centerLeft,
                      child: Text(
                        "Members",
                        style:
                            const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // =========================================
                  // MEMBERS
                  // =========================================

                  Expanded(
                    child: ListView.builder(
                      controller:
                          scrollController,
                      itemCount:
                          members.length,
                      itemBuilder:
                          (context, index) {
                        final member =
                            members[index]
                                as Map<String,
                                    dynamic>;

                        return ListTile(
                          onTap: () {
                            _showMemberProfile(
                              member,
                            );
                          },
                          leading:
                              CircleAvatar(
                            backgroundColor:
                                const Color(
                              0xFFFFE8DA,
                            ),
                            child: Text(
                              member[
                                  "initial"],
                              style:
                                  const TextStyle(
                                color:
                                    Color(
                                  0xFFE86F2D,
                                ),
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            member["name"],
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                          subtitle:
                              Text(
                            "${member["role"]} • "
                            "${member["subject"]}",
                            style:
                                const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          trailing:
                              const Icon(
                            Icons
                                .chevron_right,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // ==========================================================
  // MEMBER PROFILE
  // ==========================================================

  void _showMemberProfile(
      Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              20,
            ),
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor:
                    const Color(
                  0xFFFFE8DA,
                ),
                child: Text(
                  member["initial"],
                  style:
                      const TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFFE86F2D),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                member["name"],
                style:
                    const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                member["role"],
                style: TextStyle(
                  color:
                      Colors.grey.shade600,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                member["subject"],
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.w600,
                  color:
                      Color(0xFFE86F2D),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child:
                    OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                    _showMessage(
                      "Direct messaging will be connected to backend.",
                    );
                  },
                  icon: const Icon(
                    Icons.message_outlined,
                  ),
                  label: const Text(
                    "Message",
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // NO GROUPS
  // ==========================================================

  Widget _buildNoGroups() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(30),
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Icon(
              Icons.forum_outlined,
              size: 55,
              color: Colors
                  .grey.shade400,
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              "No conversations found",
              style: TextStyle(
                fontSize: 17,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Try another class, department "
              "or search term.",
              textAlign:
                  TextAlign.center,
              style: TextStyle(
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
  // CURRENT TIME
  // ==========================================================

  String _currentTime() {
    final now = DateTime.now();

    final hour =
        now.hour > 12 ? now.hour - 12 : now.hour;

    final minute =
        now.minute.toString().padLeft(2, "0");

    final period =
        now.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $period";
  }

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void _showMessage(String message) {
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
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    searchController.dispose();
    messageController.dispose();
    super.dispose();
  }
}

// =================================================================
// MOBILE CHAT SCREEN
// =================================================================

class _TeacherHubMobileChatScreen
    extends StatefulWidget {
  final Map<String, dynamic> group;
  final VoidCallback onMessageSent;

  const _TeacherHubMobileChatScreen({
    required this.group,
    required this.onMessageSent,
  });

  @override
  State<_TeacherHubMobileChatScreen>
      createState() =>
          _TeacherHubMobileChatScreenState();
}

class _TeacherHubMobileChatScreenState
    extends State<_TeacherHubMobileChatScreen> {
  final TextEditingController
      messageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messages =
        widget.group["messages"]
            as List<dynamic>;

    final members =
        widget.group["members"]
            as List<dynamic>;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor:
            Colors.black87,
        elevation: 0,
        titleSpacing: 0,
        title: InkWell(
          onTap: () {
            _showGroupInfo();
          },
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration:
                    const BoxDecoration(
                  color:
                      Color(0xFFFFE8DA),
                  shape:
                      BoxShape.circle,
                ),
                child: const Icon(
                  Icons.groups_outlined,
                  color:
                      Color(0xFFE86F2D),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.group[
                          "name"],
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          const TextStyle(
                        fontSize: 15,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${members.length} members",
                      style:
                          const TextStyle(
                        fontSize: 11,
                        color:
                            Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed:
                _showGroupInfo,
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              itemCount:
                  messages.length,
              itemBuilder:
                  (context, index) {
                final message =
                    messages[index]
                        as Map<String,
                            dynamic>;

                final isMe =
                    message["isMe"] ==
                        true;

                return Align(
                  alignment: isMe
                      ? Alignment
                          .centerRight
                      : Alignment
                          .centerLeft,
                  child: Container(
                    constraints:
                        const BoxConstraints(
                      maxWidth: 320,
                    ),
                    margin:
                        const EdgeInsets
                            .only(
                      bottom: 10,
                    ),
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration:
                        BoxDecoration(
                      color: isMe
                          ? const Color(
                              0xFFFFE8DA,
                            )
                          : Colors.white,
                      borderRadius:
                          BorderRadius
                              .only(
                        topLeft:
                            const Radius
                                .circular(
                          16,
                        ),
                        topRight:
                            const Radius
                                .circular(
                          16,
                        ),
                        bottomLeft:
                            Radius.circular(
                          isMe ? 16 : 4,
                        ),
                        bottomRight:
                            Radius.circular(
                          isMe ? 4 : 16,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        if (!isMe)
                          Text(
                            message[
                                "sender"],
                            style:
                                const TextStyle(
                              color:
                                  Color(
                                0xFFE86F2D,
                              ),
                              fontSize:
                                  11,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        if (!isMe)
                          const SizedBox(
                            height: 3,
                          ),
                        Text(
                          message[
                              "message"],
                          style:
                              const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Align(
                          alignment:
                              Alignment
                                  .bottomRight,
                          child: Text(
                            message[
                                "time"],
                            style:
                                const TextStyle(
                              fontSize: 9,
                              color:
                                  Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildInput(),
        ],
      ),
    );
  }

  // ==========================================================
  // MOBILE INPUT
  // ==========================================================

  Widget _buildInput() {
    return SafeArea(
      top: false,
      child: Container(
        padding:
            const EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller:
                    messageController,
                textInputAction:
                    TextInputAction.send,
                onSubmitted: (_) {
                  _sendMessage();
                },
                decoration:
                    InputDecoration(
                  hintText:
                      "Type a message...",
                  filled: true,
                  fillColor:
                      const Color(
                    0xFFF2F3F5,
                  ),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),
                    borderSide:
                        BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              decoration:
                  const BoxDecoration(
                color:
                    Color(0xFFE86F2D),
                shape:
                    BoxShape.circle,
              ),
              child: IconButton(
                onPressed:
                    _sendMessage,
                icon:
                    const Icon(
                  Icons.send,
                  color:
                      Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SEND
  // ==========================================================

  void _sendMessage() {
    final text =
        messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      final messages =
          widget.group["messages"]
              as List<dynamic>;

      messages.add({
        "sender": "You",
        "message": text,
        "time":
            _currentTime(),
        "isMe": true,
      });

      widget.group["lastMessage"] =
          text;
      widget.group[
              "lastMessageTime"] =
          "Now";
    });

    messageController.clear();

    widget.onMessageSent();
  }

  // ==========================================================
  // GROUP INFO
  // ==========================================================

  void _showGroupInfo() {
    final members =
        widget.group["members"]
            as List<dynamic>;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height:
                MediaQuery.of(context)
                        .size
                        .height *
                    0.75,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const CircleAvatar(
                  radius: 35,
                  backgroundColor:
                      Color(0xFFFFE8DA),
                  child: Icon(
                    Icons.groups_outlined,
                    size: 35,
                    color:
                        Color(0xFFE86F2D),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  widget.group[
                      "name"],
                  textAlign:
                      TextAlign.center,
                  style:
                      const TextStyle(
                    fontSize: 19,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${members.length} members",
                  style:
                      const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const Divider(
                  height: 30,
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Align(
                    alignment:
                        Alignment.centerLeft,
                    child: Text(
                      "Members",
                      style:
                          TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      ListView.builder(
                    itemCount:
                        members.length,
                    itemBuilder:
                        (context, index) {
                      final member =
                          members[index]
                              as Map<String,
                                  dynamic>;

                      return ListTile(
                        leading:
                            CircleAvatar(
                          backgroundColor:
                              const Color(
                            0xFFFFE8DA,
                          ),
                          child: Text(
                            member[
                                "initial"],
                            style:
                                const TextStyle(
                              color:
                                  Color(
                                0xFFE86F2D,
                              ),
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                        title:
                            Text(
                          member[
                              "name"],
                        ),
                        subtitle:
                            Text(
                          "${member["role"]} • "
                          "${member["subject"]}",
                        ),
                        onTap: () {
                          _showMember(
                            member,
                          );
                        },
                      );
                    },
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
  // MEMBER
  // ==========================================================

  void _showMember(
      Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            member["name"],
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor:
                    const Color(
                  0xFFFFE8DA,
                ),
                child: Text(
                  member["initial"],
                  style:
                      const TextStyle(
                    fontSize: 24,
                    color:
                        Color(
                      0xFFE86F2D,
                    ),
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                member["role"],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                member["subject"],
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // TIME
  // ==========================================================

  String _currentTime() {
    final now = DateTime.now();

    final hour =
        now.hour > 12
            ? now.hour - 12
            : now.hour;

    final minute =
        now.minute
            .toString()
            .padLeft(
              2,
              "0",
            );

    final period =
        now.hour >= 12
            ? "PM"
            : "AM";

    return "$hour:$minute $period";
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}