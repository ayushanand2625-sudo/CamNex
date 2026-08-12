import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ParentTeacherRemarks extends StatelessWidget {
  final VoidCallback? onViewAll;

  const ParentTeacherRemarks({
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
              // Blue Header Icon
              const Icon(
                Icons.chat_bubble_outline,

                color:
                    AppTheme.primaryBlue,

                size: 22,
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Text(
                  'Teacher Remarks',

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
          // FIRST REMARK
          // ==========================================

          _remark(
            teacher:
                'Mr. Rajesh Kumar',

            subject:
                'Mathematics',

            message:
                'Ayush is doing well in Mathematics. He should practice more algebra problems.',

            date:
                'Today',
          ),

          const Divider(
            height: 25,

            color:
                AppTheme.border,
          ),

          // ==========================================
          // SECOND REMARK
          // ==========================================

          _remark(
            teacher:
                'Mrs. Priya Sharma',

            subject:
                'Science',

            message:
                'Excellent performance in the recent Science examination.',

            date:
                'Yesterday',
          ),
        ],
      ),
    );
  }

  // ============================================
  // REMARK ITEM
  // ============================================

  Widget _remark({
    required String teacher,
    required String subject,
    required String message,
    required String date,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        // ==========================================
        // TEACHER AVATAR
        // ==========================================

        const CircleAvatar(
          radius: 22,

          // Light Blue
          backgroundColor:
              AppTheme.lightBlue,

          child: Icon(
            Icons.person_outline,

            // Primary Blue
            color:
                AppTheme.primaryBlue,
          ),
        ),

        const SizedBox(width: 12),

        // ==========================================
        // REMARK CONTENT
        // ==========================================

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // Teacher + Date
              Row(
                children: [
                  Expanded(
                    child: Text(
                      teacher,

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

              const SizedBox(height: 3),

              // ========================================
              // SUBJECT
              // ========================================

              Text(
                subject,

                style:
                    const TextStyle(
                  fontSize: 12,

                  // Blue Subject
                  color:
                      AppTheme.primaryBlue,

                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              // ========================================
              // MESSAGE
              // ========================================

              Text(
                message,

                style:
                    const TextStyle(
                  fontSize: 13,

                  height: 1.5,

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