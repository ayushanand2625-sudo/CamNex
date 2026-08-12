import 'package:flutter/material.dart';

import '../models/class_group.dart';

class ClassGroupTile extends StatelessWidget {
  final ClassGroup group;
  final VoidCallback? onTap;

  const ClassGroupTile({
    super.key,
    required this.group,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isClassGroup = group.isClassGroup;

    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --------------------------------------------------
              // GROUP AVATAR
              // --------------------------------------------------
              CircleAvatar(
                radius: 29,
                backgroundColor: isClassGroup
                    ? Colors.blue.shade50
                    : Colors.orange.shade50,
                child: Icon(
                  isClassGroup
                      ? Icons.groups_rounded
                      : Icons.menu_book_rounded,
                  size: 28,
                  color: isClassGroup
                      ? Colors.blue.shade700
                      : Colors.orange.shade700,
                ),
              ),

              const SizedBox(width: 14),

              // --------------------------------------------------
              // GROUP INFORMATION
              // --------------------------------------------------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Group title
                    Text(
                      group.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Description
                    Text(
                      group.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Last message
                    Row(
                      children: [
                        Icon(
                          Icons.done_all_rounded,
                          size: 15,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            group.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // --------------------------------------------------
              // TIME + CHAT ICON
              // --------------------------------------------------
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    group.time,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: isClassGroup
                          ? Colors.blue.shade50
                          : Colors.orange.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 16,
                      color: isClassGroup
                          ? Colors.blue.shade700
                          : Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}