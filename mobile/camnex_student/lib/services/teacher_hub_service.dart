import 'dart:async';

import '../models/teacher_chat_group.dart';
import '../models/teacher_message.dart';
import '../models/teacher_announcement.dart';
import '../models/teacher_meeting.dart';

class TeacherHubService {
  // ==========================================================
  // SINGLETON
  // ==========================================================

  TeacherHubService._privateConstructor();

  static final TeacherHubService instance =
      TeacherHubService._privateConstructor();

  // ==========================================================
  // CURRENT TEACHER
  // ==========================================================

  String currentTeacherId = "TCH001";

  String currentTeacherName = "Rahul Sharma";

  String currentTeacherRole = "Class Teacher";

  // ==========================================================
  // DATA
  // ==========================================================

  final List<TeacherChatGroup> _groups = [];

  final Map<String, List<TeacherMessage>> _messages = {};

  final List<TeacherAnnouncement> _announcements = [];

  final List<TeacherMeeting> _meetings = [];

  // ==========================================================
  // INITIALIZATION
  // ==========================================================

  bool _initialized = false;

  void initialize() {
    if (_initialized) {
      return;
    }

    _initialized = true;

    _loadSampleGroups();
    _loadSampleMessages();
    _loadSampleAnnouncements();
    _loadSampleMeetings();
  }

  // ==========================================================
  // GROUP CHAT
  // ==========================================================

  // ----------------------------------------------------------
  // GET ALL GROUPS
  // ----------------------------------------------------------

  List<TeacherChatGroup> getGroups() {
    initialize();

    return List.unmodifiable(_groups);
  }

  // ----------------------------------------------------------
  // GET RECENT GROUPS
  // ----------------------------------------------------------

  List<TeacherChatGroup> getRecentGroups() {
    initialize();

    final groups = List<TeacherChatGroup>.from(_groups);

    groups.sort(
      (a, b) => b.lastMessageTime.compareTo(
        a.lastMessageTime,
      ),
    );

    return groups;
  }

  // ----------------------------------------------------------
  // SEARCH GROUPS
  // ----------------------------------------------------------

  List<TeacherChatGroup> searchGroups(String query) {
    initialize();

    final search = query.trim().toLowerCase();

    if (search.isEmpty) {
      return getRecentGroups();
    }

    return getRecentGroups().where((group) {
      return group.name.toLowerCase().contains(search) ||
          group.type.toLowerCase().contains(search) ||
          group.subtitle.toLowerCase().contains(search) ||
          group.description.toLowerCase().contains(search);
    }).toList();
  }

  // ----------------------------------------------------------
  // FILTER BY CLASS
  // ----------------------------------------------------------

  List<TeacherChatGroup> filterGroupsByClass(
    String className,
  ) {
    initialize();

    final search = className.trim().toLowerCase();

    return getRecentGroups().where((group) {
      return group.type.toUpperCase() == "CLASS" &&
          (group.name.toLowerCase().contains(search) ||
              group.subtitle.toLowerCase().contains(search));
    }).toList();
  }

  // ----------------------------------------------------------
  // FILTER BY DEPARTMENT
  // ----------------------------------------------------------

  List<TeacherChatGroup> filterGroupsByDepartment(
    String department,
  ) {
    initialize();

    final search = department.trim().toLowerCase();

    return getRecentGroups().where((group) {
      return group.type.toUpperCase() == "DEPARTMENT" &&
          (group.name.toLowerCase().contains(search) ||
              group.subtitle.toLowerCase().contains(search));
    }).toList();
  }

  // ----------------------------------------------------------
  // FILTER BY TYPE
  // ----------------------------------------------------------

  List<TeacherChatGroup> filterGroupsByType(
    String type,
  ) {
    initialize();

    final normalizedType = type.trim().toUpperCase();

    return getRecentGroups()
        .where(
          (group) =>
              group.type.toUpperCase() == normalizedType,
        )
        .toList();
  }

  // ----------------------------------------------------------
  // GET GROUP BY ID
  // ----------------------------------------------------------

  TeacherChatGroup? getGroupById(
    String groupId,
  ) {
    initialize();

    for (final group in _groups) {
      if (group.id == groupId) {
        return group;
      }
    }

    return null;
  }

  // ==========================================================
  // MESSAGE SERVICES
  // ==========================================================

  // ----------------------------------------------------------
  // GET MESSAGES
  // ----------------------------------------------------------

  List<TeacherMessage> getMessages(
    String groupId,
  ) {
    initialize();

    return List.unmodifiable(
      _messages[groupId] ?? <TeacherMessage>[],
    );
  }

  // ----------------------------------------------------------
  // SEND MESSAGE
  // ----------------------------------------------------------

  Future<TeacherMessage> sendMessage({
    required String groupId,
    required String text,
    String? attachmentName,
    String? attachmentUrl,
    String? attachmentType,
  }) async {
    initialize();

    if (text.trim().isEmpty &&
        attachmentName == null) {
      throw Exception(
        "Message cannot be empty.",
      );
    }

    final message = TeacherMessage(
      id:
          "MSG_${DateTime.now().millisecondsSinceEpoch}",
      groupId: groupId,
      senderId: currentTeacherId,
      senderName: currentTeacherName,
      senderRole: currentTeacherRole,
      message: text.trim(),
      sentAt: DateTime.now(),
      attachmentName: attachmentName,
      attachmentUrl: attachmentUrl,
      attachmentType: attachmentType,
      isRead: true,
    );

    _messages.putIfAbsent(
      groupId,
      () => <TeacherMessage>[],
    );

    _messages[groupId]!.add(message);

    _updateGroupLastMessage(
      groupId,
      message.message,
      message.sentAt,
    );

    return message;
  }

  // ----------------------------------------------------------
  // UPDATE GROUP LAST MESSAGE
  // ----------------------------------------------------------

  void _updateGroupLastMessage(
    String groupId,
    String message,
    DateTime time,
  ) {
    final index = _groups.indexWhere(
      (group) => group.id == groupId,
    );

    if (index == -1) {
      return;
    }

    final group = _groups[index];

    _groups[index] = group.copyWith(
      lastMessage: message,
      lastMessageTime: time,
    );
  }

  // ----------------------------------------------------------
  // MESSAGE STREAM
  // ----------------------------------------------------------

  Stream<List<TeacherMessage>> messageStream(
    String groupId,
  ) async* {
    initialize();

    yield getMessages(groupId);

    await Future<void>.delayed(
      const Duration(milliseconds: 100),
    );

    yield getMessages(groupId);
  }

  // ----------------------------------------------------------
  // MARK MESSAGE AS READ
  // ----------------------------------------------------------

  void markMessageAsRead(
    String groupId,
    String messageId,
  ) {
    initialize();

    final messages = _messages[groupId];

    if (messages == null) {
      return;
    }

    final index = messages.indexWhere(
      (message) => message.id == messageId,
    );

    if (index == -1) {
      return;
    }

    messages[index] = messages[index].copyWith(
      isRead: true,
    );
  }

  // ----------------------------------------------------------
  // MARK GROUP AS READ
  // ----------------------------------------------------------

  void markGroupAsRead(
    String groupId,
  ) {
    initialize();

    final messages = _messages[groupId];

    if (messages == null) {
      return;
    }

    for (int i = 0; i < messages.length; i++) {
      messages[i] = messages[i].copyWith(
        isRead: true,
      );
    }
  }

  // ----------------------------------------------------------
  // UNREAD COUNT
  // ----------------------------------------------------------

  int getUnreadMessageCount(
    String groupId,
  ) {
    initialize();

    final messages =
        _messages[groupId] ?? <TeacherMessage>[];

    return messages.where((message) {
      return !message.isRead &&
          message.senderId != currentTeacherId;
    }).length;
  }

  // ==========================================================
  // ANNOUNCEMENTS
  // ==========================================================

  // ----------------------------------------------------------
  // GET ANNOUNCEMENTS
  // ----------------------------------------------------------

  List<TeacherAnnouncement> getAnnouncements() {
    initialize();

    final announcements =
        List<TeacherAnnouncement>.from(
      _announcements,
    );

    announcements.sort(
      (a, b) => b.createdAt.compareTo(
        a.createdAt,
      ),
    );

    return announcements;
  }

  // ----------------------------------------------------------
  // SEARCH ANNOUNCEMENTS
  // ----------------------------------------------------------

  List<TeacherAnnouncement> searchAnnouncements(
    String query,
  ) {
    initialize();

    final search = query.trim().toLowerCase();

    if (search.isEmpty) {
      return getAnnouncements();
    }

    return getAnnouncements()
        .where((announcement) {
      return announcement.title
              .toLowerCase()
              .contains(search) ||
          announcement.message
              .toLowerCase()
              .contains(search) ||
          announcement.targetDisplayText
              .toLowerCase()
              .contains(search);
    }).toList();
  }

  // ----------------------------------------------------------
  // FILTER ANNOUNCEMENTS BY CLASS
  // ----------------------------------------------------------

  List<TeacherAnnouncement>
      filterAnnouncementsByClass(
    String className,
  ) {
    initialize();

    final search =
        className.trim().toLowerCase();

    return getAnnouncements()
        .where((announcement) {
      if (!announcement.isClassAnnouncement) {
        return false;
      }

      return announcement.targetGroups.any(
        (group) =>
            group.toLowerCase() == search ||
            group.toLowerCase().contains(search),
      );
    }).toList();
  }

  // ----------------------------------------------------------
  // FILTER ANNOUNCEMENTS BY DEPARTMENT
  // ----------------------------------------------------------

  List<TeacherAnnouncement>
      filterAnnouncementsByDepartment(
    String department,
  ) {
    initialize();

    final search =
        department.trim().toLowerCase();

    return getAnnouncements()
        .where((announcement) {
      if (!announcement
          .isDepartmentAnnouncement) {
        return false;
      }

      return announcement.targetGroups.any(
        (group) =>
            group.toLowerCase() == search ||
            group.toLowerCase().contains(search),
      );
    }).toList();
  }

  // ----------------------------------------------------------
  // CREATE ANNOUNCEMENT
  // ----------------------------------------------------------

  Future<TeacherAnnouncement>
      createAnnouncement({
    required String title,
    required String message,
    required String targetType,
    required List<String> targetGroups,
    DateTime? expiresAt,
    String? attachmentName,
    String? attachmentUrl,
    String? attachmentType,
  }) async {
    initialize();

    if (title.trim().isEmpty) {
      throw Exception(
        "Announcement title is required.",
      );
    }

    if (message.trim().isEmpty) {
      throw Exception(
        "Announcement message is required.",
      );
    }

    if (targetGroups.isEmpty) {
      throw Exception(
        "Please select at least one target group.",
      );
    }

    final announcement =
        TeacherAnnouncement(
      id:
          "ANN_${DateTime.now().millisecondsSinceEpoch}",
      title: title.trim(),
      message: message.trim(),
      createdById: currentTeacherId,
      createdByName: currentTeacherName,
      createdByRole: currentTeacherRole,
      targetType: targetType,
      targetGroups:
          List<String>.from(targetGroups),
      createdAt: DateTime.now(),
      expiresAt: expiresAt,
      attachmentName: attachmentName,
      attachmentUrl: attachmentUrl,
      attachmentType: attachmentType,
      isActive: true,
    );

    _announcements.add(
      announcement,
    );

    return announcement;
  }

  // ----------------------------------------------------------
  // DEACTIVATE ANNOUNCEMENT
  // ----------------------------------------------------------

  void deactivateAnnouncement(
    String announcementId,
  ) {
    initialize();

    final index =
        _announcements.indexWhere(
      (announcement) =>
          announcement.id == announcementId,
    );

    if (index == -1) {
      return;
    }

    _announcements[index] =
        _announcements[index].copyWith(
      isActive: false,
    );
  }

  // ==========================================================
  // MEETINGS
  // ==========================================================

  // ----------------------------------------------------------
  // GET ALL MEETINGS
  // ----------------------------------------------------------

  List<TeacherMeeting> getMeetings() {
    initialize();

    final meetings =
        List<TeacherMeeting>.from(
      _meetings,
    );

    meetings.sort(
      (a, b) => b.scheduledAt.compareTo(
        a.scheduledAt,
      ),
    );

    return meetings;
  }

  // ----------------------------------------------------------
  // GET UPCOMING MEETINGS
  // ----------------------------------------------------------

  List<TeacherMeeting>
      getUpcomingMeetings() {
    initialize();

    return getMeetings()
        .where(
          (meeting) =>
              meeting.isUpcoming ||
              meeting.isOngoing,
        )
        .toList();
  }

  // ----------------------------------------------------------
  // GET PAST MEETINGS
  // ----------------------------------------------------------

  List<TeacherMeeting> getPastMeetings() {
    initialize();

    return getMeetings()
        .where(
          (meeting) =>
              meeting.isCompleted,
        )
        .toList();
  }

  // ----------------------------------------------------------
  // LAST 48 HOURS
  // ----------------------------------------------------------

  List<TeacherMeeting>
      getMeetingsFromLast48Hours() {
    initialize();

    final now = DateTime.now();

    final cutoff = now.subtract(
      const Duration(hours: 48),
    );

    return getMeetings().where(
      (meeting) {
        return meeting.scheduledAt
                .isAfter(cutoff) &&
            meeting.scheduledAt.isBefore(now);
      },
    ).toList();
  }

  // ----------------------------------------------------------
  // GET MEETING BY ID
  // ----------------------------------------------------------

  TeacherMeeting? getMeetingById(
    String meetingId,
  ) {
    initialize();

    for (final meeting in _meetings) {
      if (meeting.id == meetingId) {
        return meeting;
      }
    }

    return null;
  }

  // ----------------------------------------------------------
  // SCHEDULE MEETING
  // ----------------------------------------------------------

  Future<TeacherMeeting>
      scheduleMeeting({
    required String title,
    required String description,
    required DateTime scheduledAt,
    required int durationMinutes,
    List<String> selectedGroupIds =
        const <String>[],
    List<String> selectedMemberIds =
        const <String>[],
    List<String> participantIds =
        const <String>[],
    String? meetingLink,
  }) async {
    initialize();

    // --------------------------------------------------------
    // BASIC VALIDATION
    // --------------------------------------------------------

    if (title.trim().isEmpty) {
      throw Exception(
        "Meeting title is required.",
      );
    }

    if (durationMinutes < 30) {
      throw Exception(
        "Meeting duration cannot be less than 30 minutes.",
      );
    }

    if (durationMinutes > 4320) {
      throw Exception(
        "Meeting duration cannot exceed 72 hours.",
      );
    }

    // --------------------------------------------------------
    // SCHEDULING WINDOW
    // --------------------------------------------------------

    final now = DateTime.now();

    final minimumTime = now.add(
      const Duration(minutes: 30),
    );

    final maximumTime = now.add(
      const Duration(hours: 72),
    );

    if (scheduledAt.isBefore(minimumTime)) {
      throw Exception(
        "Meeting must be scheduled at least 30 minutes in advance.",
      );
    }

    if (scheduledAt.isAfter(maximumTime)) {
      throw Exception(
        "Meeting cannot be scheduled more than 72 hours in advance.",
      );
    }

    // --------------------------------------------------------
    // PARTICIPANT VALIDATION
    // --------------------------------------------------------

    if (selectedGroupIds.isEmpty &&
        selectedMemberIds.isEmpty &&
        participantIds.isEmpty) {
      throw Exception(
        "Please select at least one group or teacher.",
      );
    }

    // --------------------------------------------------------
    // CREATE MEETING
    // --------------------------------------------------------

    final meeting = TeacherMeeting(
      id:
          "MEET_${DateTime.now().millisecondsSinceEpoch}",
      title: title.trim(),
      description: description.trim(),
      createdById: currentTeacherId,
      createdByName: currentTeacherName,
      createdByRole: currentTeacherRole,
      scheduledAt: scheduledAt,
      durationMinutes: durationMinutes,
      selectedGroupIds:
          List<String>.from(selectedGroupIds),
      selectedMemberIds:
          List<String>.from(selectedMemberIds),
      participantIds:
          List<String>.from(participantIds),
      meetingLink: meetingLink,
      status: "SCHEDULED",
      createdAt: DateTime.now(),
    );

    _meetings.add(meeting);

    return meeting;
  }

  // ----------------------------------------------------------
  // CANCEL MEETING
  // ----------------------------------------------------------

  void cancelMeeting(
    String meetingId,
  ) {
    initialize();

    final index =
        _meetings.indexWhere(
      (meeting) =>
          meeting.id == meetingId,
    );

    if (index == -1) {
      return;
    }

    _meetings[index] =
        _meetings[index].copyWith(
      status: "CANCELLED",
      updatedAt: DateTime.now(),
    );
  }

  // ----------------------------------------------------------
  // UPDATE MEETING STATUS
  // ----------------------------------------------------------

  void updateMeetingStatus(
    String meetingId,
    String status,
  ) {
    initialize();

    const validStatuses = [
      "SCHEDULED",
      "ONGOING",
      "COMPLETED",
      "CANCELLED",
    ];

    if (!validStatuses.contains(status)) {
      throw Exception(
        "Invalid meeting status.",
      );
    }

    final index =
        _meetings.indexWhere(
      (meeting) =>
          meeting.id == meetingId,
    );

    if (index == -1) {
      return;
    }

    _meetings[index] =
        _meetings[index].copyWith(
      status: status,
      updatedAt: DateTime.now(),
    );
  }

  // ==========================================================
  // GROUP MEMBERS
  // ==========================================================

  // ----------------------------------------------------------
  // GET MEMBER IDS
  // ----------------------------------------------------------

  List<String> getGroupMemberIds(
    String groupId,
  ) {
    initialize();

    final group =
        getGroupById(groupId);

    if (group == null) {
      return <String>[];
    }

    return List<String>.from(
      group.memberIds,
    );
  }

  // ----------------------------------------------------------
  // CHECK MEMBERSHIP
  // ----------------------------------------------------------

  bool isTeacherMemberOfGroup(
    String groupId,
    String teacherId,
  ) {
    return getGroupMemberIds(groupId)
        .contains(teacherId);
  }

  // ==========================================================
  // SAMPLE GROUPS
  // ==========================================================

  void _loadSampleGroups() {
    if (_groups.isNotEmpty) {
      return;
    }

    _groups.addAll([
      TeacherChatGroup(
        id: "CLASS_VIII_A",
        name: "Class VIII-A",
        type: "CLASS",
        subtitle:
            "Class Teachers & Subject Teachers",
        description:
            "Teachers assigned to Class VIII-A",
        memberCount: 4,
        memberIds: [
          "TCH001",
          "TCH002",
          "TCH003",
          "TCH004",
        ],
        lastMessage:
            "Please submit the class report.",
        lastMessageTime:
            DateTime.now().subtract(
          const Duration(minutes: 20),
        ),
      ),

      TeacherChatGroup(
        id: "CLASS_VII_A",
        name: "Class VII-A",
        type: "CLASS",
        subtitle:
            "Class Teachers & Subject Teachers",
        description:
            "Teachers assigned to Class VII-A",
        memberCount: 3,
        memberIds: [
          "TCH001",
          "TCH005",
          "TCH006",
        ],
        lastMessage:
            "Science activity completed.",
        lastMessageTime:
            DateTime.now().subtract(
          const Duration(hours: 2),
        ),
      ),

      TeacherChatGroup(
        id: "DEPARTMENT_SCIENCE",
        name: "Science Department",
        type: "DEPARTMENT",
        subtitle:
            "Science Subject Teachers",
        description:
            "All teachers belonging to the Science department",
        memberCount: 4,
        memberIds: [
          "TCH001",
          "TCH003",
          "TCH007",
          "TCH008",
        ],
        lastMessage:
            "Department meeting tomorrow.",
        lastMessageTime:
            DateTime.now().subtract(
          const Duration(hours: 5),
        ),
      ),

      TeacherChatGroup(
        id: "DEPARTMENT_MATH",
        name: "Mathematics Department",
        type: "DEPARTMENT",
        subtitle:
            "Mathematics Subject Teachers",
        description:
            "All teachers belonging to the Mathematics department",
        memberCount: 3,
        memberIds: [
          "TCH002",
          "TCH004",
          "TCH009",
        ],
        lastMessage:
            "Question paper discussion.",
        lastMessageTime:
            DateTime.now().subtract(
          const Duration(days: 1),
        ),
      ),
    ]);
  }

  // ==========================================================
  // SAMPLE MESSAGES
  // ==========================================================

  void _loadSampleMessages() {
    if (_messages.isNotEmpty) {
      return;
    }

    _messages["CLASS_VIII_A"] = [
      TeacherMessage(
        id: "MSG001",
        groupId: "CLASS_VIII_A",
        senderId: "TCH002",
        senderName: "Priya Singh",
        senderRole: "Subject Teacher",
        message:
            "How many students submitted the assignment?",
        sentAt:
            DateTime.now().subtract(
          const Duration(hours: 2),
        ),
        isRead: true,
      ),

      TeacherMessage(
        id: "MSG002",
        groupId: "CLASS_VIII_A",
        senderId: "TCH001",
        senderName: "Rahul Sharma",
        senderRole: "Class Teacher",
        message:
            "Twenty-four students have submitted it.",
        sentAt:
            DateTime.now().subtract(
          const Duration(hours: 1),
        ),
        isRead: true,
      ),
    ];

    _messages["CLASS_VII_A"] = [
      TeacherMessage(
        id: "MSG004",
        groupId: "CLASS_VII_A",
        senderId: "TCH005",
        senderName: "Amit Kumar",
        senderRole: "Science Teacher",
        message:
            "Science activity has been completed.",
        sentAt:
            DateTime.now().subtract(
          const Duration(hours: 2),
        ),
        isRead: true,
      ),
    ];

    _messages["DEPARTMENT_SCIENCE"] = [
      TeacherMessage(
        id: "MSG003",
        groupId: "DEPARTMENT_SCIENCE",
        senderId: "TCH003",
        senderName: "Anita Verma",
        senderRole: "Science Teacher",
        message:
            "Department meeting is scheduled for tomorrow.",
        sentAt:
            DateTime.now().subtract(
          const Duration(minutes: 30),
        ),
        isRead: false,
      ),
    ];

    _messages["DEPARTMENT_MATH"] = [
      TeacherMessage(
        id: "MSG005",
        groupId: "DEPARTMENT_MATH",
        senderId: "TCH009",
        senderName: "Neha Gupta",
        senderRole: "Mathematics Teacher",
        message:
            "Question paper discussion starts at 3 PM.",
        sentAt:
            DateTime.now().subtract(
          const Duration(hours: 4),
        ),
        isRead: true,
      ),
    ];
  }

  // ==========================================================
  // SAMPLE ANNOUNCEMENTS
  // ==========================================================

  void _loadSampleAnnouncements() {
    if (_announcements.isNotEmpty) {
      return;
    }

    _announcements.addAll([
      TeacherAnnouncement(
        id: "ANN001",
        title: "Parent-Teacher Meeting",
        message:
            "Parent-teacher meeting will be conducted this Saturday.",
        createdById: "TCH001",
        createdByName: "Rahul Sharma",
        createdByRole: "Class Teacher",
        targetType: "class",
        targetGroups: [
          "VIII-A",
        ],
        createdAt:
            DateTime.now().subtract(
          const Duration(hours: 3),
        ),
        isActive: true,
      ),

      TeacherAnnouncement(
        id: "ANN002",
        title: "Science Department Meeting",
        message:
            "All science teachers are requested to attend the department meeting.",
        createdById: "TCH003",
        createdByName: "Anita Verma",
        createdByRole: "Science Teacher",
        targetType: "department",
        targetGroups: [
          "Science",
        ],
        createdAt:
            DateTime.now().subtract(
          const Duration(days: 1),
        ),
        isActive: true,
      ),
    ]);
  }

  // ==========================================================
  // SAMPLE MEETINGS
  // ==========================================================

  void _loadSampleMeetings() {
    if (_meetings.isNotEmpty) {
      return;
    }

    _meetings.add(
      TeacherMeeting(
        id: "MEET001",
        title: "Class VIII-A Discussion",
        description:
            "Discussion regarding student performance.",
        createdById: "TCH001",
        createdByName: "Rahul Sharma",
        createdByRole: "Class Teacher",
        scheduledAt:
            DateTime.now().add(
          const Duration(hours: 3),
        ),
        durationMinutes: 60,
        selectedGroupIds: [
          "CLASS_VIII_A",
        ],
        selectedMemberIds: [],
        participantIds: [
          "TCH001",
          "TCH002",
          "TCH003",
          "TCH004",
        ],
        meetingLink:
            "https://example.com/meeting/MEET001",
        status: "SCHEDULED",
        createdAt: DateTime.now(),
      ),
    );
  }
}