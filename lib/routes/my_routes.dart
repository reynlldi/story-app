import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/screen/detail_screen.dart';
import 'package:story_app/screen/home_screen.dart';
import 'package:story_app/screen/location_picker_screen.dart';
import 'package:story_app/screen/login_screen.dart';
import 'package:story_app/screen/maps_screen.dart';
import 'package:story_app/screen/register_screen.dart';
import 'package:story_app/screen/setting_screen.dart';
import 'package:story_app/screen/splash_screen.dart';
import 'package:story_app/screen/upload_story_screen.dart';

class MyRoutes extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;
  final AuthProvider authProvider;

  MyRoutes(this.authRepository, this.authProvider)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
    authProvider.addListener(_onAuthStateChanged);
  }

  _init() async {
    await Future.delayed(const Duration(seconds: 2));
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  _onAuthStateChanged() {
    isLoggedIn = authProvider.isLoggedIn;
    notifyListeners();
  }

  @override
  void dispose() {
    authProvider.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool isSetting = false;
  String? selectedStory;
  bool isUploadStory = false;
  bool isMaps = false;
  bool isLocationPicker = false;
  LatLng? initialLocation;
  Function(LatLng, String)? onLocationSelected;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      key: _navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        selectedStory = null;
        isSetting = false;
        isUploadStory = false;
        isMaps = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {
    // Handle new route paths
  }

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey("SplashScreen"),
          child: SplashScreen(),
        )
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("HomeScreen"),
          child: HomeScreen(
            onSetting: () {
              isSetting = true;
              notifyListeners();
            },
            onTapped: (String id) {
              selectedStory = id;
              notifyListeners();
            },
            onUploadStory: () {
              isUploadStory = true;
              notifyListeners();
            },
            onMaps: () {
              isMaps = true;
              notifyListeners();
            },
          ),
        ),
        if (isSetting)
          MaterialPage(
            key: const ValueKey("SettingScreen"),
            child: SettingScreen(
              onLogout: () {
                isSetting = false;
                notifyListeners();
              },
            ),
          ),
        if (selectedStory != null)
          MaterialPage(
            key: ValueKey(selectedStory),
            child: DetailScreen(id: selectedStory!),
          ),
        if (isUploadStory)
          MaterialPage(
            key: const ValueKey("UploadStoryScreen"),
            child: UploadStoryScreen(
              onUploadComplete: () {
                isUploadStory = false;
                notifyListeners();
              },
              onSelectLocation:
                  (LatLng? location, Function(LatLng, String) callback) {
                isLocationPicker = true;
                initialLocation = location;
                onLocationSelected = callback;
                notifyListeners();
              },
            ),
          ),
        if (isLocationPicker)
          MaterialPage(
            key: const ValueKey("LocationPickerScreen"),
            child: LocationPickerScreen(
              initialLocation: initialLocation,
              onLocationSelected: (LatLng location, String address) {
                isLocationPicker = false;
                onLocationSelected?.call(location, address);
                notifyListeners();
              },
            ),
          ),
        if (isMaps)
          const MaterialPage(
            key: ValueKey("MapsScreen"),
            child: MapsScreen(),
          )
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginScreen"),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterScreen"),
            child: RegisterScreen(
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          )
      ];
}
