class User {
  static const int kTypeEmail = 0;
  static const int kTypeFacebook = 1;
  static const int kTypeGoogle = 2;

  final String id;
  final String name;
  final String email;
  final String password;
  final String avatar;
  final String accessToken;
  final String refreshToken;
  final int type;

  User(
      {this.id,
      this.name = "Lê Thị Hồng",
      this.email,
      this.password,
      this.avatar,
      this.accessToken,
      this.refreshToken,
      this.type = kTypeEmail});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['displayName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      avatar: map['avatar'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      type: map['type'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': this.id,
      'displayName': this.name,
      'email': this.email,
      'password': this.password,
      'avatar': this.avatar,
      'accessToken': this.accessToken,
      'refreshToken': this.refreshToken,
      'type': this.type,
    } as Map<String, dynamic>;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, avatar: $avatar, accessToken: $accessToken, refreshToken: $refreshToken, type: $type}';
  }

  static User userMock = User(
      id: "1",
      name: "Lê Thị Hồng",
      email: "ntranphu@gmail.com",
      avatar: "assets/user_avatar_mock.jpg",
      accessToken: "",
      refreshToken: "",
      password: "");
}
