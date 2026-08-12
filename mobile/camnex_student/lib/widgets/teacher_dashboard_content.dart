import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TeacherDashboardContent extends StatelessWidget {
  const TeacherDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        final bool isMobile = width < 700;
        final bool isTablet = width >= 700 && width < 1100;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 18 : 32,
            vertical: isMobile ? 20 : 28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // WELCOME SECTION
              // ============================================================

              _buildWelcomeSection(
                context,
                isMobile,
              ),

              const SizedBox(height: 28),

              // ============================================================
              // STATISTICS
              // ============================================================

              _buildSectionHeader(
                title: "Overview",
                subtitle: "Your teaching activity at a glance",
              ),

              const SizedBox(height: 16),

              _buildStatistics(
                width: width,
                isMobile: isMobile,
                isTablet: isTablet,
              ),

              const SizedBox(height: 30),

              // ============================================================
              // MAIN DASHBOARD GRID
              // ============================================================

              if (isMobile)
                Column(
                  children: [
                    _buildTodaySchedule(),
                    const SizedBox(height: 20),
                    _buildClassPerformance(),
                    const SizedBox(height: 20),
                    _buildCommunicationOverview(),
                    const SizedBox(height: 20),
                    _buildRecentActivity(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          _buildTodaySchedule(),
                          const SizedBox(height: 20),
                          _buildClassPerformance(),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _buildCommunicationOverview(),
                          const SizedBox(height: 20),
                          _buildRecentActivity(),
                        ],
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              // ============================================================
              // QUICK ACTIONS
              // ============================================================

              _buildSectionHeader(
                title: "Quick Actions",
                subtitle: "Frequently used teacher tools",
              ),

              const SizedBox(height: 16),

              _buildQuickActions(
                isMobile: isMobile,
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================================
  // WELCOME SECTION
  // ==========================================================================

  Widget _buildWelcomeSection(
    BuildContext context,
    bool isMobile,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? 20 : 26,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.lightBlue,
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _welcomeIcon(),
                const SizedBox(height: 16),
                _welcomeText(),
              ],
            )
          : Row(
              children: [
                _welcomeIcon(),
                const SizedBox(width: 18),
                Expanded(
                  child: _welcomeText(),
                ),
                _buildDateCard(),
              ],
            ),
    );
  }

  Widget _welcomeIcon() {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(
        Icons.waving_hand_outlined,
        color: AppTheme.primaryOrange,
        size: 30,
      ),
    );
  }

  Widget _welcomeText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome back, Rahul 👋",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
          ),
        ),
        SizedBox(height: 7),
        Text(
          "Class Teacher • Grade VIII-A",
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Here's what's happening in your classroom today.",
          style: TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDateCard() {
    final now = DateTime.now();

    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            size: 20,
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(width: 10),
          Text(
            "${months[now.month - 1]} ${now.day}, ${now.year}",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // SECTION HEADER
  // ==========================================================================

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================================
  // STATISTICS
  // ==========================================================================

  Widget _buildStatistics({
    required double width,
    required bool isMobile,
    required bool isTablet,
  }) {
    final cards = [
      _StatData(
        title: "My Students",
        value: "32",
        subtitle: "Grade VIII-A",
        icon: Icons.groups_outlined,
        color: AppTheme.primaryBlue,
      ),
      _StatData(
        title: "Attendance",
        value: "94.2%",
        subtitle: "This month",
        icon: Icons.fact_check_outlined,
        color: Colors.green,
      ),
      _StatData(
        title: "Homework",
        value: "8",
        subtitle: "Pending review",
        icon: Icons.menu_book_outlined,
        color: AppTheme.primaryOrange,
      ),
      _StatData(
        title: "Messages",
        value: "12",
        subtitle: "Unread messages",
        icon: Icons.forum_outlined,
        color: Colors.deepPurple,
      ),
    ];

    if (isMobile) {
      return Column(
        children: cards
            .map(
              (card) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildStatCard(card),
              ),
            )
            .toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 2 : 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isTablet ? 2.5 : 1.65,
      ),
      itemBuilder: (context, index) {
        return _buildStatCard(cards[index]);
      },
    );
  }

  Widget _buildStatCard(_StatData data) {
    return _HoverCard(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                data.icon,
                color: data.color,
                size: 25,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: data.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================================
  // TODAY'S SCHEDULE
  // ==========================================================================

  Widget _buildTodaySchedule() {
    final classes = [
      _ScheduleData(
        time: "08:30 AM",
        subject: "Mathematics",
        className: "VIII-A",
        room: "Room 204",
        icon: Icons.calculate_outlined,
        active: true,
      ),
      _ScheduleData(
        time: "10:15 AM",
        subject: "Mathematics",
        className: "VIII-B",
        room: "Room 201",
        icon: Icons.calculate_outlined,
      ),
      _ScheduleData(
        time: "12:00 PM",
        subject: "Class Activity",
        className: "VIII-A",
        room: "Activity Hall",
        icon: Icons.groups_outlined,
      ),
      _ScheduleData(
        time: "02:00 PM",
        subject: "Mathematics",
        className: "VII-A",
        room: "Room 105",
        icon: Icons.calculate_outlined,
      ),
    ];

    return _DashboardCard(
      title: "Today's Schedule",
      subtitle: "Your classes and activities",
      icon: Icons.schedule_outlined,
      trailing: "View all",
      child: Column(
        children: classes.map((item) {
          return _buildScheduleItem(item);
        }).toList(),
      ),
    );
  }

  Widget _buildScheduleItem(_ScheduleData data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: data.active
            ? AppTheme.lightBlue
            : const Color(0xfffafbfc),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: data.active
              ? AppTheme.primaryBlue.withOpacity(0.15)
              : AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              data.time,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: data.active
                    ? AppTheme.primaryBlue
                    : AppTheme.textSecondary,
              ),
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              data.icon,
              size: 20,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.subject,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "${data.className} • ${data.room}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (data.active)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "NOW",
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: Colors.green,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ==========================================================================
  // CLASS PERFORMANCE
  // ==========================================================================

  Widget _buildClassPerformance() {
    return _DashboardCard(
      title: "Class Performance",
      subtitle: "Grade VIII-A overview",
      icon: Icons.analytics_outlined,
      trailing: "Details",
      child: Column(
        children: [
          _buildProgressRow(
            title: "Attendance",
            value: "94%",
            progress: 0.94,
            color: Colors.green,
          ),
          const SizedBox(height: 18),
          _buildProgressRow(
            title: "Homework Completion",
            value: "87%",
            progress: 0.87,
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(height: 18),
          _buildProgressRow(
            title: "Average Performance",
            value: "82%",
            progress: 0.82,
            color: AppTheme.primaryOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow({
    required String title,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor: const Color(0xffedf0f4),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  // ==========================================================================
  // COMMUNICATION
  // ==========================================================================

  Widget _buildCommunicationOverview() {
    return _DashboardCard(
      title: "Communication",
      subtitle: "Stay connected",
      icon: Icons.forum_outlined,
      child: Column(
        children: [
          _buildCommunicationItem(
            icon: Icons.hub_outlined,
            title: "Teacher Hub",
            subtitle: "3 new conversations",
            count: "3",
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(height: 10),
          _buildCommunicationItem(
            icon: Icons.chat_bubble_outline,
            title: "Parent Messages",
            subtitle: "5 unread messages",
            count: "5",
            color: AppTheme.primaryOrange,
          ),
          const SizedBox(height: 10),
          _buildCommunicationItem(
            icon: Icons.campaign_outlined,
            title: "Class Notices",
            subtitle: "2 recent notices",
            count: "2",
            color: Colors.deepPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfffafbfc),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 25,
            height: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Text(
              count,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // RECENT ACTIVITY
  // ==========================================================================

  Widget _buildRecentActivity() {
    return _DashboardCard(
      title: "Recent Activity",
      subtitle: "Latest updates",
      icon: Icons.history_outlined,
      child: Column(
        children: [
          _buildActivityItem(
            icon: Icons.assignment_turned_in_outlined,
            title: "Homework reviewed",
            subtitle: "Class VIII-A",
            time: "10 min ago",
            color: Colors.green,
          ),
          _buildActivityItem(
            icon: Icons.campaign_outlined,
            title: "Notice published",
            subtitle: "Parent-Teacher Meeting",
            time: "1 hr ago",
            color: AppTheme.primaryOrange,
          ),
          _buildActivityItem(
            icon: Icons.person_add_alt_1_outlined,
            title: "New student added",
            subtitle: "Grade VIII-A",
            time: "3 hrs ago",
            color: AppTheme.primaryBlue,
          ),
          _buildActivityItem(
            icon: Icons.message_outlined,
            title: "New parent message",
            subtitle: "Mrs. Priya Sharma",
            time: "5 hrs ago",
            color: Colors.deepPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 17,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 9,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // QUICK ACTIONS
  // ==========================================================================

  Widget _buildQuickActions({
    required bool isMobile,
  }) {
    final actions = [
      _ActionData(
        title: "Take Attendance",
        subtitle: "Mark today's attendance",
        icon: Icons.fact_check_outlined,
        color: AppTheme.primaryBlue,
      ),
      _ActionData(
        title: "Add Homework",
        subtitle: "Create a new assignment",
        icon: Icons.add_task_outlined,
        color: AppTheme.primaryOrange,
      ),
      _ActionData(
        title: "Send Notice",
        subtitle: "Notify your class",
        icon: Icons.campaign_outlined,
        color: Colors.deepPurple,
      ),
      _ActionData(
        title: "Open Teacher Hub",
        subtitle: "Chat with teachers",
        icon: Icons.hub_outlined,
        color: Colors.green,
      ),
    ];

    if (isMobile) {
      return Column(
        children: actions.map((action) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildActionCard(action),
          );
        }).toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: actions.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: actions.length > 3 ? 4 : actions.length,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, index) {
        return _buildActionCard(actions[index]);
      },
    );
  }

  Widget _buildActionCard(_ActionData action) {
    return _HoverCard(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppTheme.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: action.color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                action.icon,
                size: 21,
                color: action.color,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    action.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    action.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13,
              color: action.color,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// DASHBOARD CARD
// ============================================================================

class _DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? trailing;
  final Widget child;

  const _DashboardCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.lightBlue,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: AppTheme.primaryBlue,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryBlue,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 18),

          child,
        ],
      ),
    );
  }
}

// ============================================================================
// HOVER CARD
// ============================================================================

class _HoverCard extends StatefulWidget {
  final Widget child;

  const _HoverCard({
    required this.child,
  });

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovering = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.translationValues(
          0,
          isHovering ? -2 : 0,
          0,
        ),
        child: widget.child,
      ),
    );
  }
}

// ============================================================================
// DATA CLASSES
// ============================================================================

class _StatData {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _StatData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class _ScheduleData {
  final String time;
  final String subject;
  final String className;
  final String room;
  final IconData icon;
  final bool active;

  const _ScheduleData({
    required this.time,
    required this.subject,
    required this.className,
    required this.room,
    required this.icon,
    this.active = false,
  });
}

class _ActionData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _ActionData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}