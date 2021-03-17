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

  String get authorization => "authorization $accessToken";
  User(
      {this.id,
      this.name,
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
      '_id': id,
      'displayName': name,
      'email': email,
      'password': password,
      'avatar': avatar,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, avatar: $avatar, accessToken: $accessToken, refreshToken: $refreshToken, type: $type}';
  }

  User copyWith({
    String id,
    String name,
    String email,
    String password,
    String avatar,
    String accessToken,
    String refreshToken,
    int type,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (email == null || identical(email, this.email)) &&
        (password == null || identical(password, this.password)) &&
        (avatar == null || identical(avatar, this.avatar)) &&
        (accessToken == null || identical(accessToken, this.accessToken)) &&
        (refreshToken == null || identical(refreshToken, this.refreshToken)) &&
        (type == null || identical(type, this.type))) {
      return this;
    }

    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      type: type ?? this.type,
    );
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
