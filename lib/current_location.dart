import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({super.key});

  @override
  State<GetCurrentLocation> createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  CameraPosition cameraPosition =
      CameraPosition(target: LatLng(33.6995, 73.0363), zoom: 14.573);
  List<Marker> listOfMarker = [
    Marker(
      markerId: MarkerId('Islamabad, Pakistan'),
      position: LatLng(33.6995, 73.0363),
    ),
    Marker(
        markerId: MarkerId('Karachi, Pakistan'),
        position: LatLng(24.8607, 67.0011)),
  ];
  final Completer<GoogleMapController> _controller = Completer();
  loadData() {
    getUserLocation().then((value) async {
      listOfMarker.add(Marker(
          markerId: MarkerId('Current Location'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
              title: 'My Current Location',
              snippet: 'Hashim Jokhio, Malir Karachi, Sindh Pakistan')));
      CameraPosition myCameraPostion = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14);
      setState(() {});
      final GoogleMapController gotoCurrentLocation = await _controller.future;
      gotoCurrentLocation
          .animateCamera(CameraUpdate.newCameraPosition(myCameraPostion));
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: cameraPosition,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController myController) {
          _controller.complete(myController);
        },
        markers: Set.of(listOfMarker),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.location_on),
      ),
    );
  }
}

Future<Position> getUserLocation() async {
  await Geolocator.requestPermission()
      .then((value) {})
      .onError((error, StackTrace) {});
  return await Geolocator.getCurrentPosition();
}
