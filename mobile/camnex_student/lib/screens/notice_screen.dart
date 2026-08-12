import 'package:flutter/material.dart';

import '../data/notice_data.dart';

import '../models/notice.dart';

import '../widgets/notice_summary_card.dart';
import '../widgets/notice_search_card.dart';
import '../widgets/notice_tile.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({
    super.key,
  });

  @override
  State<NoticeScreen> createState() =>
      _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  // ============================================================
  // FILTER VARIABLES
  // ============================================================

  DateTime? dateFrom;
  DateTime? dateTo;

  String importantFilter = "All";

  List<NoticeModel> filteredNotices = [];

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    filteredNotices = List.from(noticeList);
  }

  // ============================================================
  // DATE PARSER
  // ============================================================

  DateTime? _parseDate(String value) {
    try {
      final parts = value.split(" ");

      if (parts.length < 3) {
        return null;
      }

      final day = int.parse(parts[0]);

      final monthMap = {
        "Jan": 1,
        "Feb": 2,
        "Mar": 3,
        "Apr": 4,
        "May": 5,
        "Jun": 6,
        "Jul": 7,
        "Aug": 8,
        "Sep": 9,
        "Oct": 10,
        "Nov": 11,
        "Dec": 12,
      };

      final month = monthMap[parts[1]];

      if (month == null) {
        return null;
      }

      final year = int.parse(parts[2]);

      return DateTime(
        year,
        month,
        day,
      );
    } catch (e) {
      return null;
    }
  }

  // ============================================================
  // FILTER NOTICES
  // ============================================================

  void filterNotices() {
    setState(() {
      filteredNotices = noticeList.where((notice) {
        bool match = true;

        // ------------------------------------------------------
        // IMPORTANT FILTER
        // ------------------------------------------------------

        if (importantFilter == "Important") {
          match = notice.isImportant;
        }

        // ------------------------------------------------------
        // DATE FILTER
        // ------------------------------------------------------

        if (match &&
            (dateFrom != null || dateTo != null)) {
          final noticeDate =
              _parseDate(notice.date);

          if (noticeDate == null) {
            return false;
          }

          if (dateFrom != null &&
              noticeDate.isBefore(dateFrom!)) {
            return false;
          }

          if (dateTo != null &&
              noticeDate.isAfter(dateTo!)) {
            return false;
          }
        }

        return match;
      }).toList();
    });
  }

  // ============================================================
  // RESET FILTERS
  // ============================================================

  void resetFilters() {
    setState(() {
      dateFrom = null;
      dateTo = null;
      importantFilter = "All";

      filteredNotices = List.from(noticeList);
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final importantCount =
        noticeList.where(
      (e) => e.isImportant,
    ).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notices",
        ),
      ),

      body: Scrollbar(
        thumbVisibility: true,

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // ==================================================
              // SUMMARY CARDS
              // ==================================================

              Wrap(
                spacing: 20,
                runSpacing: 20,

                children: [

                  NoticeSummaryCard(
                    title: "Total Notices",
                    value:
                        noticeList.length.toString(),
                    icon:
                        Icons.notifications,
                  ),

                  const NoticeSummaryCard(
                    title: "Unread Notices",
                    value: "4",
                    icon:
                        Icons.mark_email_unread,
                  ),

                  const NoticeSummaryCard(
                    title: "This Month",
                    value: "8",
                    icon:
                        Icons.calendar_month,
                  ),

                  NoticeSummaryCard(
                    title: "Important",
                    value:
                        importantCount.toString(),
                    icon: Icons.star,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ==================================================
              // MAIN CONTENT
              // ==================================================

              LayoutBuilder(
                builder: (
                  context,
                  constraints,
                ) {
                  final isWide =
                      constraints.maxWidth >= 900;

                  // =================================================
                  // DESKTOP / WIDE SCREEN
                  // =================================================

                  if (isWide) {
                    return Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        // NOTICE LIST
                        Expanded(
                          flex: 7,
                          child: _buildNoticeList(),
                        ),

                        const SizedBox(width: 20),

                        // SEARCH CARD
                        Expanded(
                          flex: 3,

                          child: NoticeSearchCard(
                            dateFrom: dateFrom,
                            dateTo: dateTo,
                            importantFilter:
                                importantFilter,

                            onDateFromChanged:
                                (date) {
                              dateFrom = date;
                              filterNotices();
                            },

                            onDateToChanged:
                                (date) {
                              dateTo = date;
                              filterNotices();
                            },

                            onImportantChanged:
                                (value) {
                              importantFilter =
                                  value ?? "All";

                              filterNotices();
                            },

                            onReset:
                                resetFilters,

                            onSearch:
                                filterNotices,
                          ),
                        ),
                      ],
                    );
                  }

                  // =================================================
                  // MOBILE / SMALL SCREEN
                  // =================================================

                  return Column(
                    children: [

                      NoticeSearchCard(
                        dateFrom: dateFrom,
                        dateTo: dateTo,
                        importantFilter:
                            importantFilter,

                        onDateFromChanged:
                            (date) {
                          dateFrom = date;
                          filterNotices();
                        },

                        onDateToChanged:
                            (date) {
                          dateTo = date;
                          filterNotices();
                        },

                        onImportantChanged:
                            (value) {
                          importantFilter =
                              value ?? "All";

                          filterNotices();
                        },

                        onReset:
                            resetFilters,

                        onSearch:
                            filterNotices,
                      ),

                      const SizedBox(height: 20),

                      _buildNoticeList(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NOTICE LIST
  // ============================================================

  Widget _buildNoticeList() {
    return Card(
      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),

        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        children: [

          // ------------------------------------------------------
          // HEADER
          // ------------------------------------------------------

          Padding(
            padding:
                const EdgeInsets.all(20),

            child: Row(
              children: [

                const Expanded(
                  child: Text(
                    "All Notices",

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                Text(
                  "${filteredNotices.length} Notices",

                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // ------------------------------------------------------
          // NOTICE LIST
          // ------------------------------------------------------

          if (filteredNotices.isEmpty)
            const Padding(
              padding:
                  EdgeInsets.all(40),

              child: Column(
                children: [

                  Icon(
                    Icons.notifications_none,
                    size: 50,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 15),

                  Text(
                    "No notices found",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Try changing your filters.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredNotices.map(
              (notice) => NoticeTile(
                notice: notice,
              ),
            ),
        ],
      ),
    );
  }
}