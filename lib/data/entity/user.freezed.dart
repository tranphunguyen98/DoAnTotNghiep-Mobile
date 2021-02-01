// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {String id, String name, String email, String password, String avatar}) {
    return _User(
      id: id,
      name: name,
      email: email,
      password: password,
      avatar: avatar,
    );
  }
}

// ignore: unused_element
const $User = _$UserTearOff();

mixin _$User {
  String get id;
  String get name;
  String get email;
  String get password;
  String get avatar;

  $UserCopyWith<User> get copyWith;
}

abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String id, String name, String email, String password, String avatar});
}

class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object email = freezed,
    Object password = freezed,
    Object avatar = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      avatar: avatar == freezed ? _value.avatar : avatar as String,
    ));
  }
}

abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id, String name, String email, String password, String avatar});
}

class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object email = freezed,
    Object password = freezed,
    Object avatar = freezed,
  }) {
    return _then(_User(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      avatar: avatar == freezed ? _value.avatar : avatar as String,
    ));
  }
}

class _$_User implements _User {
  _$_User({this.id, this.name, this.email, this.password, this.avatar});

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String password;
  @override
  final String avatar;

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(avatar);

  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);
}

abstract class _User implements User {
  factory _User(
      {String id,
      String name,
      String email,
      String password,
      String avatar}) = _$_User;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get password;
  @override
  String get avatar;
  @override
  _$UserCopyWith<_User> get copyWith;
}
