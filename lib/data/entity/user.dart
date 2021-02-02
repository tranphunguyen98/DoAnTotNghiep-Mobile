import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String avatar;
  final String accessToken;
  final String refreshToken;

  User({
    this.id,
    this.name = "Lê Thị Hồng",
    this.email,
    this.password,
    this.avatar,
    this.accessToken,
    this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static User userMock = User(
      id: "1",
      name: "Lê Thị Hồng",
      email: "ntranphu@gmail.com",
      avatar: "assets/user_avatar_mock.jpg",
      accessToken: "",
      refreshToken: "",
      password: "");
}
