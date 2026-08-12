import 'package:flutter/material.dart';

import '../models/class_member.dart';

class MemberTile extends StatelessWidget {
  final ClassMember member;

  const MemberTile({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color iconColor;
    Color backgroundColor;

    switch (member.role) {
      case "Class Teacher":
        icon = Icons.school_rounded;
        iconColor = Colors.blue;
        backgroundColor = Colors.blue.shade50;
        break;

      case "Science Teacher":
      case "Mathematics Teacher":
      case "English Teacher":
      case "Social Science Teacher":
      case "Computer Science Teacher":
        icon = Icons.menu_book_rounded;
        iconColor = Colors.green;
        backgroundColor = Colors.green.shade50;
        break;

      case "Student":
        icon = Icons.person_rounded;
        iconColor = Colors.orange;
        backgroundColor = Colors.orange.shade50;
        break;

      default:
        icon = Icons.groups_rounded;
        iconColor = Colors.grey.shade700;
        backgroundColor = Colors.grey.shade100;
    }

    final bool isTeacher = member.role != "Student";

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () {
          _showMemberInfo(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          child: Row(
            children: [
              // =====================================================
              // PROFILE AVATAR
              // =====================================================

              CircleAvatar(
                radius: 28,
                backgroundColor: backgroundColor,
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 27,
                ),
              ),

              const SizedBox(width: 14),

              // =====================================================
              // MEMBER INFORMATION
              // =====================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        Icon(
                          isTeacher
                              ? Icons.school_outlined
                              : Icons.person_outline,
                          size: 15,
                          color: iconColor,
                        ),

                        const SizedBox(width: 5),

                        Expanded(
                          child: Text(
                            member.role,
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            style: TextStyle(
                              color: iconColor,
                              fontWeight:
                                  FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      member.designation,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // =====================================================
              // ROLE + ARROW
              // =====================================================

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      isTeacher ? "Teacher" : "Student",
                      style: TextStyle(
                        color: iconColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // MEMBER DETAILS
  // ===============================================================

  void _showMemberInfo(BuildContext context) {
    IconData icon;
    Color color;

    if (member.role == "Student") {
      icon = Icons.person_rounded;
      color = Colors.orange;
    } else if (member.role == "Class Teacher") {
      icon = Icons.school_rounded;
      color = Colors.blue;
    } else {
      icon = Icons.menu_book_rounded;
      color = Colors.green;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar

                  CircleAvatar(
                    radius: 38,
                    backgroundColor:
                        color.withValues(alpha: 0.1),
                    child: Icon(
                      icon,
                      size: 38,
                      color: color,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Name

                  Text(
                    member.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  // Role

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      member.role,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Designation

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.badge_outlined,
                          color: Colors.grey.shade700,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Designation",
                                style: TextStyle(
                                  color:
                                      Colors.grey.shade600,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                member.designation,
                                style: const TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Close

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Close"),
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
}