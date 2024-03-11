import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PlacesOriginScreen extends StatefulWidget {
  const PlacesOriginScreen({Key? key}) : super(key: key);

  @override
  _PlacesOriginScreenState createState() => _PlacesOriginScreenState();
}

class _PlacesOriginScreenState extends State<PlacesOriginScreen> {
  final _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  String _currentLocation = ''; // Variable to store current location
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
    _getCurrentLocation(); // Fetch current location on page load
  }

  Future<void> _getPlaceDescription(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      // Access the place description from the Placemark object
      Placemark place = placemarks[0];
      String placeDescription =
          '${place.locality}, ${place.administrativeArea}';

      // Use the placeDescription as needed in your application
      print(placeDescription);
      _controller.text = placeDescription;
    } catch (e) {
      print("Error getting place description: $e");
    }
  }

  void _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        _fetchLocation();
      } else {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
          _fetchLocation();
        } else {
          // Handle the scenario where the permission is denied
        }
      }
    } catch (e) {
      debugPrint("Error fetching location: ${e.toString()}");
      // Handle other exceptions here
    }
  }

  void _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation =
            '${position.latitude}, ${position.longitude}'; // Store latitude and longitude
        _controller.text =
            _currentLocation; // Pre-fill input box with current location
      });
      debugPrint(
          "Current Location: ${position.toString()}"); // Print current location

      _getPlaceDescription(position.latitude, position.longitude);
    } catch (e) {
      debugPrint("Error fetching location: ${e.toString()}");
      // Handle other exceptions here
    }
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    const String PLACES_API_KEY = "AIzaSyD0kPJKSOU4qtXrvddyAZFHeXQY2LMrz_M";

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
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
          'Where from?',
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
                hintText: "Enter Origin",
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
                  onTap: () {
                    debugPrint(
                        "Selected Item: ${_placeList[index]["description"]}");
                  },
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
