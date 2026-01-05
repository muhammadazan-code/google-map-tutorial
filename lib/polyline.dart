import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  CameraPosition kgoogleplex =
      CameraPosition(target: LatLng(33.6995, 73.0363), zoom: 14.5);
  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.6995, 73.0363),
    ),
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(31.4504, 73.1350),
    ),
  };
  final Set<Polyline> _polyline = {};
  List<LatLng> _latlng = [
    LatLng(33.6995, 73.0363),
    LatLng(31.4504, 73.1350),
  ];

  Completer<GoogleMapController> myController = Completer();
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _latlng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latlng[i],
          infoWindow:
              InfoWindow(title: 'Realy cool place', snippet: '5 Star Hotel'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {});
      _polyline.add(Polyline(polylineId: PolylineId('1'), points: _latlng));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polyline'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
          child: GoogleMap(
        markers: _markers,
        initialCameraPosition: kgoogleplex,
        onMapCreated: (GoogleMapController controller) {
          myController.complete(controller);
        },
        polylines: _polyline,
      )),
    );
  }
}
