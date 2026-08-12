import 'package:flutter/material.dart';

import '../models/class_group.dart';
import 'group_info_screen.dart';

class GroupChatScreen extends StatefulWidget {
  final ClassGroup group;

  const GroupChatScreen({
    super.key,
    required this.group,
  });

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _messageController =
      TextEditingController();

  final ScrollController _scrollController =
      ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      "sender": "Science Teacher",
      "message": "Science test tomorrow at 10 AM.",
      "time": "10:15 AM",
      "isMe": false,
      "type": "text",
    },
    {
      "sender": "Science Teacher",
      "message":
          "Please revise Chapters 5 and 6 before the test.",
      "time": "10:17 AM",
      "isMe": false,
      "type": "text",
    },
    {
      "sender": "Ayush Sharma",
      "message": "Thank you Ma'am.",
      "time": "10:20 AM",
      "isMe": true,
      "type": "text",
    },
    {
      "sender": "Science Teacher",
      "message": "Homework Assignment.pdf",
      "time": "10:25 AM",
      "isMe": false,
      "type": "file",
    },
    {
      "sender": "Rohan Verma",
      "message": "Ma'am, will the test include numerical questions?",
      "time": "10:32 AM",
      "isMe": false,
      "type": "text",
    },
    {
      "sender": "Science Teacher",
      "message": "Yes. Please prepare all important numerical problems.",
      "time": "10:35 AM",
      "isMe": false,
      "type": "text",
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ============================================================
  // SEND MESSAGE
  // ============================================================

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        "sender": "Ayush Sharma",
        "message": text,
        "time": _currentTime(),
        "isMe": true,
        "type": "text",
      });
    });

    _messageController.clear();

    Future.delayed(
      const Duration(milliseconds: 150),
      _scrollToBottom,
    );
  }

  String _currentTime() {
    final now = TimeOfDay.now();

    final hour = now.hourOfPeriod == 0
        ? 12
        : now.hourOfPeriod;

    final minute =
        now.minute.toString().padLeft(2, "0");

    final period =
        now.period == DayPeriod.am ? "AM" : "PM";

    return "$hour:$minute $period";
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  void _showSearchDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Search Messages"),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Search in this group...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final query =
                    controller.text.trim().toLowerCase();

                Navigator.pop(context);

                if (query.isEmpty) return;

                final results = _messages.where((message) {
                  return message["message"]
                      .toString()
                      .toLowerCase()
                      .contains(query);
                }).toList();

                _showSearchResults(results, query);
              },
              child: const Text("Search"),
            ),
          ],
        );
      },
    );
  }

  void _showSearchResults(
    List<Map<String, dynamic>> results,
    String query,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search Results",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "${results.length} result(s) for \"$query\"",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: results.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 55,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "No messages found",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: results.length,
                            separatorBuilder:
                                (_, _) =>
                                    const Divider(),
                            itemBuilder:
                                (context, index) {
                              final message =
                                  results[index];

                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                    message["sender"]
                                        .toString()[0]
                                        .toUpperCase(),
                                  ),
                                ),
                                title: Text(
                                  message["sender"],
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  message["message"],
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  message["time"],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors
                                        .grey.shade600,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // MEDIA
  // ============================================================

  void _showMedia() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Group Media",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _mediaOption(
                  Icons.photo_library_outlined,
                  "Photos",
                  "View shared photos",
                ),

                _mediaOption(
                  Icons.video_library_outlined,
                  "Videos",
                  "View shared videos",
                ),

                _mediaOption(
                  Icons.insert_drive_file_outlined,
                  "Documents",
                  "View shared documents",
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mediaOption(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(
          icon,
          color: Colors.blue,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  // ============================================================
  // ATTACHMENT
  // ============================================================

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _attachmentOption(
                  Icons.insert_drive_file,
                  "Document",
                ),
                _attachmentOption(
                  Icons.photo,
                  "Gallery",
                ),
                _attachmentOption(
                  Icons.camera_alt,
                  "Camera",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _attachmentOption(
    IconData icon,
    String title,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 90,
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blue.shade50,
              child: Icon(
                icon,
                color: Colors.blue,
                size: 25,
              ),
            ),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // GROUP INFO
  // ============================================================

  void _openGroupInfo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GroupInfoScreen(
          group: widget.group,
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE BUBBLE
  // ============================================================

  Widget _messageBubble(
    Map<String, dynamic> message,
  ) {
    final bool isMe = message["isMe"] == true;
    final bool isFile = message["type"] == "file";

    return Align(
      alignment:
          isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width * .78,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(
          14,
          10,
          10,
          8,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? Colors.blue.shade600
              : Colors.grey.shade100,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(
              isMe ? 16 : 4,
            ),
            bottomRight: Radius.circular(
              isMe ? 4 : 16,
            ),
          ),
          border: isMe
              ? null
              : Border.all(
                  color: Colors.grey.shade200,
                ),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 5),
                child: Text(
                  message["sender"],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),

            if (isFile)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.picture_as_pdf,
                    color: isMe
                        ? Colors.white
                        : Colors.red,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      message["message"],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isMe
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                ],
              )
            else
              Text(
                message["message"],
                style: TextStyle(
                  fontSize: 15,
                  height: 1.35,
                  color: isMe
                      ? Colors.white
                      : Colors.black87,
                ),
              ),

            const SizedBox(height: 5),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message["time"],
                  style: TextStyle(
                    fontSize: 10,
                    color: isMe
                        ? Colors.white70
                        : Colors.grey.shade600,
                  ),
                ),

                if (isMe) ...[
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.done_all,
                    size: 15,
                    color: Colors.white70,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,

        titleSpacing: 0,

        title: InkWell(
          onTap: _openGroupInfo,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 21,
                backgroundColor:
                    widget.group.isClassGroup
                        ? Colors.blue.shade50
                        : Colors.orange.shade50,
                child: Icon(
                  widget.group.isClassGroup
                      ? Icons.groups_rounded
                      : Icons.menu_book_rounded,
                  color:
                      widget.group.isClassGroup
                          ? Colors.blue
                          : Colors.orange,
                  size: 23,
                ),
              ),

              const SizedBox(width: 10),

              Flexible(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.group.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Tap to view group info",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
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
            onPressed: _showSearchDialog,
            icon: const Icon(Icons.search),
          ),

          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "media") {
                _showMedia();
              } else if (value == "info") {
                _openGroupInfo();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: "media",
                child: Row(
                  children: [
                    Icon(Icons.photo_library_outlined),
                    SizedBox(width: 12),
                    Text("Media"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "info",
                child: Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 12),
                    Text("Group Info"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          // ======================================================
          // OFFICIAL NOTICE
          // ======================================================

          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(
              12,
              12,
              12,
              6,
            ),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.blue.shade100,
              ),
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade700,
                  size: 20,
                ),

                const SizedBox(width: 10),

                const Expanded(
                  child: Text(
                    "Official CamNex academic communication. "
                    "Messages form part of the class communication history.",
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======================================================
          // DATE
          // ======================================================

          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xffE8EEF7),
                  borderRadius:
                      BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  child: Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ======================================================
          // MESSAGES
          // ======================================================

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(
                14,
                5,
                14,
                12,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messageBubble(
                  _messages[index],
                );
              },
            ),
          ),

          // ======================================================
          // MESSAGE COMPOSER
          // ======================================================

          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                10,
                8,
                10,
                10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withValues(alpha: .06),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: "Attach",
                    onPressed:
                        _showAttachmentOptions,
                    icon: const Icon(
                      Icons.attach_file,
                    ),
                  ),

                  Expanded(
                    child: TextField(
                      controller:
                          _messageController,
                      minLines: 1,
                      maxLines: 4,
                      textCapitalization:
                          TextCapitalization.sentences,
                      onSubmitted: (_) =>
                          _sendMessage(),
                      decoration: InputDecoration(
                        hintText:
                            "Type a message...",
                        filled: true,
                        fillColor:
                            Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            24,
                          ),
                          borderSide:
                              BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Material(
                    color: Colors.blue,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder:
                          const CircleBorder(),
                      onTap: _sendMessage,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}