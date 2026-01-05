import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  Completer<GoogleMapController> controller1 = Completer();
  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(33.4564, 74.825), zoom: 14);
  final List<Marker> marker = [];
  final listoflocation = [
    Marker(markerId: MarkerId('1'), position: LatLng(33.4564, 74.825)),
  ];
  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, StackTrace) {
      print("Error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.hybrid,
        onMapCreated: (GoogleMapController controller) async {
          controller1.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserLocation().then(
            (value) async {
              marker.add(Marker(
                  markerId: MarkerId('10'),
                  infoWindow: InfoWindow(
                    title: 'My current Location',
                  ),
                  position: LatLng(value.latitude, value.longitude)));
              final CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: 14,
              );
              GoogleMapController controller = await controller1.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {});
            },
          );
        },
        child: Icon(
          Icons.local_activity,
        ),
      ),
    );
  }
}
