import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/request/all_story_request.dart';

class MapsProvider extends ChangeNotifier {
  final ApiService apiService;
  MapsProvider({required this.apiService});

  List<ListStory> _stories = [];
  List<ListStory> get stories => _stories;
  String message = "";

  Future<void> fetchStoriesWithLocation(String token) async {
    try {
      final response = await apiService.getAllStory(1, 50, token, location: 1);
      _stories = response.listStory;
      notifyListeners();
    } catch (e) {
      message = e.toString();
      notifyListeners();
    }
  }

  LatLngBounds boundsFromLatLngList(List<Marker> markers) {
    if (markers.length == 1) {
      LatLng position = markers.first.position;
      return LatLngBounds(
        southwest:
            LatLng(position.latitude - 0.001, position.longitude - 0.001),
        northeast:
            LatLng(position.latitude + 0.001, position.longitude + 0.001),
      );
    }

    double? x0, x1, y0, y1;
    for (Marker marker in markers) {
      LatLng latLng = marker.position;
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }
}
