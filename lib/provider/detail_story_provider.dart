import 'package:flutter/material.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/response/detail_story_response.dart';

class DetailStoryProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailStoryProvider({required this.apiService, required this.id});

  bool isLoading = false;
  bool hasData = false;
  bool hasError = false;
  String message = "";
  DetailStoryResponse? getDetailStoryResponse;

  Future<void> getDetailStory(String id, String token) async {
    try {
      message = "";
      isLoading = true;
      hasData = false;
      hasError = false;
      notifyListeners();
      getDetailStoryResponse = await apiService.detailStory(id, token);
      if (getDetailStoryResponse?.detailStory.id.isNotEmpty ?? false) {
        hasData = true;
      } else {
        hasData = false;
      }
      message = getDetailStoryResponse?.message ?? "Success";
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
