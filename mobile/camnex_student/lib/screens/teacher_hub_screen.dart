import 'package:flutter/material.dart';

import 'teacher_hub_chats_screen.dart';
import 'teacher_hub_announcements_screen.dart';
import 'teacher_hub_meetings_screen.dart';

class TeacherHubScreen extends StatefulWidget {
  const TeacherHubScreen({super.key});

  @override
  State<TeacherHubScreen> createState() =>
      _TeacherHubScreenState();
}

class _TeacherHubScreenState
    extends State<TeacherHubScreen> {
  int selectedIndex = 0;

  final List<String> titles = [
    "Chats",
    "Announcements",
    "Meetings",
  ];

  final List<IconData> icons = [
    Icons.chat_bubble_outline,
    Icons.campaign_outlined,
    Icons.calendar_month_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Teacher Hub",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // ==================================================
          // TOP TABS
          // ==================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              16,
              12,
              16,
              12,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .scaffoldBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile =
                    constraints.maxWidth < 600;

                return Row(
                  children: List.generate(
                    titles.length,
                    (index) {
                      final isSelected =
                          selectedIndex == index;

                      return Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.only(
                            right: index ==
                                    titles.length - 1
                                ? 0
                                : 8,
                          ),
                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                            onTap: () {
                              setState(() {
                                selectedIndex =
                                    index;
                              });
                            },
                            child: AnimatedContainer(
                              duration:
                                  const Duration(
                                milliseconds: 200,
                              ),
                              padding:
                                  EdgeInsets.symmetric(
                                vertical:
                                    isMobile
                                        ? 12
                                        : 14,
                                horizontal:
                                    isMobile
                                        ? 6
                                        : 12,
                              ),
                              decoration:
                                  BoxDecoration(
                                color: isSelected
                                    ? const Color(
                                        0xFFFFF1E8,
                                      )
                                    : Colors
                                        .transparent,
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  14,
                                ),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(
                                          0xFFF97316,
                                        )
                                      : Colors
                                          .grey
                                          .shade300,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: [
                                  Icon(
                                    icons[index],
                                    size: isMobile
                                        ? 19
                                        : 21,
                                    color: isSelected
                                        ? const Color(
                                            0xFFF97316,
                                          )
                                        : Colors
                                            .grey
                                            .shade700,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Flexible(
                                    child: Text(
                                      titles[index],
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                      style: TextStyle(
                                        fontSize:
                                            isMobile
                                                ? 13
                                                : 14,
                                        fontWeight:
                                            isSelected
                                                ? FontWeight
                                                    .w700
                                                : FontWeight
                                                    .w500,
                                        color: isSelected
                                            ? const Color(
                                                0xFFF97316,
                                              )
                                            : Colors
                                                .grey
                                                .shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // ==================================================
          // SELECTED SECTION
          // ==================================================

          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: const [
                TeacherHubChatsScreen(),
                TeacherHubAnnouncementsScreen(),
                TeacherHubMeetingsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}