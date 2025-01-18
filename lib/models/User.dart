class User {
  String id;
  String name;
  String password;
  String email;
  String profileImage;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    this.profileImage = '',
  });
}