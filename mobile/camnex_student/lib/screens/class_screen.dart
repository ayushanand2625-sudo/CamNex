import 'package:flutter/material.dart';

import 'class_announcements_screen.dart';
import 'class_chat_screen.dart';
import 'class_meetings_screen.dart';
import 'class_members_screen.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ClassChatScreen(),
    ClassAnnouncementsScreen(),
    ClassMeetingsScreen(),
    ClassMembersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Class",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // Selected class section
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // Bottom navigation
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.chat_bubble_outline,
            ),
            selectedIcon: Icon(
              Icons.chat_bubble,
            ),
            label: "Chats",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.campaign_outlined,
            ),
            selectedIcon: Icon(
              Icons.campaign,
            ),
            label: "Announcements",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.video_call_outlined,
            ),
            selectedIcon: Icon(
              Icons.video_call,
            ),
            label: "Meetings",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.groups_outlined,
            ),
            selectedIcon: Icon(
              Icons.groups,
            ),
            label: "Members",
          ),
        ],
      ),
    );
  }
}