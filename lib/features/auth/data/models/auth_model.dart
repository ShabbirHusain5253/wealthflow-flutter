import 'package:wealthflow/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    required super.success,
    required super.message,
    super.token,
    super.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    return AuthModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: data?['token'],
      user: data?['user'] != null 
          ? UserModel.fromJson(data!['user'] as Map<String, dynamic>) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (token != null) 'data': {
        'token': token,
        'user': (user as UserModel?)?.toJson(),
      },
    };
  }
}

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
