// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prime_taxi_flutter_ui_kit/view/car_info/car_info_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/messages/messages_screen.dart';
import 'package:prime_taxi_flutter_ui_kit/view/rating_screen/rating_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:prime_taxi_flutter_ui_kit/config/font_family.dart';

import 'dart:async';

class RideInProgressScreen extends StatefulWidget {
  const RideInProgressScreen({Key? key}) : super(key: key);

  @override
  State<RideInProgressScreen> createState() => _RideInProgressScreenState();
}

class _RideInProgressScreenState extends State<RideInProgressScreen> {
  late Map<String, dynamic> _myDestination;
  late Map<String, dynamic> _myOrigin;
  late final Set<Polyline> _polyline = {};
  late final Set<Marker> _markers = {}; // Add this line to hold markers

  late String _discountCode = ''; // Variable for discount code
  late String _rideDocumentId = '';
  late Map<String, dynamic> _newRideData = {};
  late String _currentRideStatus = '1';
  late String _selectedPaymentMethod =
      'Cash'; // Variable for selected payment method
  final TextEditingController _discountController = TextEditingController();

  late bool rideStatusFour = false;

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      _myDestination = args['_myDestination'] ?? {};
      _myOrigin = args['_myOrigin'] ?? {};
      _rideDocumentId = args['_rideDocumentId'] ?? '';
      _fetchRoute();
    } else {
      _myDestination = {};
      _myOrigin = {};
      _rideDocumentId = '';
    }
    debugPrint('#############################');
    debugPrint('My Destination: $_myDestination');
    debugPrint('My Origin: $_myOrigin');
    debugPrint('#############################');
  }

  void checkRideStatus(String currentRideStatus) {
    if (currentRideStatus == '4') {
      debugPrint('Ride status is equal to 4');
    } else {
      debugPrint('Ride status is not equal to 4');
    }
  }

  // Monitor Ride Status
  void monitorRideStatus(String _rideDocumentId) {
    StreamSubscription<DocumentSnapshot>? subscription;
    subscription = FirebaseFirestore.instance
        .collection('rides')
        .doc(_rideDocumentId)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        var rideStatus = snapshot.data()
            as Map<String, dynamic>?; // Cast to Map<String, dynamic>
        if (rideStatus != null) {
          var rideStatusValue =
              rideStatus['rideStatus']; // Now, you can safely use []

          checkRideStatus(rideStatusValue);

          _currentRideStatus = rideStatusValue;
          _newRideData = snapshot.data() as Map<String, dynamic>;
          setState(() {});
        } else {
          debugPrint('Document data is null or not a map');
        }
      } else {
        debugPrint('Document does not exist');
      }
    });
  }

  void _fetchRoute() async {
    PolylinePoints polylinePoints = PolylinePoints();

    double originLat = _myOrigin['0']['location']['lat'] as double;
    double originLng = _myOrigin['0']['location']['lng'] as double;
    double destinationLat = _myDestination['0']['location']['lat'] as double;
    double destinationLng = _myDestination['0']['location']['lng'] as double;

    PointLatLng originPoint = PointLatLng(originLat, originLng);
    PointLatLng destinationPoint = PointLatLng(destinationLat, destinationLng);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyD0kPJKSOU4qtXrvddyAZFHeXQY2LMrz_M', // Replace with your API key
      originPoint,
      destinationPoint,
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      setState(() {
        _polyline.add(Polyline(
          polylineId: PolylineId('route_path'),
          points: polylineCoordinates,
          width: 4,
          color: const Color.fromARGB(255, 26, 27, 27),
        ));

        // Add markers for origin and destination
        _markers.add(Marker(
          markerId: MarkerId('origin'),
          position: LatLng(originLat, originLng),
          infoWindow: InfoWindow(title: 'Origin'),
        ));
        _markers.add(Marker(
          markerId: MarkerId('destination'),
          position: LatLng(destinationLat, destinationLng),
          infoWindow: InfoWindow(title: 'Destination'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    monitorRideStatus(_rideDocumentId);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height / 2,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _myOrigin['0']['location']['lat'] as double,
                    _myOrigin['0']['location']['lng'] as double,
                  ),
                  zoom: 15,
                ),
                polylines: _polyline,
                markers: _markers, // Add markers here
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 255, 254, 252),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Origin - ${_myOrigin['0']['description'].length > 20 ? _myOrigin['0']['description'].substring(0, 20) + '...' : _myOrigin['0']['description']}',
                              style: TextStyle(
                                fontSize: 14, // Adjust the font size as needed
                                color:
                                    Colors.black, // Change the font color here
                                decoration: TextDecoration.none,
                                fontFamily: FontFamily.latoRegular,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Destination - ${_myDestination['0']['description'].length > 20 ? _myDestination['0']['description'].substring(0, 20) + '...' : _myDestination['0']['description']}',
                              style: TextStyle(
                                fontSize: 14, // Adjust the font size as needed
                                color:
                                    Colors.black, // Change the font color here
                                decoration: TextDecoration.none,
                                fontFamily: FontFamily.latoRegular,
                              ),
                            ),
                          ],
                        ),

                        const Divider(),
                        const SizedBox(
                          height: 12.0,
                        ),

                        /**/
                        Text(
                          _rideDocumentId,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black, // Change the font color here
                            decoration: TextDecoration.none,
                            fontFamily: FontFamily.latoRegular,
                          ),
                        ),

                        Text(
                          "Driver arriving in 4 Minutes",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black, // Change the font color here
                            decoration: TextDecoration.none,
                            fontFamily: FontFamily.latoRegular,
                          ),
                        ),

                        SizedBox(height: 5),
                        /**/

                        /*
                    Text(
                      _currentRideStatus,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    */

                        // Locating Driver
                        Center(
                            child: _currentRideStatus == '1'
                                ? Container(
                                    height: 100, // Adjust height as needed
                                    color: Color.fromARGB(255, 255, 200, 47),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            20.0), // Adjust horizontal padding as needed
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  10.0), // Adjust horizontal padding as needed
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Locating driver',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors
                                                .black, // Change the font color here
                                            decoration: TextDecoration.none,
                                            fontFamily: FontFamily.latoRegular,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    constraints: BoxConstraints(
                                      minHeight: 180, // Minimum height
                                    ),
                                    color: const Color.fromARGB(
                                        255, 241, 240, 240),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: const CircleAvatar(
                                              radius:
                                                  30, // Adjust the radius as needed
                                              backgroundColor: Color.fromARGB(
                                                  255,
                                                  255,
                                                  216,
                                                  44), // Example color
                                              // You can replace the backgroundImage with your profile picture
                                              backgroundImage: NetworkImage(
                                                  'https://firebasestorage.googleapis.com/v0/b/mile-cab-app.appspot.com/o/documents%2Fdriver-profile-pictures%2F%2B254708394567-1707012373423-nid.jpeg?alt=media&token=a4908068-c712-4a35-916d-ab28ab705c56'),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'King Kaka',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors
                                                        .black, // Change the font color here
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily:
                                                        FontFamily.latoRegular,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '+254703557082',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors
                                                        .black, // Change the font color here
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily:
                                                        FontFamily.latoRegular,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'White, Honda Fit',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors
                                                        .black, // Change the font color here
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily:
                                                        FontFamily.latoRegular,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'KCM 354S',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors
                                                        .black, // Change the font color here
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily:
                                                        FontFamily.latoRegular,
                                                  ),
                                                ),
                                                /*SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: Color.fromARGB(
                                                        255, 255, 216, 44)),
                                                SizedBox(width: 5),
                                                Text(
                                                  '4.5', // Example star rating
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),*/
                                                SizedBox(
                                                    height:
                                                        10), // Add space between star rating and button
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    debugPrint(
                                                        "Phone No. Copied");
                                                    await Clipboard.setData(
                                                        const ClipboardData(
                                                            text:
                                                                '+254703557082'));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: const Text(
                                                            'Phone No. Copied to Clipboard'),
                                                        backgroundColor:
                                                            Colors.green[600],
                                                      ),
                                                    );
                                                  },
                                                  child: Text('Copy Number'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.yellow[600],
                                                    foregroundColor:
                                                        Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        6), // Add space between star rating and button
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    debugPrint(
                                                        "Message Driver");

                                                    // Get to Messages Screen
                                                    Get.to(
                                                      () => MessagesScreen(),
                                                      arguments: {
                                                        '_myDestination':
                                                            _myDestination,
                                                        '_myOrigin': _myOrigin,
                                                        '_discountCode':
                                                            _discountCode,
                                                        '_selectedPaymentMethod':
                                                            _selectedPaymentMethod,
                                                        '_rideDocumentId':
                                                            _rideDocumentId,
                                                      },
                                                    );
                                                  },
                                                  child: Text('Message Driver'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 0, 0, 0),
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),

                        // Locating Driver
                        const SizedBox(
                          height: 12.0,
                        ),
                        /*
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          /*debugPrint("##################");
                          debugPrint(_discountCode);
                          debugPrint(_selectedPaymentMethod);
                          debugPrint("##################");*/
                          Get.to(
                            () => CarInfoScreen(),
                            arguments: {
                              '_myDestination': _myDestination,
                              '_myOrigin': _myOrigin,
                              '_discountCode': _discountCode,
                              '_selectedPaymentMethod': _selectedPaymentMethod,
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        child: const Text(
                          'Book Ride',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    )*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
