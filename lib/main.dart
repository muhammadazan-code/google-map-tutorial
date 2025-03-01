import 'package:flutter/material.dart';
import 'package:google_map/_network_mage_custom_marker.dart';
import 'package:google_map/polygone.dart';
import 'package:google_map/polyline.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: NetworkImageCustomMarker(),
      ),
    );
  }
}
