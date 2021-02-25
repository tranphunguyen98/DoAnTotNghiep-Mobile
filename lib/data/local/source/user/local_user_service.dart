import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totodo/data/entity/user.dart';

@Injectable()
class LocalUserService {
  final String USER_KEY = "user";

  Future<bool> isSignedIn() async {
    try {
      final user = await getUser();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveUser(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String userString = json.encode(user.toJson());
      await prefs.setString(USER_KEY, userString);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userString = prefs.getString(USER_KEY);
      if (userString != null) {
        return User.fromJson(json.decode(userString) as Map<String, dynamic>);
      } else {
        return throw Exception("Can't get user");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> clearUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(USER_KEY);
      return true;
    } catch (e) {
      return false;
    }
  }
}
