import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RideOptionsScreen extends StatefulWidget {
  const RideOptionsScreen({Key? key}) : super(key: key);

  @override
  State<RideOptionsScreen> createState() => _RideOptionsScreenState();
}

class _RideOptionsScreenState extends State<RideOptionsScreen> {
  late Map<String, dynamic> _myDestination;
  late Map<String, dynamic> _myOrigin;
  late final Set<Polyline> _polyline = {};
  late final Set<Marker> _markers = {}; // Add this line to hold markers

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      _myDestination = args['_myDestination'] ?? {};
      _myOrigin = args['_myOrigin'] ?? {};
      _fetchRoute();
    } else {
      _myDestination = {};
    }
    debugPrint('#############################');
    debugPrint('My Destination: $_myDestination');
    debugPrint('My Origin: $_myOrigin');
    debugPrint('#############################');
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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
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
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Origin - ${_myOrigin['0']['description'].length > 25 ? _myOrigin['0']['description'].substring(0, 25) + '...' : _myOrigin['0']['description']}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Origin - ${_myDestination['0']['description'].length > 25 ? _myDestination['0']['description'].substring(0, 25) + '...' : _myDestination['0']['description']}',
                      ),
                    ],
                  ),
                  const Divider(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mini'),
                      Text('\$1.0/mi'),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sedan'),
                      Text('₹1.25/mi'),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Luxury'),
                      Text('₹2.00/mi'),
                    ],
                  ),
                  const Divider(),
                  const Text('Payment Method'),
                  DropdownButton(
                    value: 'Cash',
                    items: const [
                      DropdownMenuItem(
                        value: 'Cash',
                        child: Text('Cash'),
                      ),
                      DropdownMenuItem(
                        value: 'Card',
                        child: Text('Card'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Discount Code',
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
