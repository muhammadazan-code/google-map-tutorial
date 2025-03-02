// ignore_for_file: deprecated_member_use, null_argument_to_non_null_type

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({super.key});

  @override
  State<StyleGoogleMapScreen> createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  final Completer<GoogleMapController> _newController = Completer();
  final Set<Marker> _marker = {
    Marker(
      markerId: MarkerId('Area'),
      position: LatLng(24.8607, 67.0011),
      draggable: true,
    ),
  };
  String themeOfGoogleMap = '';
  CameraPosition firstPosition =
      CameraPosition(target: LatLng(24.8607, 67.0011), zoom: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Map theme'),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    _newController.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('maptheme/silver_theme.json')
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  });
                },
                child: Text('Silver'),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    _newController.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('maptheme/retro_theme.json')
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  });
                },
                child: Text('Retro'),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    _newController.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('maptheme/night_theme.json')
                          .then((string) {
                        value.setMapStyle(string);
                      });
                    });
                  });
                },
                child: Text('Night'),
              ),
            ],
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: firstPosition,
        markers: _marker,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(themeOfGoogleMap);
          _newController.complete(controller);
          setState(() {});
        },
      ),
    );
  }
}
