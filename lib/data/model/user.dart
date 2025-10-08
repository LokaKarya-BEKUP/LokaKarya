class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });
}

/// Dummy data user
final List<User> dummyUser = [
  User(id: "1", name: "John Doe", email: "johndoe@email.com"),
];