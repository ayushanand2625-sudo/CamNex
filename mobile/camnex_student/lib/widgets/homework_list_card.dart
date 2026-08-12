import 'package:flutter/material.dart';

import '../models/homework.dart';
import 'homework_tile.dart';

class HomeworkListCard extends StatelessWidget {
  final List<Homework> homeworkList;
  final bool isStudent;

  const HomeworkListCard({
    super.key,
    required this.homeworkList,
    required this.isStudent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          MediaQuery.sizeOf(context).width < 600 ? 16 : 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 420;

                if (isSmall) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderTitle(),

                      const SizedBox(height: 8),

                      _buildHomeworkCount(),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: _buildHeaderTitle(),
                    ),

                    const SizedBox(width: 12),

                    _buildHomeworkCount(),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            // =====================================================
            // HOMEWORK LIST
            // =====================================================

            if (homeworkList.isEmpty)
              _buildEmptyState()
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeworkList.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (context, index) {
                  return HomeworkTile(
                    homework: homeworkList[index],
                    isStudent: isStudent,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // HEADER TITLE
  // =============================================================

  Widget _buildHeaderTitle() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.menu_book_outlined,
            color: Colors.blue.shade700,
            size: 22,
          ),
        ),

        const SizedBox(width: 12),

        const Flexible(
          child: Text(
            "Homework List",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: Color(0xff172033),
            ),
          ),
        ),
      ],
    );
  }

  // =============================================================
  // HOMEWORK COUNT
  // =============================================================

  Widget _buildHomeworkCount() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "${homeworkList.length} Homework",
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // =============================================================
  // EMPTY STATE
  // =============================================================

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 45,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 34,
              color: Colors.blue.shade600,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "No homework found",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Color(0xff172033),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Try changing your search filters.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}