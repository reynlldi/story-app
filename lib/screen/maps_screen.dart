import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:story_app/data/model/request/all_story_request.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/maps_provider.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};
  geo.Placemark? placemark;

  ListStory? selectedStory;
  String? selectedAddress;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapsProvider = context.read<MapsProvider>();
      final authProvider = context.read<AuthProvider>();
      mapsProvider.fetchStoriesWithLocation(authProvider.token!);
      setInitialLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.mapsScreenTitle),
        backgroundColor: primaryColor,
      ),
      body: Consumer<MapsProvider>(
        builder: (context, value, child) {
          markers.clear();
          for (var story in value.stories) {
            final storyLatLng = LatLng(story.lat!, story.lon!);
            markers.add(
              Marker(
                markerId: MarkerId(story.id),
                position: storyLatLng,
                infoWindow: InfoWindow(
                  title: story.name,
                  snippet: story.description,
                ),
                onTap: () async {
                  final storyAddress = await geo.placemarkFromCoordinates(
                      storyLatLng.latitude, storyLatLng.longitude);
                  final place = storyAddress[0];
                  final address =
                      '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                  setState(() {
                    selectedStory = story;
                    selectedAddress = address;
                  });
                },
              ),
            );
          }
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  zoom: 18,
                  target: markers.isNotEmpty
                      ? markers.first.position
                      : dicodingOffice,
                ),
                markers: markers,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });

                  if (markers.isNotEmpty) {
                    final bound = value.boundsFromLatLngList(markers.toList());
                    mapController.animateCamera(
                      CameraUpdate.newLatLngBounds(bound, 50),
                    );
                  } else {
                    mapController.animateCamera(
                      CameraUpdate.newLatLng(dicodingOffice),
                    );
                  }
                },
              ),
              Positioned(
                top: 16,
                right: 16,
                child: FloatingActionButton(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    setInitialLocation();
                  },
                  child: const Icon(Icons.my_location),
                ),
              ),
              if (selectedStory != null && selectedAddress != null)
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedStory!.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          selectedStory!.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          selectedAddress!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void defineMarker(LatLng latLng) {
    final marker = Marker(
      markerId: MarkerId(AppLocalizations.of(context)!.source),
      position: latLng,
    );
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void setInitialLocation() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final appLocalization = AppLocalizations.of(context);

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(appLocalization!.locationService),
          ),
        );
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(appLocalization!.locationPermission),
          ),
        );
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    defineMarker(latLng);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }
}
