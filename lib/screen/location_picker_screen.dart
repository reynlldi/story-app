import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:story_app/common/localization.dart';
import 'package:story_app/common/styles.dart';

class LocationPickerScreen extends StatefulWidget {
  final LatLng? initialLocation;
  final Function(LatLng, String) onLocationSelected;

  const LocationPickerScreen({
    super.key,
    this.initialLocation,
    required this.onLocationSelected,
  });

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  GoogleMapController? mapController;
  LatLng? _selectedLocation;
  String? _selectedAddress;
  Set<Marker> markers = {};

  String? _selectLocationText;
  String? _confirmLocationText;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectLocationText = AppLocalizations.of(context)!.selectLocation;
    _confirmLocationText = AppLocalizations.of(context)!.confirmLocation;
  }

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation;
    if (_selectedLocation != null) {
      _addMarker(_selectedLocation!);
    }
    setInitialLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.selectLocation),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation ?? dicodingOffice,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            onTap: _onMapTapped,
            markers: markers,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
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
          if (_selectedLocation != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                ),
                child: Text(
                  _confirmLocationText ?? 'Confirm Location',
                  style: const TextStyle(color: primaryColor),
                ),
                onPressed: () {
                  widget.onLocationSelected(
                      _selectedLocation!, _selectedAddress ?? '');
                },
              ),
            ),
        ],
      ),
    );
  }

  void _onMapTapped(LatLng location) async {
    setState(() {
      _selectedLocation = location;
      _addMarker(location);
    });

    final addresses = await geo.placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );

    if (addresses.isNotEmpty) {
      final address = addresses.first;
      _selectedAddress =
          '${address.street}, ${address.locality}, ${address.country}';
      setState(() {});
    }
  }

  void _addMarker(LatLng location) {
    final marker = Marker(
      markerId: MarkerId(location.toString()),
      position: location,
      infoWindow: InfoWindow(
        title: _selectLocationText ?? 'Select Location',
        snippet: _selectedAddress ?? '',
      ),
    );
    setState(() {
      markers = {marker};
    });
  }

  void setInitialLocation() async {
    final Location location = Location();
    late LocationData locationData;

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    _addMarker(latLng);

    mapController?.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }
}
