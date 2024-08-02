import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:story_app/data/model/add_story_model.dart';
import 'package:story_app/data/model/detail_story_model.dart';
import 'package:story_app/data/model/get_all_story_model.dart';
import 'package:story_app/data/model/login_story_model.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/data/model/register_story_model.dart';

class ApiService {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";

  Future<LoginStoryResponse> loginStory(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "email": email,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return LoginStoryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something Wrong: Login Failed");
    }
  }

  Future<RegisterStoryResponse> registerStory(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/register"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "name": name,
          "email": email,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 201) {
      return RegisterStoryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something Wrong: Register Failed");
    }
  }

  Future<GetAllStoryResponse> getAllStory(
    String token,
  ) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stories"),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return GetAllStoryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something Wrong: List Story Failed");
    }
  }

  Future<DetailStoryResponse> detailStory(
    String id,
    String token,
  ) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/stories/$id"),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return DetailStoryResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something Wrong: Detail Story Failed");
    }
  }

  Future<AddStoryResponse> addStory(
    List<int> bytes,
    String fileName,
    String description,
    String token,
  ) async {
    final uri = Uri.parse("$_baseUrl/stories");
    var request = http.MultipartRequest("POST", uri);

    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      bytes,
      filename: fileName,
    );

    final Map<String, String> fields = {
      "description": description,
    };

    final Map<String, String> headers = {
      "content-type": "multipart/form-data",
      "Authorization": "Bearer $token",
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      return AddStoryResponse.fromJson(json.decode(responseData));
    } else {
      throw Exception("Something Wrong: Add Story Failed");
    }
  }
}
