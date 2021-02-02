import 'package:totodo/data/entity/user.dart';

class UserResponse {
  final String message;
  final User user;
  final String token;

  UserResponse({
    this.message,
    this.user,
    this.token,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>;
    return UserResponse(
        message: json['message'] as String,
        user: User.fromJson(payload['user'] as Map<String, dynamic>),
        token: json['accessToken'] as String);
  }
}
