class Comment {
  final String id;
  final String blogId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? userName;
  final String? userAvatar;

  Comment({
    this.updatedAt,
    this.userName,
    this.userAvatar,
    required this.id,
    required this.blogId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });
}
