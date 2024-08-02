import 'dart:convert';

class RegisterStoryResponse {
  final bool error;
  final String message;

  RegisterStoryResponse({
    required this.error,
    required this.message,
  });

  factory RegisterStoryResponse.fromRawJson(String str) =>
      RegisterStoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterStoryResponse.fromJson(Map<String, dynamic> json) =>
      RegisterStoryResponse(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
