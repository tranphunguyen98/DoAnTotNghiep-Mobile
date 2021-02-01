import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  factory User({
    String id,
    String name,
    String email,
    String password,
    String avatar,
  }) = _User;

  static User userMock = User(
      id: "1",
      name: "Lê Thị Hồng",
      email: "ntranphu@gmail.com",
      avatar: "assets/user_avatar_mock.jpg");
}
