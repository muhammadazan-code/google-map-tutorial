import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindowScreen extends StatefulWidget {
  const CustomMarkerInfoWindowScreen({super.key});

  @override
  State<CustomMarkerInfoWindowScreen> createState() =>
      _CustomMarkerInfoWindowScreenState();
}

class _CustomMarkerInfoWindowScreenState
    extends State<CustomMarkerInfoWindowScreen> {
  CustomInfoWindowController myInfoWindowController =
      CustomInfoWindowController();
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = <LatLng>[
    LatLng(30.375, 69.3451),
    LatLng(20.5937, 78.9629),
    LatLng(35.8617, 104.1954),
    LatLng(32.4279, 53.6880),
    LatLng(23.6850, 90.3563),
    LatLng(33.9391, 67.7100),
  ];
  loadingData() {
    for (var i = 0; i < _latlng.length; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(
              i.toString(),
            ),
            icon: BitmapDescriptor.defaultMarker,
            position: _latlng[i],
            onTap: () {
              myInfoWindowController.addInfoWindow!(
                Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.high,
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJP2555PwNKqrnQnRDMHYZa2xYSKB8Oi3wZQ&s'))),
                        ),
                      ],
                    )),
                _latlng[i],
              );
            }),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Center(
          child: Text('Custom Info Window Example'),
        ),
      ),
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(38.9637, 35.2433), zoom: 14),
          markers: Set.of(_markers),
          onTap: (position) {
            myInfoWindowController.hideInfoWindow!();
            setState(() {});
          },
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              myInfoWindowController.googleMapController = controller;
            });
          },
          onCameraMove: (position) {
            myInfoWindowController.onCameraMove!();
          },
        ),
        CustomInfoWindow(
          controller: myInfoWindowController,
          height: 300,
          width: 300,
          offset: 35,
        )
      ]),
    );
  }
}
