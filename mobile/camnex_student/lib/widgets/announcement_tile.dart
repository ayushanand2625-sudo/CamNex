import 'package:flutter/material.dart';

import '../models/class_announcement.dart';

class AnnouncementTile extends StatelessWidget {
  final ClassAnnouncement announcement;

  const AnnouncementTile({
    super.key,
    required this.announcement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          _showAnnouncementDetails(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // TOP ROW
              // =====================================================

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Announcement Icon
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: announcement.isImportant
                          ? Colors.red.shade50
                          : Colors.blue.shade50,
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Icon(
                      announcement.isImportant
                          ? Icons.priority_high_rounded
                          : Icons.campaign_rounded,
                      color: announcement.isImportant
                          ? Colors.red
                          : Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement.title,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 13,
                              color:
                                  Colors.grey.shade600,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              announcement.date,
                              style: TextStyle(
                                color:
                                    Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Important Badge
                  if (announcement.isImportant)
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius:
                            BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.red.shade100,
                        ),
                      ),
                      child: const Text(
                        "IMPORTANT",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // =====================================================
              // DESCRIPTION
              // =====================================================

              Text(
                announcement.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  height: 1.5,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 18),

              const Divider(),

              const SizedBox(height: 8),

              // =====================================================
              // POSTED BY
              // =====================================================

              Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor:
                        Colors.blue.shade50,
                    child: const Icon(
                      Icons.person_outline,
                      size: 19,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 9),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Posted by",
                          style: TextStyle(
                            color:
                                Colors.grey.shade600,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          announcement.postedBy,
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // View Details
                  Container(
                    padding:
                        const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Colors.grey.shade700,
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

  // =============================================================
  // ANNOUNCEMENT DETAILS
  // =============================================================

  void _showAnnouncementDetails(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor:
                              announcement.isImportant
                                  ? Colors.red.shade50
                                  : Colors.blue.shade50,
                          child: Icon(
                            announcement.isImportant
                                ? Icons.priority_high
                                : Icons.campaign,
                            color:
                                announcement.isImportant
                                    ? Colors.red
                                    : Colors.blue,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                announcement.title,
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                announcement.date,
                                style: TextStyle(
                                  color: Colors
                                      .grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (announcement.isImportant)
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: const Text(
                              "IMPORTANT",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 9,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const Divider(
                      height: 35,
                    ),

                    // Posted By
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Posted by: ",
                          style: TextStyle(
                            color:
                                Colors.grey.shade600,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            announcement.postedBy,
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Announcement
                    const Text(
                      "Announcement",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: Text(
                        announcement.description,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.7,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Close
                    Align(
                      alignment:
                          Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                        ),
                        label: const Text("Close"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}