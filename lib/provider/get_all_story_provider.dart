import 'package:flutter/material.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/get_all_story_model.dart';

class GetAllStoryProvider extends ChangeNotifier {
  final ApiService apiService;
  String _token;

  GetAllStoryProvider({required this.apiService, required String token})
      : _token = token {
    getAllStory(_token);
  }

  void update(String token) {
    _token = token;
    getAllStory(_token);
  }

  bool isLoading = false;
  bool hasData = false;
  bool hasError = false;
  String message = "";
  GetAllStoryResponse? getAllStoryResponse;

  Future<void> getAllStory(
    String token,
  ) async {
    try {
      message = "";
      isLoading = true;
      hasData = false;
      hasError = false;
      notifyListeners();
      getAllStoryResponse = await apiService.getAllStory(token);
      if (getAllStoryResponse?.listStory.isNotEmpty ?? false) {
        hasData = true;
      } else {
        hasData = false;
      }
      message = getAllStoryResponse?.message ?? "Success";
      isLoading = false;
      notifyListeners();
    } catch (e) {
      hasError = true;
      isLoading = false;
      message = e.toString();
      notifyListeners();
    }
  }
}
