import 'package:totodo/data/entity/user.dart';

class UserResponse {
  final String message;
  final User user;

  UserResponse({
    this.message,
    this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['result'] as Map<String, dynamic>;
    return UserResponse(
      message: json['message'] as String,
      user: User.fromJson(payload['user'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'UserResponse{message: $message, user: $user}';
  }
}
