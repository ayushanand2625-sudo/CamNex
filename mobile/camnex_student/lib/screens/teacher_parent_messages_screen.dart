import 'package:flutter/material.dart';

class TeacherParentMessagesScreen extends StatefulWidget {
  const TeacherParentMessagesScreen({super.key});

  @override
  State<TeacherParentMessagesScreen> createState() =>
      _TeacherParentMessagesScreenState();
}

class _TeacherParentMessagesScreenState
    extends State<TeacherParentMessagesScreen> {
  // ==========================================================
  // SEARCH
  // ==========================================================

  final TextEditingController searchController = TextEditingController();

  String searchQuery = "";

  // Optional filters.
  String? selectedClassFilter;
  String? selectedSubjectFilter;
  String? selectedRoleFilter;

  // Currently selected conversation.
  Map<String, dynamic>? selectedConversation;

  // ==========================================================
  // AVAILABLE FILTERS
  //
  // Later these will come from the teacher's assignments.
  // ==========================================================

  final List<String> classes = [
    "V-A",
    "VI-A",
    "VII-A",
    "VIII-A",
    "IX-A",
  ];

  final List<String> subjects = [
    "Mathematics",
    "Science",
    "English",
    "Hindi",
    "Computer",
  ];

  final List<String> roles = [
    "Class Teacher",
    "Subject Teacher",
  ];

  // ==========================================================
  // RECENT CONVERSATIONS
  //
  // By default these are shown without requiring any filter.
  // Later this data will come from backend/database.
  // ==========================================================

  final List<Map<String, dynamic>> conversations = [
    {
      "parentId": "P001",
      "parentName": "Mrs. Sunita Sharma",
      "studentName": "Ayush Sharma",
      "class": "VIII-A",
      "subject": "Mathematics",
      "role": "Subject Teacher",
      "lastMessage": "Thanks sir, we will make sure he practices.",
      "time": "10:32 AM",
      "unread": 2,
    },
    {
      "parentId": "P002",
      "parentName": "Mr. Rajesh Kumar",
      "studentName": "Rohan Kumar",
      "class": "VIII-A",
      "subject": "Mathematics",
      "role": "Subject Teacher",
      "lastMessage": "Okay sir, thank you.",
      "time": "09:45 AM",
      "unread": 0,
    },
    {
      "parentId": "P003",
      "parentName": "Mrs. Pooja Singh",
      "studentName": "Priya Singh",
      "class": "VIII-A",
      "subject": "Class Teacher",
      "role": "Class Teacher",
      "lastMessage": "Can we discuss her progress?",
      "time": "Yesterday",
      "unread": 1,
    },
    {
      "parentId": "P004",
      "parentName": "Mr. Amit Verma",
      "studentName": "Ankit Verma",
      "class": "VII-A",
      "subject": "Science",
      "role": "Subject Teacher",
      "lastMessage": "I have checked the homework.",
      "time": "Yesterday",
      "unread": 0,
    },
    {
      "parentId": "P005",
      "parentName": "Mrs. Neha Gupta",
      "studentName": "Ananya Gupta",
      "class": "VIII-A",
      "subject": "English",
      "role": "Subject Teacher",
      "lastMessage": "Thank you for informing me.",
      "time": "Monday",
      "unread": 0,
    },
    {
      "parentId": "P006",
      "parentName": "Mr. Vivek Kumar",
      "studentName": "Vivek Kumar",
      "class": "IX-A",
      "subject": "Mathematics",
      "role": "Subject Teacher",
      "lastMessage": "I will speak with him.",
      "time": "Monday",
      "unread": 3,
    },
  ];

  // ==========================================================
  // CHAT MESSAGES
  // ==========================================================

  final Map<String, List<Map<String, dynamic>>> messages = {
    "P001": [
      {
        "sender": "parent",
        "message":
            "Hello sir, I wanted to ask about Ayush's Mathematics performance.",
        "time": "10:20 AM",
      },
      {
        "sender": "teacher",
        "message":
            "Hello ma'am. Ayush is doing well in Mathematics. He needs a little more practice with algebra.",
        "time": "10:25 AM",
      },
      {
        "sender": "parent",
        "message":
            "Okay sir. We will make sure he practices at home.",
        "time": "10:32 AM",
      },
    ],
    "P002": [
      {
        "sender": "parent",
        "message": "Sir, did Rohan submit today's homework?",
        "time": "09:35 AM",
      },
      {
        "sender": "teacher",
        "message": "Yes, he submitted it this morning.",
        "time": "09:40 AM",
      },
      {
        "sender": "parent",
        "message": "Okay sir, thank you.",
        "time": "09:45 AM",
      },
    ],
    "P003": [
      {
        "sender": "parent",
        "message":
            "Ma'am, can we discuss Priya's progress?",
        "time": "Yesterday",
      },
      {
        "sender": "teacher",
        "message":
            "Of course. Priya is performing well, but she can improve her class participation.",
        "time": "Yesterday",
      },
    ],
    "P004": [
      {
        "sender": "teacher",
        "message":
            "Hello sir. I have checked Ankit's Science homework.",
        "time": "Yesterday",
      },
      {
        "sender": "parent",
        "message": "Thank you for informing me.",
        "time": "Yesterday",
      },
    ],
    "P005": [
      {
        "sender": "parent",
        "message":
            "Ma'am, I wanted to know about Ananya's English class.",
        "time": "Monday",
      },
      {
        "sender": "teacher",
        "message":
            "She is participating well and completing her work regularly.",
        "time": "Monday",
      },
      {
        "sender": "parent",
        "message": "Thank you for informing me.",
        "time": "Monday",
      },
    ],
    "P006": [
      {
        "sender": "parent",
        "message":
            "Sir, Vivek has been having difficulty with the recent Mathematics chapter.",
        "time": "Monday",
      },
      {
        "sender": "teacher",
        "message":
            "I will give him some additional practice questions.",
        "time": "Monday",
      },
      {
        "sender": "parent",
        "message": "Thank you sir.",
        "time": "Monday",
      },
    ],
  };

  // ==========================================================
  // MESSAGE INPUT
  // ==========================================================

  final TextEditingController messageController =
      TextEditingController();

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    searchController.dispose();
    messageController.dispose();
    super.dispose();
  }

  // ==========================================================
  // FILTERED CONVERSATIONS
  // ==========================================================

  List<Map<String, dynamic>> get filteredConversations {
    final query = searchQuery.trim().toLowerCase();

    return conversations.where((conversation) {
      final parentName =
          conversation["parentName"].toString().toLowerCase();

      final studentName =
          conversation["studentName"].toString().toLowerCase();

      final className =
          conversation["class"].toString();

      final subject =
          conversation["subject"].toString();

      final role =
          conversation["role"].toString();

      // Search by parent or student.
      final matchesSearch =
          query.isEmpty ||
          parentName.contains(query) ||
          studentName.contains(query);

      // Optional class filter.
      final matchesClass =
          selectedClassFilter == null ||
          className == selectedClassFilter;

      // Optional subject filter.
      final matchesSubject =
          selectedSubjectFilter == null ||
          subject == selectedSubjectFilter;

      // Optional role filter.
      final matchesRole =
          selectedRoleFilter == null ||
          role == selectedRoleFilter;

      return matchesSearch &&
          matchesClass &&
          matchesSubject &&
          matchesRole;
    }).toList();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Parent Messages",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;

          if (isMobile) {
            return _buildMobileLayout();
          }

          return _buildDesktopLayout();
        },
      ),
    );
  }

  // ==========================================================
  // DESKTOP / TABLET
  // ==========================================================

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // ====================================================
        // LEFT SIDE - CONVERSATIONS
        // ====================================================

        SizedBox(
          width: 360,
          child: _buildConversationPanel(),
        ),

        // ====================================================
        // RIGHT SIDE - CHAT
        // ====================================================

        Expanded(
          child: selectedConversation == null
              ? _buildEmptyChat()
              : _buildChatPanel(),
        ),
      ],
    );
  }

  // ==========================================================
  // MOBILE
  // ==========================================================

  Widget _buildMobileLayout() {
    if (selectedConversation == null) {
      return _buildConversationPanel();
    }

    return _buildChatPanel(
      showBackButton: true,
    );
  }

  // ==========================================================
  // CONVERSATION PANEL
  // ==========================================================

  Widget _buildConversationPanel() {
    final filtered = filteredConversations;

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
              10,
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search parent or student...",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();

                          setState(() {
                            searchQuery = "";
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                        ),
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ==================================================
          // FILTER BUTTON
          // ==================================================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _filterStatusText(),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: _showFilterSheet,
                  icon: const Icon(
                    Icons.tune,
                    size: 18,
                  ),
                  label: const Text("Filter"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Divider(
            height: 1,
          ),

          // ==================================================
          // RECENT CONVERSATIONS HEADER
          // ==================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              8,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Recent Conversations",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "${filtered.length}",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // ==================================================
          // CONVERSATION LIST
          // ==================================================

          Expanded(
            child: filtered.isEmpty
                ? _buildNoConversations()
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final conversation =
                          filtered[index];

                      return _buildConversationTile(
                        conversation,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CONVERSATION TILE
  // ==========================================================

  Widget _buildConversationTile(
    Map<String, dynamic> conversation,
  ) {
    final parentId =
        conversation["parentId"].toString();

    final unread =
        conversation["unread"] as int? ?? 0;

    final isSelected =
        selectedConversation != null &&
        selectedConversation!["parentId"] ==
            parentId;

    return Material(
      color: isSelected
          ? Colors.blue.shade50
          : Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedConversation =
                conversation;

            // Mark messages as read.
            conversation["unread"] = 0;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 13,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade100,
              ),
            ),
          ),
          child: Row(
            children: [
              // =================================================
              // AVATAR
              // =================================================

              CircleAvatar(
                radius: 25,
                backgroundColor:
                    Colors.blue.shade50,
                child: Text(
                  _initials(
                    conversation["parentName"],
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // =================================================
              // INFORMATION
              // =================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation["parentName"],
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          conversation["time"],
                          style: TextStyle(
                            fontSize: 11,
                            color: unread > 0
                                ? const Color.fromARGB(255, 242, 132, 76)
                                : Colors.grey.shade500,
                            fontWeight: unread > 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    Text(
                      conversation["studentName"],
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation["lastMessage"],
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
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
                            ),
                            height: 20,
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            decoration:
                                const BoxDecoration(
                              color: Color.fromARGB(255, 242, 132, 76)
                            ),
                            alignment:
                                Alignment.center,
                            child: Text(
                              unread > 9
                                  ? "9+"
                                  : unread.toString(),
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
      ),
    );
  }

  // ==========================================================
  // EMPTY CHAT
  // ==========================================================

  Widget _buildEmptyChat() {
    return Container(
      color: const Color(0xFFF0F2F5),
      child: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 45,
                color: Colors.blue.shade600,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Select a conversation",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Choose a parent from the list to start "
              "or continue a conversation.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // CHAT PANEL
  // ==========================================================

  Widget _buildChatPanel({
    bool showBackButton = false,
  }) {
    final conversation =
        selectedConversation!;

    final parentId =
        conversation["parentId"].toString();

    final chatMessages =
        messages[parentId] ?? [];

    return Container(
      color: const Color(0xFFEFE7DE),
      child: Column(
        children: [
          // ==================================================
          // CHAT HEADER
          // ==================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            color: Colors.white,
            child: Row(
              children: [
                if (showBackButton)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedConversation =
                            null;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),

                CircleAvatar(
                  radius: 21,
                  backgroundColor:
                      Colors.blue.shade50,
                  child: Text(
                    _initials(
                      conversation["parentName"],
                    ),
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation["parentName"],
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        "Parent of ${conversation["studentName"]}"
                        " • ${conversation["class"]}",
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    _showConversationInfo(
                      conversation,
                    );
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
            child: chatMessages.isEmpty
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
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    itemCount:
                        chatMessages.length,
                    itemBuilder:
                        (context, index) {
                      return _buildMessageBubble(
                        chatMessages[index],
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
    Map<String, dynamic> message,
  ) {
    final isTeacher =
        message["sender"] == "teacher";

    return Align(
      alignment: isTeacher
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width *
                  0.65,
        ),
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: isTeacher
              ? const Color.fromRGBO(241, 188, 152, 1)
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft:
                const Radius.circular(12),
            topRight:
                const Radius.circular(12),
            bottomLeft: Radius.circular(
              isTeacher ? 12 : 2,
            ),
            bottomRight: Radius.circular(
              isTeacher ? 2 : 12,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [
            Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                message["message"],
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 3),

            Text(
              message["time"],
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
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
    return Container(
      padding: const EdgeInsets.fromLTRB(
        10,
        8,
        10,
        8,
      ),
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: _showAttachmentOptions,
              icon: const Icon(
                Icons.attach_file,
              ),
            ),

            Expanded(
              child: TextField(
                controller: messageController,
                minLines: 1,
                maxLines: 5,
                textInputAction:
                    TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  filled: true,
                  fillColor:
                      Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(24),
                    borderSide:
                        BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 11,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 6),

            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 242, 132, 76),
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
    final text =
        messageController.text.trim();

    if (text.isEmpty ||
        selectedConversation == null) {
      return;
    }

    final parentId =
        selectedConversation!["parentId"]
            .toString();

    final now = TimeOfDay.now();

    final time =
        now.format(context);

    setState(() {
      messages.putIfAbsent(
        parentId,
        () => [],
      );

      messages[parentId]!.add({
        "sender": "teacher",
        "message": text,
        "time": time,
      });

      selectedConversation!["lastMessage"] =
          text;

      selectedConversation!["time"] =
          time;

      messageController.clear();

      // Move conversation to top.
      conversations.remove(
        selectedConversation,
      );

      conversations.insert(
        0,
        selectedConversation!,
      );
    });
  }

  // ==========================================================
  // FILTER STATUS
  // ==========================================================

  String _filterStatusText() {
    final filters = <String>[];

    if (selectedClassFilter != null) {
      filters.add(selectedClassFilter!);
    }

    if (selectedSubjectFilter != null) {
      filters.add(selectedSubjectFilter!);
    }

    if (selectedRoleFilter != null) {
      filters.add(selectedRoleFilter!);
    }

    if (filters.isEmpty) {
      return "Showing recent conversations";
    }

    return filters.join(" • ");
  }

  // ==========================================================
  // FILTER SHEET
  // ==========================================================

  void _showFilterSheet() {
    String? tempClass =
        selectedClassFilter;

    String? tempSubject =
        selectedSubjectFilter;

    String? tempRole =
        selectedRoleFilter;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  25,
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Filter Conversations",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // =================================================
                    // CLASS
                    // =================================================

                    const Text(
                      "Class",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 7),

                    DropdownButtonFormField<String>(
                      value: tempClass,
                      isExpanded: true,
                      hint: const Text(
                        "All Classes",
                      ),
                      decoration:
                          InputDecoration(
                        prefixIcon:
                            const Icon(
                          Icons.class_outlined,
                        ),
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      12),
                        ),
                      ),
                      items: classes
                          .map(
                            (item) =>
                                DropdownMenuItem<
                                    String>(
                              value: item,
                              child:
                                  Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setSheetState(() {
                          tempClass = value;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // SUBJECT
                    // =================================================

                    const Text(
                      "Subject",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 7),

                    DropdownButtonFormField<String>(
                      value: tempSubject,
                      isExpanded: true,
                      hint: const Text(
                        "All Subjects",
                      ),
                      decoration:
                          InputDecoration(
                        prefixIcon:
                            const Icon(
                          Icons.menu_book_outlined,
                        ),
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      12),
                        ),
                      ),
                      items: subjects
                          .map(
                            (item) =>
                                DropdownMenuItem<
                                    String>(
                              value: item,
                              child:
                                  Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setSheetState(() {
                          tempSubject = value;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // ROLE
                    // =================================================

                    const Text(
                      "Teacher Role",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 7),

                    DropdownButtonFormField<String>(
                      value: tempRole,
                      isExpanded: true,
                      hint: const Text(
                        "All Roles",
                      ),
                      decoration:
                          InputDecoration(
                        prefixIcon:
                            const Icon(
                          Icons.person_outline,
                        ),
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      12),
                        ),
                      ),
                      items: roles
                          .map(
                            (item) =>
                                DropdownMenuItem<
                                    String>(
                              value: item,
                              child:
                                  Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setSheetState(() {
                          tempRole = value;
                        });
                      },
                    ),

                    const SizedBox(height: 25),

                    // =================================================
                    // BUTTONS
                    // =================================================

                    Row(
                      children: [
                        Expanded(
                          child:
                              OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedClassFilter =
                                    null;
                                selectedSubjectFilter =
                                    null;
                                selectedRoleFilter =
                                    null;
                              });

                              Navigator.pop(
                                context,
                              );
                            },
                            style:
                                OutlinedButton
                                    .styleFrom(
                              minimumSize:
                                  const Size(
                                0,
                                50,
                              ),
                            ),
                            child:
                                const Text(
                              "Clear",
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          flex: 2,
                          child:
                              ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedClassFilter =
                                    tempClass;
                                selectedSubjectFilter =
                                    tempSubject;
                                selectedRoleFilter =
                                    tempRole;
                              });

                              Navigator.pop(
                                context,
                              );
                            },
                            style:
                                ElevatedButton
                                    .styleFrom(
                              minimumSize:
                                  const Size(
                                0,
                                50,
                              ),
                            ),
                            child:
                                const Text(
                              "Apply Filter",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // NO CONVERSATIONS
  // ==========================================================

  Widget _buildNoConversations() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_outlined,
              size: 55,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 15),

            const Text(
              "No conversations found",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              "Try changing your search or filters.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // CONVERSATION INFO
  // ==========================================================

  void _showConversationInfo(
    Map<String, dynamic> conversation,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Conversation Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _infoRow(
                  Icons.person_outline,
                  "Parent",
                  conversation["parentName"],
                ),

                _infoRow(
                  Icons.school_outlined,
                  "Student",
                  conversation["studentName"],
                ),

                _infoRow(
                  Icons.class_outlined,
                  "Class",
                  conversation["class"],
                ),

                _infoRow(
                  Icons.menu_book_outlined,
                  "Subject",
                  conversation["subject"],
                ),

                _infoRow(
                  Icons.badge_outlined,
                  "Teacher Role",
                  conversation["role"],
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // INFO ROW
  // ==========================================================

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 21,
            color: Colors.blue.shade700,
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
  // ATTACHMENT OPTIONS
  // ==========================================================

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Attach",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Colors.blue.shade50,
                  child: Icon(
                    Icons.photo_outlined,
                    color: Colors.blue.shade700,
                  ),
                ),
                title: const Text(
                  "Photo",
                ),
                onTap: () {
                  Navigator.pop(context);

                  _showMessage(
                    "Photo attachment will be connected later.",
                  );
                },
              ),

              ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Colors.orange.shade50,
                  child: Icon(
                    Icons.insert_drive_file_outlined,
                    color:
                        Colors.orange.shade700,
                  ),
                ),
                title: const Text(
                  "Document",
                ),
                onTap: () {
                  Navigator.pop(context);

                  _showMessage(
                    "Document attachment will be connected later.",
                  );
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // INITIALS
  // ==========================================================

  String _initials(dynamic name) {
    final value = name.toString().trim();

    if (value.isEmpty) {
      return "?";
    }

    final words = value.split(" ");

    if (words.length == 1) {
      return words.first
          .substring(0, 1)
          .toUpperCase();
    }

    return (
      words.first.substring(0, 1) +
      words.last.substring(0, 1)
    ).toUpperCase();
  }

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }
}