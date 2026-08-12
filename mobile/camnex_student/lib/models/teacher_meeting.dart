class TeacherMeeting {
  final String id;

  // ==========================================================
  // MEETING INFORMATION
  // ==========================================================

  final String title;
  final String description;

  // ==========================================================
  // CREATOR INFORMATION
  // ==========================================================

  final String createdById;
  final String createdByName;
  final String createdByRole;
  final String? createdByImageUrl;

  // ==========================================================
  // MEETING TIME
  // ==========================================================

  final DateTime scheduledAt;

  // Meeting duration in minutes
  // Allowed by the scheduling screen:
  // 30 minutes to 72 hours
  final int durationMinutes;

  // ==========================================================
  // PARTICIPANT GROUPS
  // ==========================================================

  // Examples:
  // CLASS_V_A
  // CLASS_VIII_A
  // DEPARTMENT_SCIENCE
  // DEPARTMENT_MATHEMATICS
  final List<String> selectedGroupIds;

  // ==========================================================
  // MANUALLY SELECTED MEMBERS
  // ==========================================================

  // Teachers selected individually by searching.
  final List<String> selectedMemberIds;

  // ==========================================================
  // FINAL PARTICIPANTS
  // ==========================================================

  // This contains the final list of teachers who are allowed
  // to join the meeting after resolving selected groups
  // and manually selected members.
  final List<String> participantIds;

  // ==========================================================
  // MEETING LINK
  // ==========================================================

  final String? meetingLink;

  // ==========================================================
  // MEETING STATUS
  // ==========================================================

  // Possible values:
  //
  // SCHEDULED
  // ONGOING
  // COMPLETED
  // CANCELLED
  final String status;

  // ==========================================================
  // CREATED / UPDATED INFORMATION
  // ==========================================================

  final DateTime createdAt;
  final DateTime? updatedAt;

  TeacherMeeting({
    required this.id,
    required this.title,
    required this.description,
    required this.createdById,
    required this.createdByName,
    required this.createdByRole,
    this.createdByImageUrl,
    required this.scheduledAt,
    required this.durationMinutes,
    this.selectedGroupIds = const [],
    this.selectedMemberIds = const [],
    this.participantIds = const [],
    this.meetingLink,
    this.status = "SCHEDULED",
    required this.createdAt,
    this.updatedAt,
  });

  // ==========================================================
  // FROM JSON
  // ==========================================================

  factory TeacherMeeting.fromJson(
    Map<String, dynamic> json,
  ) {
    return TeacherMeeting(
      id: json["id"]?.toString() ?? "",

      title:
          json["title"]?.toString() ?? "",

      description:
          json["description"]?.toString() ?? "",

      createdById:
          json["createdById"]?.toString() ?? "",

      createdByName:
          json["createdByName"]?.toString() ?? "",

      createdByRole:
          json["createdByRole"]?.toString() ??
              "Teacher",

      createdByImageUrl:
          json["createdByImageUrl"]?.toString(),

      scheduledAt:
          DateTime.tryParse(
                json["scheduledAt"]?.toString() ?? "",
              ) ??
              DateTime.now(),

      durationMinutes:
          _parseInt(
            json["durationMinutes"],
            fallback: 30,
          ),

      selectedGroupIds:
          _parseStringList(
            json["selectedGroupIds"],
          ),

      selectedMemberIds:
          _parseStringList(
            json["selectedMemberIds"],
          ),

      participantIds:
          _parseStringList(
            json["participantIds"],
          ),

      meetingLink:
          json["meetingLink"]?.toString(),

      status:
          json["status"]?.toString() ??
              "SCHEDULED",

      createdAt:
          DateTime.tryParse(
                json["createdAt"]?.toString() ?? "",
              ) ??
              DateTime.now(),

      updatedAt:
          json["updatedAt"] == null
              ? null
              : DateTime.tryParse(
                  json["updatedAt"].toString(),
                ),
    );
  }

  // ==========================================================
  // TO JSON
  // ==========================================================

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,

      "createdById": createdById,
      "createdByName": createdByName,
      "createdByRole": createdByRole,
      "createdByImageUrl": createdByImageUrl,

      "scheduledAt":
          scheduledAt.toIso8601String(),

      "durationMinutes":
          durationMinutes,

      "selectedGroupIds":
          selectedGroupIds,

      "selectedMemberIds":
          selectedMemberIds,

      "participantIds":
          participantIds,

      "meetingLink":
          meetingLink,

      "status":
          status,

      "createdAt":
          createdAt.toIso8601String(),

      "updatedAt":
          updatedAt?.toIso8601String(),
    };
  }

  // ==========================================================
  // COPY WITH
  // ==========================================================

  TeacherMeeting copyWith({
    String? id,
    String? title,
    String? description,
    String? createdById,
    String? createdByName,
    String? createdByRole,
    String? createdByImageUrl,
    DateTime? scheduledAt,
    int? durationMinutes,
    List<String>? selectedGroupIds,
    List<String>? selectedMemberIds,
    List<String>? participantIds,
    String? meetingLink,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TeacherMeeting(
      id: id ?? this.id,

      title:
          title ?? this.title,

      description:
          description ?? this.description,

      createdById:
          createdById ?? this.createdById,

      createdByName:
          createdByName ?? this.createdByName,

      createdByRole:
          createdByRole ?? this.createdByRole,

      createdByImageUrl:
          createdByImageUrl ??
              this.createdByImageUrl,

      scheduledAt:
          scheduledAt ?? this.scheduledAt,

      durationMinutes:
          durationMinutes ??
              this.durationMinutes,

      selectedGroupIds:
          selectedGroupIds ??
              this.selectedGroupIds,

      selectedMemberIds:
          selectedMemberIds ??
              this.selectedMemberIds,

      participantIds:
          participantIds ??
              this.participantIds,

      meetingLink:
          meetingLink ?? this.meetingLink,

      status:
          status ?? this.status,

      createdAt:
          createdAt ?? this.createdAt,

      updatedAt:
          updatedAt ?? this.updatedAt,
    );
  }

  // ==========================================================
  // HELPER: HAS GROUP PARTICIPANTS
  // ==========================================================

  bool get hasSelectedGroups {
    return selectedGroupIds.isNotEmpty;
  }

  // ==========================================================
  // HELPER: HAS MANUAL PARTICIPANTS
  // ==========================================================

  bool get hasSelectedMembers {
    return selectedMemberIds.isNotEmpty;
  }

  // ==========================================================
  // HELPER: HAS PARTICIPANTS
  // ==========================================================

  bool get hasParticipants {
    return participantIds.isNotEmpty;
  }

  // ==========================================================
  // HELPER: HAS MEETING LINK
  // ==========================================================

  bool get hasMeetingLink {
    return meetingLink != null &&
        meetingLink!.trim().isNotEmpty;
  }

  // ==========================================================
  // HELPER: MEETING END TIME
  // ==========================================================

  DateTime get endTime {
    return scheduledAt.add(
      Duration(
        minutes: durationMinutes,
      ),
    );
  }

  // ==========================================================
  // HELPER: IS UPCOMING
  // ==========================================================

  bool get isUpcoming {
    return status == "SCHEDULED" &&
        DateTime.now().isBefore(
          scheduledAt,
        );
  }

  // ==========================================================
  // HELPER: IS ONGOING
  // ==========================================================

  bool get isOngoing {
    final now = DateTime.now();

    return status != "CANCELLED" &&
        now.isAfter(scheduledAt) &&
        now.isBefore(endTime);
  }

  // ==========================================================
  // HELPER: IS COMPLETED
  // ==========================================================

  bool get isCompleted {
    return status == "COMPLETED" ||
        DateTime.now().isAfter(endTime);
  }

  // ==========================================================
  // HELPER: IS CANCELLED
  // ==========================================================

  bool get isCancelled {
    return status == "CANCELLED";
  }

  // ==========================================================
  // HELPER: DURATION DISPLAY
  // ==========================================================

  String get durationDisplay {
    if (durationMinutes < 60) {
      return "$durationMinutes minutes";
    }

    final hours =
        durationMinutes ~/ 60;

    final minutes =
        durationMinutes % 60;

    if (minutes == 0) {
      if (hours == 1) {
        return "1 hour";
      }

      return "$hours hours";
    }

    return "$hours hr $minutes min";
  }

  // ==========================================================
  // HELPER: PARTICIPANT TYPE
  // ==========================================================

  String get participantType {
    final hasGroups =
        selectedGroupIds.isNotEmpty;

    final hasMembers =
        selectedMemberIds.isNotEmpty;

    if (hasGroups && hasMembers) {
      return "Groups + Selected Teachers";
    }

    if (hasGroups) {
      return "Group";
    }

    if (hasMembers) {
      return "Selected Teachers";
    }

    return "No Participants";
  }

  // ==========================================================
  // INTERNAL JSON HELPERS
  // ==========================================================

  static int _parseInt(
    dynamic value, {
    int fallback = 0,
  }) {
    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.toInt();
    }

    return int.tryParse(
          value?.toString() ?? "",
        ) ??
        fallback;
  }

  static List<String> _parseStringList(
    dynamic value,
  ) {
    if (value is! List) {
      return [];
    }

    return value
        .map(
          (item) => item.toString(),
        )
        .toList();
  }
}