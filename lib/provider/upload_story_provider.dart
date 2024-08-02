import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/add_story_model.dart';
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

  void setUploading(bool value) {
    isUploading = value;
    notifyListeners();
  }

  Future<void> addStory(
    List<int> bytes,
    String fileName,
    String description,
    String token,
  ) async {
    try {
      message = "";
      addStoryResponse = null;
      isUploading = true;
      notifyListeners();
      addStoryResponse =
          await apiService.addStory(bytes, fileName, description, token);
      message = addStoryResponse?.message ?? "success";
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
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
