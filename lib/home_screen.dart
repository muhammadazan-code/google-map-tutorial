import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static final CameraPosition _kgooglePlex =
      CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 14);
  List<Marker> marker = [];
  List<Marker> list = const [
    Marker(
      markerId: MarkerId('1'),
      infoWindow:
          InfoWindow(title: 'Ankara, Turkiye', snippet: 'Capital of Turkiye'),
      position: LatLng(39.9334, 32.8597),
    ),
    Marker(
      markerId: MarkerId('2'),
      infoWindow: InfoWindow(title: 'Jordan'),
      position: LatLng(30.5852, 36.2384),
    ),
    Marker(
        markerId: MarkerId('3'),
        infoWindow: InfoWindow(
          title: 'Cairo, Eqypt',
          snippet: 'Capital of Eqypt',
        ),
        position: LatLng(30.0444, 31.2357)),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(15.5974, 32.5356),
        infoWindow:
            InfoWindow(title: 'Khartoum, Sudan', snippet: 'Capital of Sudan')),
  ];
  @override
  void initState() {
    super.initState();
    marker.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: GoogleMap(
        initialCameraPosition: _kgooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {});
        },
        markers: Set<Marker>.of(marker),
        mapType: MapType.hybrid,
      ),
    );
  }
}
