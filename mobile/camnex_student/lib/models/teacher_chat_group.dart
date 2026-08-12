class TeacherChatGroup {
  final String id;
  final String name;

  /// CLASS or DEPARTMENT
  final String type;

  final String subtitle;
  final String description;

  final int memberCount;

  /// IDs of teachers who belong to this group.
  final List<String> memberIds;

  final String lastMessage;
  final DateTime lastMessageTime;

  const TeacherChatGroup({
    required this.id,
    required this.name,
    required this.type,
    required this.subtitle,
    required this.description,
    required this.memberCount,
    required this.memberIds,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  TeacherChatGroup copyWith({
    String? id,
    String? name,
    String? type,
    String? subtitle,
    String? description,
    int? memberCount,
    List<String>? memberIds,
    String? lastMessage,
    DateTime? lastMessageTime,
  }) {
    return TeacherChatGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      memberCount: memberCount ?? this.memberCount,
      memberIds: memberIds ?? this.memberIds,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'subtitle': subtitle,
      'description': description,
      'memberCount': memberCount,
      'memberIds': memberIds,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
    };
  }

  factory TeacherChatGroup.fromMap(Map<String, dynamic> map) {
    return TeacherChatGroup(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      type: map['type']?.toString() ?? 'CLASS',
      subtitle: map['subtitle']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      memberCount: map['memberCount'] is int
          ? map['memberCount'] as int
          : int.tryParse(
                map['memberCount']?.toString() ?? '0',
              ) ??
              0,
      memberIds: List<String>.from(
        map['memberIds'] ?? const [],
      ),
      lastMessage: map['lastMessage']?.toString() ?? '',
      lastMessageTime: DateTime.tryParse(
            map['lastMessageTime']?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }
}