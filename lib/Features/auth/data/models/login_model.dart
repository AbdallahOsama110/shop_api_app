import 'user_model.dart';

class AuthModel {
  final bool status;
  final String? message;
  final UserModel? data;

  AuthModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json['status'],
        message: json['message'],
        data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
      );
}
