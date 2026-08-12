import 'package:flutter/material.dart';

import '../models/class_group.dart';
import 'create_group_screen.dart';
import 'group_chat_screen.dart';


class TeacherChatScreen extends StatefulWidget {
  final String selectedClass;

  const TeacherChatScreen({
    super.key,
    required this.selectedClass,
  });

  @override
  State<TeacherChatScreen> createState() =>
      _TeacherChatScreenState();
}

class _TeacherChatScreenState
    extends State<TeacherChatScreen> {

  String search = "";

  //==================================================
  // GROUP DATA
  //==================================================

  final List<Map<String, dynamic>> groups = [

    //================================================
    // MAIN CLASS GROUPS
    //================================================

    {
      "name": "Class V-A",
      "class": "V-A",
      "type": "Main",
      "description":
          "Official group for Class V-A",
      "lastMessage": "Homework uploaded",
      "time": "10:30 AM",
      "pinned": true,
    },

    {
      "name": "Class VI-A",
      "class": "VI-A",
      "type": "Main",
      "description":
          "Official group for Class VI-A",
      "lastMessage": "Tomorrow is PTM",
      "time": "Yesterday",
      "pinned": true,
    },

    {
      "name": "Class VII-A",
      "class": "VII-A",
      "type": "Main",
      "description":
          "Official group for Class VII-A",
      "lastMessage": "Class activity tomorrow",
      "time": "Yesterday",
      "pinned": true,
    },

    {
      "name": "Class VIII-A",
      "class": "VIII-A",
      "type": "Main",
      "description":
          "Official group for Class VIII-A",
      "lastMessage": "Homework uploaded",
      "time": "9:45 AM",
      "pinned": true,
    },

    {
      "name": "Class IX-A",
      "class": "IX-A",
      "type": "Main",
      "description":
          "Official group for Class IX-A",
      "lastMessage": "Unit test schedule",
      "time": "Yesterday",
      "pinned": true,
    },

    //================================================
    // SUBJECT GROUPS
    //================================================

    {
      "name": "Mathematics • V-A",
      "class": "V-A",
      "type": "Subject",
      "description":
          "Mathematics subject group for V-A",
      "lastMessage": "Chapter 4 completed",
      "time": "9:20 AM",
      "pinned": false,
    },

    {
      "name": "Mathematics • VI-A",
      "class": "VI-A",
      "type": "Subject",
      "description":
          "Mathematics subject group for VI-A",
      "lastMessage": "Practice Sheet",
      "time": "8:15 AM",
      "pinned": false,
    },

    {
      "name": "Science • VIII-A",
      "class": "VIII-A",
      "type": "Subject",
      "description":
          "Science subject group for VIII-A",
      "lastMessage": "Lab activity tomorrow",
      "time": "8:30 AM",
      "pinned": false,
    },

    {
      "name": "Mathematics • IX-A",
      "class": "IX-A",
      "type": "Subject",
      "description":
          "Mathematics subject group for IX-A",
      "lastMessage": "Chapter 6 discussion",
      "time": "Yesterday",
      "pinned": false,
    },

    //================================================
    // CUSTOM GROUP
    //================================================

    {
      "name": "Science Exhibition",
      "class": "Custom",
      "type": "Custom",
      "description":
          "Custom group created by teacher",
      "lastMessage": "Meeting at 4 PM",
      "time": "Today",
      "pinned": false,
    },
  ];

  @override
  Widget build(BuildContext context) {

    //================================================
    // FILTER GROUPS
    //================================================

    final filtered = groups.where((group) {

      final String groupClass =
          group["class"] as String;

      final bool classMatch =
          widget.selectedClass == "All Classes" ||
          groupClass == widget.selectedClass;

      final String groupName =
          group["name"] as String;

      final bool searchMatch =
          groupName
              .toLowerCase()
              .contains(search.toLowerCase());

      return classMatch && searchMatch;

    }).toList();

    //================================================
    // PINNED
    //================================================

    final pinned = filtered
        .where(
          (group) => group["pinned"] == true,
        )
        .toList();

    //================================================
    // RECENT
    //================================================

    final recent = filtered
        .where(
          (group) => group["pinned"] != true,
        )
        .toList();

    return Scaffold(

      //================================================
      // CREATE GROUP
      //================================================

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const CreateGroupScreen(),
            ),
          );
        },

        icon: const Icon(
          Icons.group_add,
        ),

        label: const Text(
          "New Group",
        ),
      ),

      //================================================
      // BODY
      //================================================

      body: Column(
        children: [

          //============================================
          // SEARCH BAR
          //============================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              8,
            ),

            child: TextField(

              decoration: InputDecoration(

                hintText:
                    "Search groups...",

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                filled: true,

                fillColor:
                    Colors.grey.shade50,

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),

                  borderSide:
                      BorderSide.none,
                ),

                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),

                  borderSide:
                      BorderSide(
                    color:
                        Colors.grey.shade200,
                  ),
                ),
              ),

              onChanged: (value) {

                setState(() {
                  search = value;
                });
              },
            ),
          ),

          //============================================
          // CURRENT CLASS
          //============================================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),

            child: Align(
              alignment: Alignment.centerLeft,

              child: Text(
                widget.selectedClass ==
                        "All Classes"
                    ? "All Class Groups"
                    : "Class ${widget.selectedClass} Groups",

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          //============================================
          // GROUP LIST
          //============================================

          Expanded(
            child: filtered.isEmpty
                ? _emptyState()
                : ListView(
                    padding:
                        const EdgeInsets.only(
                      bottom: 90,
                    ),

                    children: [

                      //==============================
                      // PINNED
                      //==============================

                      if (pinned.isNotEmpty) ...[

                        const Padding(
                          padding:
                              EdgeInsets.fromLTRB(
                            16,
                            10,
                            16,
                            8,
                          ),

                          child: Text(
                            "Pinned",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),

                        ...pinned.map(
                          _groupTile,
                        ),
                      ],

                      //==============================
                      // RECENT
                      //==============================

                      if (recent.isNotEmpty) ...[

                        const Padding(
                          padding:
                              EdgeInsets.fromLTRB(
                            16,
                            18,
                            16,
                            8,
                          ),

                          child: Text(
                            "Recent",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),

                        ...recent.map(
                          _groupTile,
                        ),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  //==================================================
  // GROUP TILE
  //==================================================

  Widget _groupTile(
    Map<String, dynamic> group,
  ) {

    IconData icon;

    switch (group["type"]) {

      case "Main":
        icon = Icons.groups_outlined;
        break;

      case "Subject":
        icon = Icons.menu_book_outlined;
        break;

      default:
        icon = Icons.group_work_outlined;
    }

    return ListTile(

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),

      leading: CircleAvatar(

        radius: 25,

        backgroundColor:
            Colors.blue.shade50,

        child: Icon(
          icon,
          color: Colors.blue.shade700,
        ),
      ),

      title: Row(
        children: [

          Expanded(
            child: Text(
              group["name"],
              style: const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),

          if (group["pinned"] == true)
            const Icon(
              Icons.push_pin,
              size: 15,
              color: Colors.grey,
            ),
        ],
      ),

      subtitle: Padding(
        padding:
            const EdgeInsets.only(top: 4),

        child: Text(
          group["lastMessage"],
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis,
        ),
      ),

      trailing: Text(
        group["time"],
        style: TextStyle(
          fontSize: 11,
          color:
              Colors.grey.shade600,
        ),
      ),

      //================================================
      // OPEN GROUP CHAT
      //================================================

      onTap: () {

        final classGroup = ClassGroup(

          title: group["name"],

          description:
              group["description"],

          lastMessage:
              group["lastMessage"],

          time:
              group["time"],

          isClassGroup:
              group["type"] == "Main",
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                GroupChatScreen(
              group: classGroup,
            ),
          ),
        );
      },
    );
  }

  //==================================================
  // EMPTY STATE
  //==================================================

  Widget _emptyState() {

    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(
            Icons.search_off,
            size: 55,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 12),

          const Text(
            "No groups found",
            style: TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "Try another class or search term.",
            style: TextStyle(
              color:
                  Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}