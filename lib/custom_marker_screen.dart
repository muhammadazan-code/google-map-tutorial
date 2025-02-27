/* 
1 - Create two list one contains the path of icons. And second contians latitude and longitude.
2 - Write a future method tha thas return data type Unit8list. Here Unit8list is datatype in dart that represent the list
in bytes format. At here we also pass two parametes path and size

*/

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  List<String> images = [
    'assets/bike.png',
    'assets/car.png',
    'assets/bycicle.png',
    'assets/motorcycle.png',
    'assets/airplane.png',
    'assets/taxi.png'
  ];
  Uint8List? markerImage;
  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        /*ByteData ka ek property hota hai buffer, jo underlying memory ko represent karta hai jisme data store hota hai. Aap buffer ko access karke us memory 
        block ko use kar sakte hain.Buffer basically ek ByteBuffer object hai jo memory ko manage karta hai. Agar aap
        kisi large dataset (jaise ek image ya file) ke saath kaam kar rahe hain,toh wo data internally buffer mein store hota hai.
 */
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  List<Marker> listOfMarker = [];
  final List<LatLng> longitudeAndLatitude = [
    LatLng(30.375, 69.3451),
    LatLng(20.5937, 78.9629),
    LatLng(35.8617, 104.1954),
    LatLng(32.4279, 53.6880),
    LatLng(23.6850, 90.3563),
    LatLng(33.9391, 67.7100),
  ];
  final CameraPosition initialPosition = CameraPosition(
    target: LatLng(30.375, 69.3451),
    zoom: 14.567,
  );
  loadMarker() async {
    for (var i = 0; i < longitudeAndLatitude.length; i++) {
      final Uint8List markerIcons = await getBytesFromAssets(images[i], 80);
      listOfMarker.add(Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          icon: BitmapDescriptor.bytes(markerIcons),
          infoWindow: InfoWindow(title: 'This is the title marker $i'),
          position: longitudeAndLatitude[i]));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        markers: Set.of(listOfMarker),
      ),
    );
  }
}
