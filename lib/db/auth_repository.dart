import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String stateKey = "isLoggedIn";
  final String tokenKey = "token";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(stateKey) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setBool(stateKey, value);
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(stateKey, false);
  }

  Future<bool> saveToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    bool result = await preferences.setString(tokenKey, token);
    return result;
  }

  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString(tokenKey);
    return token;
  }

  Future<void> deleteUser() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(tokenKey);
    setLoggedIn(false);
  }
}
