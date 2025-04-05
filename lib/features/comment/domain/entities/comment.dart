class Comment {
  final String id;
  final String blogId;
  final String userId;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.blogId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });
}