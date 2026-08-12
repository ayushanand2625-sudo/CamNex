class TeacherMessage {
  final String id;
  final String groupId;
  final String senderId;
  final String senderName;
  final String senderRole;
  final String message;
  final DateTime sentAt;

  // Optional profile image of sender
  final String? senderImageUrl;

  // Message status
  final bool isRead;

  // Optional attachment
  final String? attachmentName;
  final String? attachmentUrl;
  final String? attachmentType;

  TeacherMessage({
    required this.id,
    required this.groupId,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.message,
    required this.sentAt,
    this.senderImageUrl,
    this.isRead = false,
    this.attachmentName,
    this.attachmentUrl,
    this.attachmentType,
  });

  // ==========================================================
  // CREATE FROM JSON
  // ==========================================================

  factory TeacherMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return TeacherMessage(
      id: json["id"]?.toString() ?? "",

      groupId:
          json["groupId"]?.toString() ?? "",

      senderId:
          json["senderId"]?.toString() ?? "",

      senderName:
          json["senderName"]?.toString() ?? "",

      senderRole:
          json["senderRole"]?.toString() ?? "Teacher",

      message:
          json["message"]?.toString() ?? "",

      sentAt:
          DateTime.tryParse(
                json["sentAt"]?.toString() ?? "",
              ) ??
              DateTime.now(),

      senderImageUrl:
          json["senderImageUrl"]?.toString(),

      isRead:
          json["isRead"] == true,

      attachmentName:
          json["attachmentName"]?.toString(),

      attachmentUrl:
          json["attachmentUrl"]?.toString(),

      attachmentType:
          json["attachmentType"]?.toString(),
    );
  }

  // ==========================================================
  // CONVERT TO JSON
  // ==========================================================

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "groupId": groupId,
      "senderId": senderId,
      "senderName": senderName,
      "senderRole": senderRole,
      "message": message,
      "sentAt": sentAt.toIso8601String(),
      "senderImageUrl": senderImageUrl,
      "isRead": isRead,
      "attachmentName": attachmentName,
      "attachmentUrl": attachmentUrl,
      "attachmentType": attachmentType,
    };
  }

  // ==========================================================
  // COPY WITH
  // ==========================================================

  TeacherMessage copyWith({
    String? id,
    String? groupId,
    String? senderId,
    String? senderName,
    String? senderRole,
    String? message,
    DateTime? sentAt,
    String? senderImageUrl,
    bool? isRead,
    String? attachmentName,
    String? attachmentUrl,
    String? attachmentType,
  }) {
    return TeacherMessage(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderRole: senderRole ?? this.senderRole,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
      senderImageUrl:
          senderImageUrl ?? this.senderImageUrl,
      isRead: isRead ?? this.isRead,
      attachmentName:
          attachmentName ?? this.attachmentName,
      attachmentUrl:
          attachmentUrl ?? this.attachmentUrl,
      attachmentType:
          attachmentType ?? this.attachmentType,
    );
  }

  // ==========================================================
  // HELPERS
  // ==========================================================

  bool get hasAttachment {
    return attachmentName != null &&
        attachmentName!.isNotEmpty;
  }

  bool get isImageAttachment {
    if (attachmentType == null) {
      return false;
    }

    final type =
        attachmentType!.toLowerCase();

    return type == "image" ||
        type == "jpg" ||
        type == "jpeg" ||
        type == "png" ||
        type == "webp";
  }

  bool get isDocumentAttachment {
    if (attachmentType == null) {
      return false;
    }

    final type =
        attachmentType!.toLowerCase();

    return type == "pdf" ||
        type == "document" ||
        type == "doc" ||
        type == "docx" ||
        type == "xls" ||
        type == "xlsx" ||
        type == "ppt" ||
        type == "pptx";
  }
}