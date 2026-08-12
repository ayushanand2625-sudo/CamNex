class TeacherAnnouncement {
  final String id;

  // Announcement content
  final String title;
  final String message;

  // Teacher who created the announcement
  final String createdById;
  final String createdByName;
  final String createdByRole;

  // Optional teacher profile image
  final String? createdByImageUrl;

  // Target information
  // Examples:
  // "class"
  // "department"
  // "all"
  final String targetType;

  // Class or department IDs/names
  final List<String> targetGroups;

  // Creation time
  final DateTime createdAt;

  // Optional expiry
  final DateTime? expiresAt;

  // Optional attachment
  final String? attachmentName;
  final String? attachmentUrl;
  final String? attachmentType;

  // Announcement status
  final bool isActive;

  TeacherAnnouncement({
    required this.id,
    required this.title,
    required this.message,
    required this.createdById,
    required this.createdByName,
    required this.createdByRole,
    this.createdByImageUrl,
    required this.targetType,
    required this.targetGroups,
    required this.createdAt,
    this.expiresAt,
    this.attachmentName,
    this.attachmentUrl,
    this.attachmentType,
    this.isActive = true,
  });

  // ==========================================================
  // CREATE FROM JSON
  // ==========================================================

  factory TeacherAnnouncement.fromJson(
    Map<String, dynamic> json,
  ) {
    return TeacherAnnouncement(
      id: json["id"]?.toString() ?? "",

      title:
          json["title"]?.toString() ?? "",

      message:
          json["message"]?.toString() ?? "",

      createdById:
          json["createdById"]?.toString() ?? "",

      createdByName:
          json["createdByName"]?.toString() ?? "",

      createdByRole:
          json["createdByRole"]?.toString() ??
              "Teacher",

      createdByImageUrl:
          json["createdByImageUrl"]?.toString(),

      targetType:
          json["targetType"]?.toString() ?? "class",

      targetGroups:
          json["targetGroups"] is List
              ? List<String>.from(
                  json["targetGroups"].map(
                    (item) => item.toString(),
                  ),
                )
              : [],

      createdAt:
          DateTime.tryParse(
                json["createdAt"]?.toString() ?? "",
              ) ??
              DateTime.now(),

      expiresAt:
          json["expiresAt"] == null
              ? null
              : DateTime.tryParse(
                  json["expiresAt"].toString(),
                ),

      attachmentName:
          json["attachmentName"]?.toString(),

      attachmentUrl:
          json["attachmentUrl"]?.toString(),

      attachmentType:
          json["attachmentType"]?.toString(),

      isActive:
          json["isActive"] != false,
    );
  }

  // ==========================================================
  // CONVERT TO JSON
  // ==========================================================

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "message": message,
      "createdById": createdById,
      "createdByName": createdByName,
      "createdByRole": createdByRole,
      "createdByImageUrl": createdByImageUrl,
      "targetType": targetType,
      "targetGroups": targetGroups,
      "createdAt": createdAt.toIso8601String(),
      "expiresAt": expiresAt?.toIso8601String(),
      "attachmentName": attachmentName,
      "attachmentUrl": attachmentUrl,
      "attachmentType": attachmentType,
      "isActive": isActive,
    };
  }

  // ==========================================================
  // COPY WITH
  // ==========================================================

  TeacherAnnouncement copyWith({
    String? id,
    String? title,
    String? message,
    String? createdById,
    String? createdByName,
    String? createdByRole,
    String? createdByImageUrl,
    String? targetType,
    List<String>? targetGroups,
    DateTime? createdAt,
    DateTime? expiresAt,
    String? attachmentName,
    String? attachmentUrl,
    String? attachmentType,
    bool? isActive,
  }) {
    return TeacherAnnouncement(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      createdById:
          createdById ?? this.createdById,
      createdByName:
          createdByName ?? this.createdByName,
      createdByRole:
          createdByRole ?? this.createdByRole,
      createdByImageUrl:
          createdByImageUrl ??
              this.createdByImageUrl,
      targetType:
          targetType ?? this.targetType,
      targetGroups:
          targetGroups ?? this.targetGroups,
      createdAt:
          createdAt ?? this.createdAt,
      expiresAt:
          expiresAt ?? this.expiresAt,
      attachmentName:
          attachmentName ?? this.attachmentName,
      attachmentUrl:
          attachmentUrl ?? this.attachmentUrl,
      attachmentType:
          attachmentType ?? this.attachmentType,
      isActive:
          isActive ?? this.isActive,
    );
  }

  // ==========================================================
  // HELPERS
  // ==========================================================

  bool get hasAttachment {
    return attachmentName != null &&
        attachmentName!.isNotEmpty;
  }

  bool get isClassAnnouncement {
    return targetType == "class";
  }

  bool get isDepartmentAnnouncement {
    return targetType == "department";
  }

  bool get isForEveryone {
    return targetType == "all";
  }

  bool get isExpired {
    if (expiresAt == null) {
      return false;
    }

    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isCurrentlyActive {
    return isActive && !isExpired;
  }

  // ==========================================================
  // TARGET DISPLAY TEXT
  // ==========================================================

  String get targetDisplayText {
    if (targetType == "all") {
      return "All Teachers";
    }

    if (targetGroups.isEmpty) {
      return "No target selected";
    }

    if (targetType == "class") {
      return targetGroups.length == 1
          ? "Class ${targetGroups.first}"
          : "Classes: ${targetGroups.join(", ")}";
    }

    if (targetType == "department") {
      return targetGroups.length == 1
          ? "${targetGroups.first} Department"
          : "Departments: ${targetGroups.join(", ")}";
    }

    return targetGroups.join(", ");
  }
}