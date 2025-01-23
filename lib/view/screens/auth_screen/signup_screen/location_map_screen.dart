
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tractivity_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';

class LocationMapScreen extends StatefulWidget {
  const LocationMapScreen({super.key});

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {


  late GoogleMapController mapController;

  Position? _currentPosition;

  Marker? _currentLocationMarker;

  final LatLng _defaultLocation = LatLng(37.7749, -122.4194); // San Francisco

  String address = '';

  @override
  void initState() {
    super.initState();

    getUserCurrentLocation();
  }

  Future<void> getUserCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        _currentPosition = position;
        _currentLocationMarker = Marker(
          markerId: MarkerId("currentLocation"),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "Your Current Location"),
        );
      });

      mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude), 14));


    } catch (e) {
      print("Error getting location: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Current Location",
        leftIcon: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [

                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _defaultLocation,
                    zoom: 10,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: _currentLocationMarker != null
                      ? {_currentLocationMarker!}
                      : Set<Marker>(),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
