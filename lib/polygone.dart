import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition myCameraPosition =
      CameraPosition(target: LatLng(33.6995, 73.0363), zoom: 14);
  final Set<Marker> marker = {
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.6995, 73.0363),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(30.1864, 71.4886),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(30.6682, 73.1114),
    ),
    Marker(
      markerId: MarkerId('4'),
      position: LatLng(31.4504, 73.1350),
    ),
  };
  Set<Polygon> myPolygon = HashSet<Polygon>();
  List<LatLng> points = [
    LatLng(33.6995, 73.0363),
    LatLng(30.1864, 71.4886),
    LatLng(30.6682, 73.1114),
    LatLng(31.4504, 73.1350),
    LatLng(33.6995, 73.0363)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myPolygon.add(Polygon(
      polygonId: PolygonId('1'),
      points: points,
      fillColor: Colors.transparent,
      geodesic: true,
      strokeColor: Colors.red,
      strokeWidth: 4,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(
          child: Text('Polygone'),
        ),
      ),
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: myCameraPosition,
          polygons: myPolygon,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: marker,
        ),
      ),
    );
  }
}
