import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageCustomMarker extends StatefulWidget {
  const NetworkImageCustomMarker({super.key});

  @override
  State<NetworkImageCustomMarker> createState() =>
      _NetworkImageCustomMarkerState();
}

class _NetworkImageCustomMarkerState extends State<NetworkImageCustomMarker> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition firstCameraPostition =
      CameraPosition(target: LatLng(30.1864, 71.4886), zoom: 14);
  List<Marker> listOfMarker = [];
  List listOfLatLng = [
    LatLng(24.8607, 67.0011),
    LatLng(33.6995, 73.0363),
    LatLng(31.5204, 74.3587),
    LatLng(31.4504, 73.1350),
    LatLng(33.5651, 73.0169)
  ];
  loadData() async {
    for (var i = 0; i < listOfLatLng.length; i++) {
      Uint8List? images = await loadNetworkImage(
          'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg');
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        images.buffer.asUint8List(),
        targetHeight: 50,
        targetWidth: 50,
      );
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? dataInByte = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List resizedImage = dataInByte!.buffer.asUint8List();

      listOfMarker.add(
        Marker(
            markerId: MarkerId(
              i.toString(),
            ),
            icon: BitmapDescriptor.bytes(resizedImage),
            position: listOfLatLng[i],
            infoWindow: InfoWindow(title: 'Title of marker ${i.toString()}')),
      );
      setState(() {});
    }
  }

  Future<Uint8List> loadNetworkImage(String path) async {
    final completed = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
          ImageStreamListener((info, _) => completed.complete(info)),
        );
    final imageInfo = await completed.future;
    final byteCode =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteCode!.buffer.asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: GoogleMap(
        markers: Set.of(listOfMarker),
        initialCameraPosition: firstCameraPostition,
      ),
    );
  }
}
