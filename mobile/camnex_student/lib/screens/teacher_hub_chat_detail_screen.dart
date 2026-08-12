import 'package:flutter/material.dart';

class TeacherHubChatDetailScreen extends StatefulWidget {
  final String groupName;
  final String groupType;
  final String? groupSubtitle;
  final List<Map<String, dynamic>>? members;

  const TeacherHubChatDetailScreen({
    super.key,
    required this.groupName,
    required this.groupType,
    this.groupSubtitle,
    this.members,
  });

  @override
  State<TeacherHubChatDetailScreen> createState() =>
      _TeacherHubChatDetailScreenState();
}

class _TeacherHubChatDetailScreenState
    extends State<TeacherHubChatDetailScreen> {
  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color camnexOrange = Color(0xFFF28C28);
  static const Color lightOrange = Color(0xFFFFF3E8);
  static const Color chatBackground = Color(0xFFF7F7F7);

  // ==========================================================
  // CONTROLLERS
  // ==========================================================

  final TextEditingController messageController =
      TextEditingController();

  final TextEditingController searchController =
      TextEditingController();

  final ScrollController scrollController =
      ScrollController();

  // ==========================================================
  // STATE
  // ==========================================================

  bool isSearching = false;

  String searchQuery = "";

  // ==========================================================
  // SAMPLE MEMBERS
  // Later this will come from backend/database.
  // ==========================================================

  final List<Map<String, dynamic>> defaultMembers = [
    {
      "id": "T001",
      "name": "Rahul Sharma",
      "role": "Mathematics Teacher",
      "department": "Mathematics",
      "isOnline": true,
    },
    {
      "id": "T002",
      "name": "Priya Singh",
      "role": "Science Teacher",
      "department": "Science",
      "isOnline": false,
    },
    {
      "id": "T003",
      "name": "Amit Kumar",
      "role": "English Teacher",
      "department": "English",
      "isOnline": true,
    },
    {
      "id": "T004",
      "name": "Neha Verma",
      "role": "Class Teacher",
      "department": "Academic",
      "isOnline": false,
    },
  ];

  // ==========================================================
  // SAMPLE CHAT MESSAGES
  // ==========================================================

  final List<Map<String, dynamic>> messages = [
    {
      "id": "M001",
      "senderId": "T002",
      "sender": "Priya Singh",
      "message":
          "Good morning everyone. Please submit the pending work today.",
      "time": "9:15 AM",
      "date": "Today",
      "isMe": false,
    },
    {
      "id": "M002",
      "senderId": "T003",
      "sender": "Amit Kumar",
      "message":
          "I have completed the English activity for this week.",
      "time": "9:22 AM",
      "date": "Today",
      "isMe": false,
    },
    {
      "id": "M003",
      "senderId": "CURRENT",
      "sender": "You",
      "message":
          "Great. I will update the class records accordingly.",
      "time": "9:28 AM",
      "date": "Today",
      "isMe": true,
    },
    {
      "id": "M004",
      "senderId": "T001",
      "sender": "Rahul Sharma",
      "message":
          "Can we discuss the upcoming assessment schedule?",
      "time": "9:35 AM",
      "date": "Today",
      "isMe": false,
    },
  ];

  // ==========================================================
  // GET MEMBERS
  // ==========================================================

  List<Map<String, dynamic>> get groupMembers {
    return widget.members ?? defaultMembers;
  }

  // ==========================================================
  // FILTER MESSAGES
  // ==========================================================

  List<Map<String, dynamic>> get filteredMessages {
    if (searchQuery.trim().isEmpty) {
      return messages;
    }

    final query = searchQuery.toLowerCase();

    return messages.where((message) {
      final text =
          "${message["sender"]} ${message["message"]}"
              .toLowerCase();

      return text.contains(query);
    }).toList();
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    messageController.dispose();
    searchController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chatBackground,

      appBar: _buildAppBar(),

      body: Column(
        children: [
          Expanded(
            child: _buildMessagesArea(),
          ),

          _buildMessageInput(),
        ],
      ),
    );
  }

  // ==========================================================
  // APP BAR
  // ==========================================================

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,

      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      titleSpacing: 0,

      title: isSearching
          ? TextField(
              controller: searchController,

              autofocus: true,

              decoration: const InputDecoration(
                hintText: "Search messages...",
                border: InputBorder.none,
              ),

              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            )
          : InkWell(
              onTap: _showGroupInfo,

              child: Row(
                children: [
                  _groupAvatar(
                    size: 42,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          widget.groupName,

                          maxLines: 1,

                          overflow:
                              TextOverflow.ellipsis,

                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          widget.groupSubtitle ??
                              "${groupMembers.length} members",

                          maxLines: 1,

                          overflow:
                              TextOverflow.ellipsis,

                          style: TextStyle(
                            fontSize: 11,
                            color:
                                Colors.grey.shade600,
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
          tooltip: "Search",
          icon: Icon(
            isSearching
                ? Icons.close
                : Icons.search,
          ),

          onPressed: () {
            setState(() {
              if (isSearching) {
                isSearching = false;
                searchQuery = "";
                searchController.clear();
              } else {
                isSearching = true;
              }
            });
          },
        ),

        PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
          ),

          onSelected: (value) {
            switch (value) {
              case "info":
                _showGroupInfo();
                break;

              case "members":
                _showMembers();
                break;

              case "search":
                setState(() {
                  isSearching = true;
                });
                break;
            }
          },

          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: "info",
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                    ),
                    SizedBox(width: 12),
                    Text("Group info"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "members",
                child: Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                    ),
                    SizedBox(width: 12),
                    Text("View members"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "search",
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(width: 12),
                    Text("Search messages"),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  // ==========================================================
  // GROUP AVATAR
  // ==========================================================

  Widget _groupAvatar({
    double size = 50,
  }) {
    return Container(
      width: size,
      height: size,

      decoration: BoxDecoration(
        color: lightOrange,
        shape: BoxShape.circle,
      ),

      child: Icon(
        widget.groupType.toLowerCase() == "department"
            ? Icons.business_outlined
            : Icons.groups_outlined,

        size: size * 0.52,

        color: camnexOrange,
      ),
    );
  }

  // ==========================================================
  // MESSAGE AREA
  // ==========================================================

  Widget _buildMessagesArea() {
    final visibleMessages = filteredMessages;

    if (visibleMessages.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 10),

            Text(
              "No messages found",

              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,

      padding: const EdgeInsets.fromLTRB(
        12,
        18,
        12,
        20,
      ),

      itemCount: visibleMessages.length,

      itemBuilder: (context, index) {
        final message =
            visibleMessages[index];

        return _buildMessageBubble(
          message,
        );
      },
    );
  }

  // ==========================================================
  // MESSAGE BUBBLE
  // ==========================================================

  Widget _buildMessageBubble(
    Map<String, dynamic> message,
  ) {
    final bool isMe =
        message["isMe"] == true;

    return Align(
      alignment: isMe
          ? Alignment.centerRight
          : Alignment.centerLeft,

      child: GestureDetector(
        onLongPress: () {
          _showMessageOptions(
            message,
          );
        },

        child: Container(
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width *
                    0.78,
          ),

          margin: const EdgeInsets.only(
            bottom: 10,
          ),

          padding: const EdgeInsets.fromLTRB(
            13,
            9,
            10,
            7,
          ),

          decoration: BoxDecoration(
            color: isMe
                ? const Color(0xFFFFE4D1)
                : Colors.white,

            borderRadius:
                BorderRadius.circular(16),

            border: Border.all(
              color: isMe
                  ? const Color(0xFFFFD1B0)
                  : Colors.grey.shade200,
            ),

            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withValues(
                  alpha: 0.025,
                ),

                blurRadius: 4,

                offset:
                    const Offset(0, 2),
              ),
            ],
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
                      color: camnexOrange,
                      fontSize: 12,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

              Text(
                message["message"],

                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
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
                        Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
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
          8,
          8,
          8,
          8,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withValues(
                alpha: 0.06,
              ),

              blurRadius: 8,

              offset:
                  const Offset(0, -2),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.end,

          children: [
            IconButton(
              tooltip: "Attachment",

              icon: Icon(
                Icons.attach_file,
                color: Colors.grey.shade700,
              ),

              onPressed:
                  _showAttachmentOptions,
            ),

            Expanded(
              child: Container(
                constraints:
                    const BoxConstraints(
                  maxHeight: 120,
                ),

                decoration: BoxDecoration(
                  color:
                      Colors.grey.shade100,

                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),
                ),

                child: TextField(
                  controller:
                      messageController,

                  minLines: 1,
                  maxLines: 5,

                  textCapitalization:
                      TextCapitalization.sentences,

                  decoration:
                      const InputDecoration(
                    hintText:
                        "Type a message",

                    border:
                        InputBorder.none,

                    contentPadding:
                        EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 11,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 6),

            Container(
              width: 46,
              height: 46,

              decoration:
                  const BoxDecoration(
                color: camnexOrange,
                shape: BoxShape.circle,
              ),

              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),

                onPressed: _sendMessage,
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
    final text =
        messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    setState(() {
      messages.add({
        "id":
            "M${DateTime.now().millisecondsSinceEpoch}",

        "senderId":
            "CURRENT",

        "sender":
            "You",

        "message":
            text,

        "time":
            _formatTime(
              DateTime.now(),
            ),

        "date":
            "Today",

        "isMe":
            true,
      });
    });

    messageController.clear();

    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (!scrollController.hasClients) {
          return;
        }

        scrollController.animateTo(
          scrollController.position
              .maxScrollExtent,

          duration:
              const Duration(
            milliseconds: 300,
          ),

          curve: Curves.easeOut,
        );
      },
    );

    // Later:
    // Send message to backend/database.
  }

  // ==========================================================
  // ATTACHMENT OPTIONS
  // ==========================================================

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  "Send Attachment",

                  style: TextStyle(
                    fontSize: 19,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceAround,

                  children: [
                    _attachmentOption(
                      Icons.image_outlined,
                      "Gallery",
                    ),

                    _attachmentOption(
                      Icons.camera_alt_outlined,
                      "Camera",
                    ),

                    _attachmentOption(
                      Icons.insert_drive_file_outlined,
                      "Document",
                    ),
                  ],
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // ATTACHMENT OPTION
  // ==========================================================

  Widget _attachmentOption(
    IconData icon,
    String title,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);

        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              "$title attachment selected.",
            ),
          ),
        );
      },

      borderRadius:
          BorderRadius.circular(14),

      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,

            decoration: BoxDecoration(
              color: lightOrange,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: camnexOrange,
              size: 27,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            title,

            style: const TextStyle(
              fontSize: 12,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // GROUP INFO
  // ==========================================================

  void _showGroupInfo() {
    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.white,

      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height:
                MediaQuery.of(context)
                        .size
                        .height *
                    0.72,

            child: Column(
              children: [
                const SizedBox(height: 12),

                Container(
                  width: 45,
                  height: 5,

                  decoration: BoxDecoration(
                    color:
                        Colors.grey.shade300,

                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                _groupAvatar(
                  size: 82,
                ),

                const SizedBox(height: 12),

                Text(
                  widget.groupName,

                  textAlign:
                      TextAlign.center,

                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  widget.groupType,

                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 20),

                const Divider(),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),

                  child: Row(
                    children: [
                      const Icon(
                        Icons.people_outline,
                        color:
                            camnexOrange,
                      ),

                      const SizedBox(width: 12),

                      Text(
                        "${groupMembers.length} members",

                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(),

                Expanded(
                  child:
                      ListView.builder(
                    itemCount:
                        groupMembers.length,

                    itemBuilder:
                        (context, index) {
                      return _buildMemberTile(
                        groupMembers[index],
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
  // MEMBERS LIST
  // ==========================================================

  void _showMembers() {
    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.white,

      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),

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
                const SizedBox(height: 18),

                const Text(
                  "Group Members",

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "${groupMembers.length} members",

                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 15),

                const Divider(),

                Expanded(
                  child:
                      ListView.builder(
                    itemCount:
                        groupMembers.length,

                    itemBuilder:
                        (context, index) {
                      return _buildMemberTile(
                        groupMembers[index],
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
  // MEMBER TILE
  // ==========================================================

  Widget _buildMemberTile(
    Map<String, dynamic> member,
  ) {
    final name =
        member["name"] ?? "Teacher";

    final role =
        member["role"] ?? "Teacher";

    final department =
        member["department"] ?? "";

    final isOnline =
        member["isOnline"] == true;

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),

      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,

            backgroundColor:
                lightOrange,

            child: Text(
              name
                  .toString()
                  .substring(0, 1)
                  .toUpperCase(),

              style: const TextStyle(
                color: camnexOrange,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          if (isOnline)
            Positioned(
              right: 0,
              bottom: 1,

              child: Container(
                width: 12,
                height: 12,

                decoration:
                    BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,

                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),

      title: Text(
        name,

        style: const TextStyle(
          fontWeight:
              FontWeight.w600,
        ),
      ),

      subtitle: Text(
        department.isEmpty
            ? role
            : "$role • $department",

        maxLines: 1,

        overflow:
            TextOverflow.ellipsis,

        style: TextStyle(
          fontSize: 12,
          color:
              Colors.grey.shade600,
        ),
      ),

      trailing: const Icon(
        Icons.chevron_right,
      ),

      onTap: () {
        Navigator.pop(context);

        _showMemberProfile(
          member,
        );
      },
    );
  }

  // ==========================================================
  // MEMBER PROFILE
  // ==========================================================

  void _showMemberProfile(
    Map<String, dynamic> member,
  ) {
    final name =
        member["name"] ?? "Teacher";

    final role =
        member["role"] ?? "Teacher";

    final department =
        member["department"] ?? "Academic";

    final isOnline =
        member["isOnline"] == true;

    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.all(25),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [
                CircleAvatar(
                  radius: 42,

                  backgroundColor:
                      lightOrange,

                  child: Text(
                    name
                        .toString()
                        .substring(0, 1)
                        .toUpperCase(),

                    style: const TextStyle(
                      fontSize: 30,
                      color:
                          camnexOrange,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  name,

                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  isOnline
                      ? "Online"
                      : "Offline",

                  style: TextStyle(
                    color: isOnline
                        ? Colors.green
                        : Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 20),

                _profileInfoRow(
                  Icons.work_outline,
                  "Role",
                  role,
                ),

                _profileInfoRow(
                  Icons.business_outlined,
                  "Department",
                  department,
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // PROFILE INFO ROW
  // ==========================================================

  Widget _profileInfoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      padding:
          const EdgeInsets.all(13),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,

        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(
            icon,
            color: camnexOrange,
            size: 21,
          ),

          const SizedBox(width: 12),

          Text(
            "$title: ",

            style: TextStyle(
              color:
                  Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          Expanded(
            child: Text(
              value,

              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MESSAGE OPTIONS
  // ==========================================================

  void _showMessageOptions(
    Map<String, dynamic> message,
  ) {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,

      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [
              ListTile(
                leading: const Icon(
                  Icons.reply_outlined,
                ),

                title: const Text(
                  "Reply",
                ),

                onTap: () {
                  Navigator.pop(context);

                  messageController.text =
                      "Replying to ${message["sender"]}: ";
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.copy_outlined,
                ),

                title: const Text(
                  "Copy",
                ),

                onTap: () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Message copied.",
                      ),
                    ),
                  );
                },
              ),

              if (message["isMe"] == true)
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),

                  title: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context);

                    setState(() {
                      messages.removeWhere(
                        (item) =>
                            item["id"] ==
                            message["id"],
                      );
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // TIME FORMAT
  // ==========================================================

  String _formatTime(
    DateTime date,
  ) {
    final hour =
        date.hour == 0
            ? 12
            : date.hour > 12
                ? date.hour - 12
                : date.hour;

    final minute =
        date.minute
            .toString()
            .padLeft(2, "0");

    final period =
        date.hour >= 12
            ? "PM"
            : "AM";

    return "$hour:$minute $period";
  }
}