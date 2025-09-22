class User {
  final String id;
  final String email;
  final String name;
  final String surname;
  final String role;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      role: map['role'] ?? 'student', // default role
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'surname': surname,
      'role': role,
    };
  }
}
