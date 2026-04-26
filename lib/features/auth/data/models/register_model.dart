import 'package:wealthflow/features/auth/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  RegisterModel({required super.email, required super.password});

  factory RegisterModel.fromEntity(RegisterEntity entity) {
    return RegisterModel(email: entity.email, password: entity.password);
  }

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
