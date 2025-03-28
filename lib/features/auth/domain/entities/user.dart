class User {
  final String id;
  final String email;
  final String name;
  final String imageUrl;
  final DateTime updatedAt;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.updatedAt,
      required this.imageUrl});
}
