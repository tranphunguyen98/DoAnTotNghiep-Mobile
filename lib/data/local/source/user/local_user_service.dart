import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totodo/data/model/user.dart';

@Injectable()
class LocalUserService {
  final String kUserKey = "user";

  Future<bool> isSignedIn() async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveUser(User user) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String userString = json.encode(user.toJson());
      await prefs.setString(kUserKey, userString);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userString = prefs.getString(kUserKey);
      if (userString != null) {
        // print('userString: $userString');
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(kUserKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
