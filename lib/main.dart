import 'package:flutter/material.dart';
import 'package:google_map/current_location.dart';
import 'package:google_map/custom_marker_info_window.dart';
import 'package:google_map/custom_marker_screen.dart';
import 'package:google_map/gogle_place.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: CustomMarkerInfoWindowScreen(),
      ),
    );
  }
}
