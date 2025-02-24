import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CovertLatLngtoAddress extends StatefulWidget {
  const CovertLatLngtoAddress({super.key});

  @override
  State<CovertLatLngtoAddress> createState() => _CovertLatLngtoAddressState();
}

class _CovertLatLngtoAddressState extends State<CovertLatLngtoAddress> {
  final formKey = GlobalKey<FormState>();

  String staddress = '';
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  String latitude = '';
  String longitude = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value) {
                        final lowercase1 = RegExp(r'[a-z]');
                        final uppercase1 = RegExp(r'[A-Z]');
                        if (value!.contains(lowercase1)) {
                          return 'Please enter again';
                        } else if (value.contains(uppercase1)) {
                          return 'Please enter again';
                        } else {
                          return null;
                        }
                      },
                      controller: latitudeController,
                      decoration: InputDecoration(hintText: 'Enter latitude'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        final lowercase = RegExp(r'[a-z]');
                        final uppercase = RegExp(r'[A-Z]');
                        if (value!.contains(lowercase)) {
                          return 'Please enter again';
                        } else if (value.contains(uppercase)) {
                          return 'Please enter again';
                        } else {
                          return null;
                        }
                      },
                      controller: longitudeController,
                      decoration: InputDecoration(
                        hintText: 'Enter longitude',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                staddress,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 2,
                color: Colors.black54,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    double lat =
                        double.parse(latitudeController.text.toString());
                    double lng =
                        double.parse(longitudeController.text.toString());
                    List<Location> locations =
                        await locationFromAddress("Karachi Pakistan");
                    latitude = locations.last.latitude.toString();
                    longitude = locations.last.longitude.toString();
                    List<Placemark> placemarks =
                        await placemarkFromCoordinates(lat, lng);
                    staddress = placemarks.first.country.toString();
                    setState(() {});
                  } else {}
                },
                child: Container(
                  color: Colors.blueAccent,
                  height: 70,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Convert longitude/latitude to addres',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(longitude.toString() + latitude.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
