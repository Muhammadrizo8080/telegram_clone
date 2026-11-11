/// Represents a chat (dialog) in the chat list.
class Chat {
  final String id;
  final List<String> participantIds;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String? title;
  final String? avatarUrl;

  const Chat({
    required this.id,
    required this.participantIds,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.title,
    this.avatarUrl,
  });

  /// Creates a copy of this chat with updated fields.
  Chat copyWith({
    String? id,
    List<String>? participantIds,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    String? title,
    String? avatarUrl,
  }) {
    return Chat(
      id: id ?? this.id,
      participantIds: participantIds ?? this.participantIds,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      title: title ?? this.title,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  /// Deserializes a chat from a JSON map.
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as String? ?? json['chatId'] as String? ?? '',
      participantIds:
          (json['participantIds'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          (json['members'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      lastMessage: json['lastMessage'] as String? ?? '',
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'] as String)
          : DateTime.now(),
      unreadCount: json['unreadCount'] as int? ?? 0,
      title: json['title'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  /// Serializes this chat to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participantIds': participantIds,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'unreadCount': unreadCount,
      if (title != null) 'title': title,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Chat &&
        other.id == id &&
        other.lastMessage == lastMessage &&
        other.lastMessageTime == lastMessageTime &&
        other.unreadCount == unreadCount &&
        other.title == title &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      lastMessage,
      lastMessageTime,
      unreadCount,
      title,
      avatarUrl,
    );
  }

  @override
  String toString() {
    return 'Chat(id: $id, title: $title, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount)';
  }
}
