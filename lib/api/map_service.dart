import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';

class MapServices {
  Future<dynamic> nearByPlaceDetailsAPI(
      LatLng cord, int radius, String type) async {
    var lat = cord.latitude;
    var long = cord.longitude;

    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=$radius&type=$type&key= ${AppStrings.key}";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }
}