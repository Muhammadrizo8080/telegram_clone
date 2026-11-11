/// Represents a user in the Telegram clone application.
class User {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final DateTime? lastSeen;

  const User({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.avatarUrl,
    this.lastSeen,
  });

  /// Convenient display phone or email identifier.
  String get phoneOrEmail => phone ?? email ?? '';

  /// Creates a copy of this user with updated fields.
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    DateTime? lastSeen,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  /// Deserializes a user from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String? ?? json['uid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String?,
      phone: json['phone'] as String? ?? json['phoneOrEmail'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      lastSeen: json['lastSeen'] != null
          ? DateTime.tryParse(json['lastSeen'] as String)
          : null,
    );
  }

  /// Serializes this user to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (lastSeen != null) 'lastSeen': lastSeen!.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.avatarUrl == avatarUrl &&
        other.lastSeen == lastSeen;
  }

  @override
  int get hashCode {
    return Object.hash(id, name, email, phone, avatarUrl, lastSeen);
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, phone: $phone, email: $email, avatarUrl: $avatarUrl, lastSeen: $lastSeen)';
  }
}
