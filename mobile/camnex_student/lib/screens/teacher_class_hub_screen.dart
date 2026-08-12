import 'package:flutter/material.dart';

import 'teacher_chat_screen.dart';
import 'teacher_announcements_screen.dart';
import 'teacher_meetings_screen.dart';

class TeacherClassHubScreen extends StatefulWidget {
  const TeacherClassHubScreen({
    super.key,
  });

  @override
  State<TeacherClassHubScreen> createState() =>
      _TeacherClassHubScreenState();
}

class _TeacherClassHubScreenState
    extends State<TeacherClassHubScreen> {

  //==================================================
  // SELECTED TAB
  //==================================================

  int selectedTab = 0;

  //==================================================
  // SELECTED CLASS
  //==================================================

  String selectedClass = "All Classes";

  //==================================================
  // TEACHER'S ASSIGNED CLASSES
  //==================================================

  final List<String> classes = [
    "All Classes",
    "V-A",
    "VI-A",
    "VII-A",
    "VIII-A",
    "IX-A",
  ];

  @override
  Widget build(BuildContext context) {

    //==================================================
    // TAB SCREENS
    //==================================================

    final List<Widget> screens = [
      TeacherChatScreen(
        selectedClass: selectedClass,
      ),

      TeacherAnnouncementsScreen(
        selectedClass: selectedClass,
      ),

      TeacherMeetingsScreen(
        selectedClass: selectedClass,
      ),
    ];

    return Scaffold(

      //================================================
      // APP BAR
      //================================================

      appBar: AppBar(
        title: const Text(
          "Class Hub",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      //================================================
      // BODY
      //================================================

      body: Column(
        children: [

          //============================================
          // CLASS SELECTOR
          //============================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              10,
            ),

            child: Row(
              children: [

                const Icon(
                  Icons.class_outlined,
                  size: 22,
                ),

                const SizedBox(width: 10),

                const Text(
                  "Class",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedClass,

                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10),
                      ),

                      enabledBorder:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),

                    items: classes.map(
                      (String className) {
                        return DropdownMenuItem<String>(
                          value: className,
                          child: Text(
                            className,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ).toList(),

                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        selectedClass = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          //============================================
          // SELECTED CLASS INFORMATION
          //============================================

          Container(
            width: double.infinity,

            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),

            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),

            child: Row(
              children: [

                Icon(
                  Icons.groups_outlined,
                  color: Colors.blue.shade700,
                  size: 21,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    selectedClass == "All Classes"
                        ? "Showing groups from all your assigned classes"
                        : "Showing groups for Class $selectedClass",

                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //============================================
          // CURRENT TAB
          //============================================

          Expanded(
            child: screens[selectedTab],
          ),
        ],
      ),

      //================================================
      // BOTTOM NAVIGATION
      //================================================

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,

        onDestinationSelected: (index) {
          setState(() {
            selectedTab = index;
          });
        },

        destinations: const [

          // CHAT
          NavigationDestination(
            icon: Icon(
              Icons.chat_outlined,
            ),
            selectedIcon: Icon(
              Icons.chat,
            ),
            label: "Chats",
          ),

          // ANNOUNCEMENTS
          NavigationDestination(
            icon: Icon(
              Icons.campaign_outlined,
            ),
            selectedIcon: Icon(
              Icons.campaign,
            ),
            label: "Announcements",
          ),

          // MEETINGS
          NavigationDestination(
            icon: Icon(
              Icons.video_call_outlined,
            ),
            selectedIcon: Icon(
              Icons.video_call,
            ),
            label: "Meetings",
          ),
        ],
      ),
    );
  }
}