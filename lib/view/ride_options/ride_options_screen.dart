import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideOptionsScreen extends StatefulWidget {
  const RideOptionsScreen({Key? key}) : super(key: key);

  @override
  State<RideOptionsScreen> createState() => _RideOptionsScreenState();
}

class _RideOptionsScreenState extends State<RideOptionsScreen> {
  late Map<String, dynamic> _myDestination;
  late Map<String, dynamic> _myOrigin;

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      _myDestination = args['_myDestination'] ?? {};
      _myOrigin = args['_myOrigin'] ?? {};
    } else {
      _myDestination = {};
    }
    debugPrint('#############################');
    debugPrint('My Destination: $_myDestination');
    debugPrint('My Origin: $_myOrigin');
    debugPrint('#############################');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
