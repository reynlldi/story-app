import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/request/all_story_request.dart';
import 'package:story_app/data/model/response/add_story_response.dart';
import 'package:image/image.dart' as img;

class UploadStoryProvider extends ChangeNotifier {
  final ApiService apiService;

  UploadStoryProvider(this.apiService);

  String? imagePath;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  XFile? imageFile;

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  bool isUploading = false;
  String message = "";
  AddStoryResponse? addStoryResponse;
  ListStory? lastUploadedStory;

  void setUploading(bool value) {
    isUploading = value;
    notifyListeners();
  }

  Future<AddStoryResponse?> addStory(
    List<int> bytes,
    String fileName,
    String description,
    String token,
    double? lat,
    double? lon,
  ) async {
    try {
      message = "";
      addStoryResponse = null;
      isUploading = true;
      notifyListeners();
      addStoryResponse = await apiService.addStory(
        bytes,
        fileName,
        description,
        token,
        lat,
        lon,
      );
      message = addStoryResponse?.message ?? "success";
      isUploading = false;
      notifyListeners();
      return addStoryResponse;
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
      return null;
    }
  }
}

Future<List<int>> compressImage(List<int> bytes) async {
  int imageLength = bytes.length;
  if (imageLength < 1000000) return bytes;

  final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
  int compressQuality = 100;
  int length = imageLength;
  List<int> newByte = [];

  do {
    compressQuality -= 10;
    newByte = img.encodeJpg(image, quality: compressQuality);
    length = newByte.length;
  } while (length > 1000000);

  return newByte;
}
