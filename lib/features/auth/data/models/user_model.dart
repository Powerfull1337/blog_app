import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.avatarUrl,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      avatarUrl: map['avatar_url'] ?? '',
      updatedAt:
          DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? updatedAt,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
