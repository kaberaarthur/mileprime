import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart'; // Import your icon path

class CarInfoScreen extends StatefulWidget {
  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  late Map<String, dynamic> _myDestination;
  late Map<String, dynamic> _myOrigin;
  late String _discountCode;
  late String _selectedPaymentMethod;

  late String _minutes;
  late String _kilometres;

  late String _standardAmount;
  late String _comfortAmount;
  late String _luxuryAmount;

  late String _rideAmount;

  String selectedElement = 'Standard';

  void selectElement(String element) {
    setState(() {
      selectedElement = element;
    });
  }

  Future<void> fetchDistanceMatrix(String origin, String destination) async {
    final apiKey = 'AIzaSyD0kPJKSOU4qtXrvddyAZFHeXQY2LMrz_M';
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$origin&destinations=$destination&key=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        // Convert the decoded response to a JSON string before printing
        debugPrint("###########################");
        debugPrint(jsonEncode(decodedResponse));
        debugPrint("###########################");

        int distanceValue =
            decodedResponse["rows"][0]["elements"][0]["distance"]["value"];
        _kilometres = (distanceValue / 1000).toString();

        int durationValue =
            decodedResponse["rows"][0]["elements"][0]["duration"]["value"];
        _minutes = (durationValue / 60).toString();

        // Calculate Standard Amount
        double distanceTaken = distanceValue / 1000;
        double durationTaken = durationValue / 60;

        _standardAmount =
            ((((0.7 * 33 * distanceTaken) + (0.3 * 38 * durationTaken)) / 10)
                        .round() *
                    10)
                .toString();
        _comfortAmount =
            (((((0.7 * 33 * distanceTaken) + (0.3 * 38 * durationTaken)) *
                                1.3) /
                            10)
                        .round() *
                    10)
                .toString();
        _luxuryAmount =
            (((((0.7 * 33 * distanceTaken) + (0.3 * 38 * durationTaken)) *
                                1.65) /
                            10)
                        .round() *
                    10)
                .toString();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Call your function here or wherever appropriate in your widget lifecycle
    /* fetchDistanceMatrix(
        '-1.1177451,37.00892689999999', '-1.2195761,36.88842440000001');*/

    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      _myDestination = args['_myDestination'] ?? {};
      _myOrigin = args['_myOrigin'] ?? {};
      _discountCode = args['_discountCode'] ?? '';
      _selectedPaymentMethod = args['_selectedPaymentMethod'] ?? '';

      debugPrint('Selected Payment Method: $_selectedPaymentMethod');
      debugPrint(
          'My Destination Latitude: ${_myDestination['0']!['location']['lat']}');

      // Fetch Distance and Time
      fetchDistanceMatrix(
          '${_myOrigin['0']!['location']['lat'] as double},${_myOrigin['0']!['location']['lng'] as double}',
          '${_myDestination['0']!['location']['lat'] as double},${_myDestination['0']!['location']['lng'] as double}');
    } else {
      _myDestination = {};
      _myOrigin = {};
      _selectedPaymentMethod = '';
      _discountCode = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White background
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Black back button
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Select Car', // Title text
          style: TextStyle(
            color: Colors.black, // Black title text
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  selectElement('Standard');
                  _rideAmount = _standardAmount;
                },
                child: Container(
                  width: double.infinity,
                  height: 120, // Adjust the height as needed
                  decoration: BoxDecoration(
                    color: selectedElement == 'Standard'
                        ? Color.fromARGB(255, 255, 200, 47)
                        : Colors.white, // Conditional background color
                    border: Border.all(
                      color: selectedElement == 'Standard'
                          ? Color.fromARGB(255, 255, 200, 47)
                          : Colors.black, // Conditional border color
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                AppIcons.mileCar, // Use your imported icon here
                                width: 60.0,
                                height: 60.0,
                                color: Colors.black, // Black icon
                              ),
                              Text(
                                '5 min',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black, // Black text
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          // Vertical line separator
                          thickness: 1,
                          color: const Color.fromARGB(255, 46, 46, 46),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center text vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Standard',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Black text
                                ),
                              ),
                              Text(
                                'Kes. $_standardAmount',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black, // Black text
                                ),
                              ),
                              // Add more text widgets here if needed
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Spacer between the elements
              GestureDetector(
                onTap: () {
                  selectElement('Comfort');
                  _rideAmount = _comfortAmount;
                },
                child: Container(
                  width: double.infinity,
                  height: 120, // Adjust the height as needed
                  decoration: BoxDecoration(
                    color: selectedElement == 'Comfort'
                        ? Color.fromARGB(255, 255, 200, 47)
                        : Colors.white, // Conditional background color
                    border: Border.all(
                      color: selectedElement == 'Comfort'
                          ? Color.fromARGB(255, 255, 200, 47)
                          : Colors.black, // Conditional border color
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                AppIcons.mileSuv, // Use your imported icon here
                                width: 60.0,
                                height: 60.0,
                                color: Colors.black, // Black icon
                              ),
                              Text(
                                '10 min',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black, // Black text
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          // Vertical line separator
                          thickness: 1,
                          color: const Color.fromARGB(255, 46, 46, 46),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center text vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Comfort',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Black text
                                ),
                              ),
                              Text(
                                'Kes. $_comfortAmount',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black, // Black text
                                ),
                              ),
                              // Add more text widgets here if needed
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Spacer between the elements
              GestureDetector(
                onTap: () {
                  selectElement('Luxury');
                  _rideAmount = _luxuryAmount;
                },
                child: Container(
                  width: double.infinity,
                  height: 120, // Adjust the height as needed
                  decoration: BoxDecoration(
                    color: selectedElement == 'Luxury'
                        ? Color.fromARGB(255, 255, 200, 47)
                        : Colors.white, // Conditional background color
                    border: Border.all(
                      color: selectedElement == 'Luxury'
                          ? Color.fromARGB(255, 255, 200, 47)
                          : Colors.black, // Conditional border color
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                AppIcons.mileLux, // Use your imported icon here
                                width: 60.0,
                                height: 60.0,
                                color: Colors.black, // Black icon
                              ),
                              Text(
                                '10 min',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black, // Black text
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          // Vertical line separator
                          thickness: 1,
                          color: const Color.fromARGB(255, 46, 46, 46),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center text vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Luxury',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Black text
                                ),
                              ),
                              Text(
                                'Kes. $_luxuryAmount',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black, // Black text
                                ),
                              ),
                              // Add more text widgets here if needed
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Spacer between the elements
              Expanded(
                // Added expanded to allow button to occupy remaining space
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity, // Occupy screen's width
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Proceed button action
                        debugPrint("Proceed Button Pressed");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Black background
                        foregroundColor: Colors.white, // White text
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(4.0), // Rounded corners
                        ),
                      ),
                      child: Text('Proceed'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
