import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/view/ride_in_progress/ride_in_progress_screen.dart';

class CarInfoScreen extends StatefulWidget {
  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  late Map<String, dynamic> _myDestination;
  late Map<String, dynamic> _myOrigin;
  late String _discountCode;
  late String _discountPercent = '';
  late String _selectedPaymentMethod;
  late Map<String, dynamic> _riderData = {};
  late dynamic _distanceMatrixData = {};

  late String _minutes;
  late String _kilometres;

  late String _standardAmount = '0';
  late String _comfortAmount = '0';
  late String _luxuryAmount = '0';

  late String _rideAmount = '0';

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
        debugPrint("###########################***");
        debugPrint(jsonEncode(decodedResponse));
        debugPrint("###########################***");

        _distanceMatrixData = decodedResponse["rows"][0]["elements"][0];

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

        debugPrint('******###****** Luxury Amount - $_luxuryAmount');
        // Set Default Ride Amount
        _rideAmount = _standardAmount;

        setState(() {});
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // Check if Coupon Exists
  Future<Map<String, dynamic>> checkCouponExists(String couponTitle) async {
    try {
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query for the document with the given couponTitle
      QuerySnapshot querySnapshot = await firestore
          .collection('coupons')
          .where('couponTitle', isEqualTo: couponTitle)
          .get();

      // If document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the couponPercent value from the document
        int couponPercent = querySnapshot.docs.first.get('couponPercent');
        // Return true and the couponPercent value
        debugPrint('Coupon Exists');
        _discountPercent = couponPercent.toString();
        return {'exists': true, 'couponPercent': couponPercent};
      } else {
        // Return false if document does not exist
        _discountPercent = '';
        debugPrint('Coupon Does Not Exist');
        return {'exists': false};
      }
    } catch (e) {
      // Handle errors
      debugPrint('Error checking coupon existence: $e');
      // Return false in case of error
      return {'exists': false};
    }
  }

  Future<Map<String, dynamic>> getRiderDocument() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      // Get the current user
      User? user = auth.currentUser;

      if (user != null) {
        // Initialize riderData as an empty object
        Map<String, dynamic> riderData = {};

        // Get the document from the 'riders' collection where 'authID' field matches the UID of the current user
        await firestore
            .collection('riders')
            .where('authID', isEqualTo: user.uid)
            .limit(1)
            .get()
            .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            // If document found, assign the data to riderData object
            _riderData = querySnapshot.docs.first.data();
          }
        });

        return riderData;
      } else {
        // If user is not signed in, return null or handle accordingly
        return {};
      }
    } catch (e) {
      // Handle errors
      debugPrint('Error fetching rider document: $e');
      rethrow;
    }
  }

  // Create Ride Document
  Future<void> addRide(String name) async {
    try {
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new document reference with an auto-generated ID
      DocumentReference documentReference = firestore.collection('rides').doc();

      // Get the current timestamp
      DateTime now = DateTime.now();

      if (_discountPercent != '' && _discountPercent.toString().isNotEmpty) {
        debugPrint(_discountPercent);

        // Recalculate the _rideAmount
        double discountPercentAsDouble = double.parse(_discountPercent);
        double rideAmountAsDouble = double.parse(_rideAmount);
        double totalDeduction =
            ((discountPercentAsDouble / 100 * rideAmountAsDouble) / 10)
                    .round() *
                10;
        double totalClientPays = rideAmountAsDouble - totalDeduction;
        double totalBeforeDeduction = rideAmountAsDouble;

        // Run function to add document
        // Set data for the document
        debugPrint("##**## - $_distanceMatrixData");
        await documentReference.set({
          'totalDeduction': totalDeduction,
          'totalClientPays': totalClientPays,
          'totalBeforeDeduction': totalBeforeDeduction,
          'name': _riderData['name'],
          'phone': _riderData['phone'],
          'dateCreated': Timestamp.fromDate(now),
          'rideDestination': _myDestination,
          'rideOrigin': _myOrigin,
          'rideStatus': "1",
          'rideLevel': selectedElement,
          'riderID': _riderData['authID'],
          'discountSet': true,
          'couponSet': false,
          'discountPercent': discountPercentAsDouble,
          'rideTravelInformation': _distanceMatrixData,
          'driverId': '',
          'driverAuthID': '',
          'driverName': '',
          'driverPhone': '',
          'driverProfile': '',
          'driverRating': ''
        });

        // Retrieve document ID
        String docId = documentReference.id;

        // Print document ID
        debugPrint('Document added successfully with ID: $docId');

        // Get to Next Page
        Get.to(
          () => RideInProgressScreen(),
          arguments: {
            '_myDestination': _myDestination,
            '_myOrigin': _myOrigin,
            '_discountCode': _discountCode,
            '_selectedPaymentMethod': _selectedPaymentMethod,
            '_rideDocumentId': docId,
          },
        );
      } else {
        debugPrint('Discount Percent is Empty');

        double totalDeduction = 0;
        double totalClientPays = double.parse(_rideAmount);
        double totalBeforeDeduction = double.parse(_rideAmount);

        // Run function to add document
        // Set data for the document
        debugPrint("##**## - $_distanceMatrixData");
        await documentReference.set({
          'totalDeduction': totalDeduction,
          'totalClientPays': totalClientPays,
          'totalBeforeDeduction': totalBeforeDeduction,
          'name': _riderData['name'],
          'phone': _riderData['phone'],
          'dateCreated': Timestamp.fromDate(now),
          'rideDestination': _myDestination,
          'rideOrigin': _myOrigin,
          'rideStatus': "1",
          'rideLevel': selectedElement,
          'riderID': _riderData['authID'],
          'discountSet': false,
          'couponSet': false,
          'discountPercent': '',
          'rideTravelInformation': _distanceMatrixData,
        });

        // Retrieve document ID
        String docId = documentReference.id;

        debugPrint('Document added successfully');

        // Get to Next Page
        Get.to(
          () => RideInProgressScreen(),
          arguments: {
            '_myDestination': _myDestination,
            '_myOrigin': _myOrigin,
            '_discountCode': _discountCode,
            '_selectedPaymentMethod': _selectedPaymentMethod,
            '_rideDocumentId': docId,
          },
        );
      }
    } catch (e) {
      debugPrint('Error adding document: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch User Data Here
    getRiderDocument();

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

      checkCouponExists(_discountCode);

      setState(() {});
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
                        debugPrint('Selected Ride Amount - $_rideAmount');
                        debugPrint('Rider Data - $_riderData');

                        addRide(_riderData["name"]);
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
