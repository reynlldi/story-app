import 'package:flutter/material.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/db/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  AuthProvider({required this.apiService, required this.authRepository});

  bool isLoadingLogin = false;
  bool isLoggedIn = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  String? _token;

  String? get token => _token;

  Future<bool> login(String email, String password) async {
    isLoadingLogin = true;
    notifyListeners();

    try {
      final response = await apiService.loginStory(email, password);
      _token = response.loginResult.token;
      bool tokenSaved = await authRepository.saveToken(_token!);
      if (tokenSaved) {
        await authRepository.setLoggedIn(true);
        isLoadingLogin = false;
        isLoggedIn = true;
        notifyListeners();
        return true;
      } else {
        throw Exception("Token saving failed");
      }
    } catch (e) {
      isLoadingLogin = false;
      isLoggedIn = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    try {
      final logout = await authRepository.logout();
      if (logout) {
        await authRepository.deleteUser();
      }
      _token = null;
      isLoadingLogout = false;
      isLoggedIn = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoadingLogout = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    isLoadingRegister = true;
    notifyListeners();

    try {
      await apiService.registerStory(name, email, password);
      isLoadingRegister = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoadingRegister = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadToken() async {
    _token = await authRepository.getToken();
    notifyListeners();
  }
}
