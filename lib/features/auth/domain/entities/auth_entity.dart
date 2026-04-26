class AuthEntity {
  final bool success;
  final String message;
  final String? token;
  final UserEntity? user;

  AuthEntity({
    required this.success,
    required this.message,
    this.token,
    this.user,
  });
}

class UserEntity {
  final String id;
  final String email;
  final DateTime createdAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.createdAt,
  });
}
