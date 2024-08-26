import 'package:flutter/material.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/request/all_story_request.dart';
import 'package:story_app/data/model/response/all_story_response.dart';

class GetAllStoryProvider extends ChangeNotifier {
  final ApiService apiService;
  String _token;

  GetAllStoryProvider({required this.apiService, required String token})
      : _token = token {
    if (_token.isNotEmpty) {
      loadInitialStories(_token);
    }
  }

  void update(String token) {
    _token = token;
    if (_token.isNotEmpty) {
      loadInitialStories(_token);
    }
  }

  bool isLoading = false;
  bool hasData = false;
  bool hasError = false;
  String message = "";
  AllStoryResponse? getAllStoryResponse;
  List<ListStory> allStories = [];
  int? pageItems = 1;
  final int sizeItem = 10;

  Future<void> getAllStory(String token) async {
    if (isLoading || pageItems == null) return;

    try {
      isLoading = true;
      notifyListeners();

      final result = await apiService.getAllStory(pageItems!, sizeItem, token);
      if (result.listStory.isNotEmpty) {
        allStories.addAll(result.listStory);
        hasData = true;
        pageItems = result.listStory.length < sizeItem ? null : pageItems! + 1;
      }

      message = "Success";
      isLoading = false;
      notifyListeners();
    } catch (e) {
      hasError = true;
      isLoading = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadInitialStories(String token) async {
    if (allStories.isEmpty && token.isNotEmpty) {
      await getAllStory(token);
    }
  }

  Future<void> refreshStories(String token) async {
    pageItems = 1;
    allStories.clear();
    await getAllStory(token);
  }
}
