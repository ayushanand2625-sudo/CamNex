import 'package:flutter/material.dart';

import '../data/class_group_data.dart';
import '../widgets/class_group_tile.dart';
import 'group_chat_screen.dart';

class ClassChatScreen extends StatefulWidget {
  const ClassChatScreen({super.key});

  @override
  State<ClassChatScreen> createState() => _ClassChatScreenState();
}

class _ClassChatScreenState extends State<ClassChatScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List get filteredGroups {
    if (_searchQuery.trim().isEmpty) {
      return classGroups;
    }

    final query = _searchQuery.toLowerCase().trim();

    return classGroups.where((group) {
      final groupTitle = group.title.toString().toLowerCase();
      final description =
          group.description.toString().toLowerCase();

      return groupTitle.contains(query) ||
          description.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final groups = filteredGroups;

    return Column(
      children: [
        // ------------------------------------------------
        // SEARCH BAR
        // ------------------------------------------------
        Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            10,
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Search class groups...",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();

                        setState(() {
                          _searchQuery = "";
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // ------------------------------------------------
        // GROUP COUNT
        // ------------------------------------------------
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 8,
          ),
          child: Row(
            children: [
              Text(
                "Class Groups",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const Spacer(),
              Text(
                "${groups.length} groups",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // ------------------------------------------------
        // GROUP LIST
        // ------------------------------------------------
        Expanded(
          child: groups.isEmpty
              ? _emptyState()
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    20,
                  ),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];

                    return ClassGroupTile(
                      group: group,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GroupChatScreen(
                              group: group,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 70,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              "No groups found",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try searching for another class or subject.",
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
}