class User {
  final String id;
  final String email;
  final String name;
  final String bio;
  final String avatarUrl;
  final DateTime updatedAt;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.bio,
      required this.updatedAt,
      required this.avatarUrl});
}
