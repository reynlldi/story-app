import 'dart:convert';

class LoginStoryResponse {
  final bool error;
  final String message;
  final LoginResult loginResult;

  LoginStoryResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginStoryResponse.fromRawJson(String str) =>
      LoginStoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginStoryResponse.fromJson(Map<String, dynamic> json) =>
      LoginStoryResponse(
        error: json["error"],
        message: json["message"],
        loginResult: LoginResult.fromJson(json["loginResult"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "loginResult": loginResult.toJson(),
      };
}

class LoginResult {
  final String userId;
  final String name;
  final String token;

  LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResult.fromRawJson(String str) =>
      LoginResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "token": token,
      };
}
