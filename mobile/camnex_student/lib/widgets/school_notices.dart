import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/notice_screen.dart';

class ParentNotices extends StatelessWidget {
  final VoidCallback? onViewAll;

  const ParentNotices({
    super.key,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        // White Card
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: AppTheme.border,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.02),

            blurRadius: 8,

            offset:
                const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // ==========================================
          // HEADER
          // ==========================================

          Row(
            children: [
              // Blue Notice Icon
              const Icon(
                Icons.campaign_outlined,

                color:
                    AppTheme.primaryBlue,

                size: 22,
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  'School Notices',

                  style: TextStyle(
                    fontSize: 17,

                    fontWeight:
                        FontWeight.w700,

                    color:
                        AppTheme.textPrimary,
                  ),
                ),
              ),

              // ========================================
              // VIEW ALL
              // ========================================

              TextButton(
                onPressed:
                    onViewAll,

                child:
                    const Text(
                  'View All',

                  style: TextStyle(
                    color:
                        AppTheme.primaryBlue,

                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ==========================================
          // NOTICE 1
          // ==========================================

          _noticeItem(
            title:
                'Parent-Teacher Meeting',

            message:
                'The Parent-Teacher Meeting will be held on 20 June 2026.',

            date:
                '18 Jun 2026',

            icon:
                Icons.groups_outlined,
          ),

          const Divider(
            height: 25,

            color:
                AppTheme.border,
          ),

          // ==========================================
          // NOTICE 2
          // ==========================================

          _noticeItem(
            title:
                'Annual Sports Day',

            message:
                'Students are requested to participate in the Annual Sports Day activities.',

            date:
                '15 Jun 2026',

            icon:
                Icons.sports_soccer_outlined,
          ),

          const Divider(
            height: 25,

            color:
                AppTheme.border,
          ),

          // ==========================================
          // NOTICE 3
          // ==========================================

          _noticeItem(
            title:
                'School Holiday',

            message:
                'The school will remain closed on 25 June 2026.',

            date:
                '12 Jun 2026',

            icon:
                Icons.event_outlined,
          ),
        ],
      ),
    );
  }

  // ============================================
  // NOTICE ITEM
  // ============================================

  Widget _noticeItem({
    required String title,
    required String message,
    required String date,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        // ==========================================
        // NOTICE ICON
        // ==========================================

        Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            // Light Blue Background
            color:
                AppTheme.lightBlue,

            borderRadius:
                BorderRadius.circular(10),
          ),

          child: Icon(
            icon,

            // Primary Blue
            color:
                AppTheme.primaryBlue,

            size: 22,
          ),
        ),

        const SizedBox(width: 12),

        // ==========================================
        // NOTICE CONTENT
        // ==========================================

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // Title + Date
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,

                      style:
                          const TextStyle(
                        fontSize: 14,

                        fontWeight:
                            FontWeight.w700,

                        color:
                            AppTheme.textPrimary,
                      ),
                    ),
                  ),

                  Text(
                    date,

                    style:
                        const TextStyle(
                      fontSize: 11,

                      color:
                          AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Message
              Text(
                message,

                style:
                    const TextStyle(
                  fontSize: 13,

                  height: 1.4,

                  color:
                      AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}