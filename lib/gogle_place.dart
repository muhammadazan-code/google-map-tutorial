import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleMapSearchPlacesApi extends StatefulWidget {
  const GoogleMapSearchPlacesApi({super.key});

  @override
  State<GoogleMapSearchPlacesApi> createState() =>
      _GoogleMapSearchPlacesApiState();
}

class _GoogleMapSearchPlacesApiState extends State<GoogleMapSearchPlacesApi> {
  final _controller = TextEditingController();

  String _sessionToken = '1234567890';
  /* Session token ko use karna optional hai, lekin highly recommended hai, especially agar aap multiple
  autocomplete requests ya continuous search kar rahe hain. Agar aap sirf ek simple search kar rahe hain aur zyada 
  complex scenarios nahi hain, to aap bina session token ke bhi kaam chala sakte hain. */
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      /* addListener() method ka use aap TextEditingController ko monitor karne ke liye karte hain, taki jab bhi user text
      field mein koi change kare, aap us change ko track kar sakein aur uske according actions perform kar sakein. 
      Ye real-time input validation, search suggestions, or any dynamic behavior ke liye useful hota hai. */
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = (Random(12222322).toString());
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    // you can get this free api key from this platform
    // http://gomaps.pro
    const String keyOfPlacesApi = "AlzaSyrBHKjvmLshNaRy5u5nokxJ11t62J6A3Zz";

    try {
      String baseURL =
          'https://maps.gomaps.pro/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$keyOfPlacesApi&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print('mydata');
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Search places Api',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search your location here",
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: const Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {},
                  child: ListTile(
                    title: Text(_placeList[index]["description"]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
