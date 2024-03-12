import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:prime_taxi_flutter_ui_kit/view/places_origin/places_origin_screen.dart';

class PlacesDestinationScreen extends StatefulWidget {
  const PlacesDestinationScreen({Key? key}) : super(key: key);

  @override
  _PlacesDestinationScreenState createState() =>
      _PlacesDestinationScreenState();
}

class _PlacesDestinationScreenState extends State<PlacesDestinationScreen> {
  final _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  final String _selectedDestination = '';

  final Map<String, dynamic> _myDestination = {};

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
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
          _placeList = data['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }

  void _updateMyDestination(String placeDescription, double lat, double lng) {
    setState(() {
      _myDestination['0'] = {
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

        _updateMyDestination(placeDescription, lat, lng);

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
          'Where to?',
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
                hintText: "Enter Destination",
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
                    debugPrint("Latitude: ${_placeList[index]}");

                    Map<String, double>? coordinates = await getCoordinates(
                        _placeList[index]["place_id"],
                        _placeList[index]["description"]);
                    if (coordinates != null) {
                      debugPrint("Latitude: ${coordinates['latitude']}");
                      debugPrint("Longitude: ${coordinates['longitude']}");

                      debugPrint(json.encode(_myDestination));
                    } else {
                      debugPrint("Failed to fetch coordinates");
                    }
                  },
                  child: ListTile(
                    title: Text(
                      _placeList[index]["description"],
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
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
              onPressed: _selectedDestination.isEmpty
                  ? null // Disable button if _selectedDestination is empty
                  : () {
                      Get.to(() => PlacesOriginScreen());
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: _myDestination.isEmpty
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
