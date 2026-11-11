/// Delivery status of a message.
enum MessageStatus { sending, sent, read }

/// Represents an individual chat message.
class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime createdAt;
  final MessageStatus status;

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.createdAt,
    this.status = MessageStatus.sent,
  });

  /// Creates a copy of this message with updated fields.
  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? text,
    DateTime? createdAt,
    MessageStatus? status,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  /// Deserializes a message from a JSON map.
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String? ?? json['messageId'] as String? ?? '',
      chatId: json['chatId'] as String? ?? '',
      senderId: json['senderId'] as String? ?? '',
      text: json['text'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      status: MessageStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => MessageStatus.sent,
      ),
    );
  }

  /// Serializes this message to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Message &&
        other.id == id &&
        other.chatId == chatId &&
        other.senderId == senderId &&
        other.text == text &&
        other.createdAt == createdAt &&
        other.status == status;
  }

  @override
  int get hashCode {
    return Object.hash(id, chatId, senderId, text, createdAt, status);
  }

  @override
  String toString() {
    return 'Message(id: $id, chatId: $chatId, senderId: $senderId, text: $text, createdAt: $createdAt, status: $status)';
  }
}
