import 'package:flutter/material.dart';
import 'package:google_map/custom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StyleGoogleMapScreen(),
    );
  }
}
