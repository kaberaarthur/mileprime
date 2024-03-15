import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prime_taxi_flutter_ui_kit/view/ride_options/ride_options_screen.dart';
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
  late Map<String, dynamic> _myDestination;

  final Map<String, dynamic> _myOrigin = {};

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      _myDestination = args['_myDestination'] ?? {};
    } else {
      _myDestination = {};
    }
    debugPrint('#############################');
    debugPrint('My Destination: $_myDestination');
    debugPrint('#############################');

    _controller.addListener(() {
      _onChanged();
    });
    _getCurrentLocation(); // Fetch current location on page load
  }

  Future<String> _getPlaceDescription(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      // Access the place description from the Placemark object
      Placemark place = placemarks[0];
      String placeDescription =
          '${place.locality}, ${place.administrativeArea}';

      _controller.text = placeDescription;

      // Use the placeDescription as needed in your application
      debugPrint(placeDescription);
      return placeDescription;
    } catch (e) {
      debugPrint("Error getting place description: $e");
      return ''; // or handle the error in a suitable way
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

      String placeDescription =
          await _getPlaceDescription(position.latitude, position.longitude);

      // Populate _myOrigin here
      _updateMyOrigin(
        placeDescription,
        position.latitude,
        position.longitude,
      );
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

  void _updateMyOrigin(String placeDescription, double lat, double lng) {
    setState(() {
      _myOrigin['0'] = {
        'description': placeDescription,
        'location': {
          'lat': lat,
          'lng': lng,
        },
      };
    });
  }

  Future<Map<String, double>?> getCoordinates(
      String placeId, String placeDescription) async {
    // Replace YOUR_API_KEY with your actual API key
    const String API_KEY = "AIzaSyD0kPJKSOU4qtXrvddyAZFHeXQY2LMrz_M";

    // Construct the URL for the Geocoding API request
    String baseURL = 'https://maps.googleapis.com/maps/api/geocode/json';
    String requestURL = '$baseURL?place_id=$placeId&key=$API_KEY';

    try {
      // Send the HTTP request
      var response = await http.get(Uri.parse(requestURL));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        var data = json.decode(response.body);

        // Extract the latitude and longitude from the response
        double lat = data['results'][0]['geometry']['location']['lat'];
        double lng = data['results'][0]['geometry']['location']['lng'];

        _updateMyOrigin(placeDescription, lat, lng);
        setState(() {});

        // Return the latitude and longitude as a map
        return {
          'latitude': lat,
          'longitude': lng,
        };
      } else {
        // If the request was not successful, throw an error
        throw Exception('Failed to fetch coordinates');
      }
    } catch (e) {
      // If an error occurs during the HTTP request, print the error and return null
      print(e);
      return null;
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
                  onTap: () async {
                    debugPrint(
                        "Selected Item: ${_placeList[index]["description"]}");

                    Map<String, double>? coordinates = await getCoordinates(
                        _placeList[index]["place_id"],
                        _placeList[index]["description"]);
                    if (coordinates != null) {
                      debugPrint("Latitude: ${coordinates['latitude']}");
                      debugPrint("Longitude: ${coordinates['longitude']}");

                      debugPrint(json.encode(_myOrigin));

                      // Populate _myOrigin here
                      _updateMyOrigin(
                        _placeList[index]["description"],
                        coordinates['latitude'] as double,
                        coordinates['longitude'] as double,
                      );
                    } else {
                      debugPrint("Failed to fetch coordinates");
                    }
                  },
                  child: ListTile(
                    title: Text(_placeList[index]["description"]),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _myDestination.isEmpty
                  ? null // Disable button if _selectedDestination is empty
                  : () {
                      debugPrint('################################');
                      debugPrint('My Origin: $_myOrigin');
                      debugPrint('################################');

                      Get.to(
                        () => RideOptionsScreen(),
                        arguments: {
                          '_myDestination': _myDestination,
                          '_myOrigin': _myOrigin,
                        },
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: _myOrigin.isEmpty
                    ? Colors
                        .grey // Grey background if _selectedDestination is empty
                    : Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: Text(
                'Proceed',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
