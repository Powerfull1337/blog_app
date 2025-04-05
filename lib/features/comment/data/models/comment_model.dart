import 'package:blog_app/features/comment/domain/entities/comment.dart';


class CommentModel extends Comment {
  final DateTime? updatedAt;
  final String? userName;
  final String? userAvatar;

  CommentModel({
    required super.id,
    required super.blogId,
    required super.userId,
    required super.content,
    required super.createdAt,
    this.updatedAt,
    this.userName,
    this.userAvatar,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profiles'] ?? {};

    return CommentModel(
      id: json['id'],
      blogId: json['blog_id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      userName: profile['name'],
      userAvatar: profile['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'blog_id': blogId,
      'user_id': userId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
