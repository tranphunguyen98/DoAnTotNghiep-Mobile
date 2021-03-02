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
    final accessToken = payload['accessToken'] as String;
    return UserResponse(
      message: json['message'] as String,
      user: User.fromJson(payload['user'] as Map<String, dynamic>)
          .copyWith(accessToken: accessToken),
    );
  }

  @override
  String toString() {
    return 'UserResponse{message: $message, user: $user}';
  }
}
