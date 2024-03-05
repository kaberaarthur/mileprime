import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../api/map_service.dart';
import '../config/app_icons.dart';
import '../config/app_size.dart';
import '../config/app_strings.dart';

class MyRidesController extends GetxController {
  RxSet<Marker> markers = <Marker>{}.obs;
  RxString userAddress = ''.obs;
  RxBool like = false.obs;
  BitmapDescriptor? customMarker;
  final MarkerId markerId = const MarkerId(AppStrings.currentLocation);
  LatLng? selectedDestination=const LatLng(21.2212, 72.8688);
  GoogleMapController? myMapController;
  RxBool searchBoolean = false.obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  Rx<LatLng> initialLocation = const LatLng(0, 0).obs;
  Rx<LatLng> userLocation = const LatLng(0, 0).obs;
  RxInt selectedServiceIndex = 0.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  RxBool showPolyline = false.obs;
  final PolylinePoints polylinePoints = PolylinePoints();
  RxBool isTimerElapsed = false.obs;
  RxBool isAppBarColorVisible = false.obs;
  RxBool isAppBarTitleVisible = false.obs;
  RxBool isBodyVisible = false.obs;
  RxBool isBottomSheetOpen = false.obs;

  @override
  void onInit() {
    _getCurrentLocation();
    createMarkers();
    loadCustomMarker();
    showPolyline.value = false;
    Timer(const Duration(seconds: 5), () {
      isTimerElapsed.value = true;
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    showPolyline.value = false;
    super.onClose();
  }

  Future<void> loadCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppIcons.currentLocation,
    );
  }

  Set<Marker> createMarkers() {
    return <Marker>{
      Marker(
        markerId: markerId,
        position: initialLocation.value,
        icon: customMarker ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: AppStrings.yourCustomMarker),
        anchor: const Offset(0.8, 0.8),
      ),
    };
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;
    addCustomMarker(
      LatLng(latitude.value, longitude.value),
      AppStrings.currentLocation,
      '',
      '',
      BitmapDescriptor.fromBytes(await getBytesFromAsset(
          path: AppIcons.locationPin1,
          height: AppSize.size60.toInt(),
          width: AppSize.size60.toInt())),
    );
    await _getCurrentAddress(latitude.value, longitude.value);
    initialLocation.value = LatLng(latitude.value, longitude.value);
    update();
  }

  Future<String> _getCurrentAddress(double latitude, double longitude) async {
    const apiKey = AppStrings.key;
    final apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      final results = decodedResponse['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        final address = results.first['formatted_address'] as String;
        userAddress.value = address;
        return address;
      }
    }

    return '';
  }

  Future<Uint8List> getBytesFromAsset(
      {required String path, int? width, int? height}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width ?? AppSize.size55.toInt(),
      targetHeight: height ?? AppSize.size55.toInt(),
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  setNearMarker(LatLng cord, String name, List types, String status,
      String address) async {
    final BitmapDescriptor markerIcon;

    if (types.contains('library')) {
      markerIcon = BitmapDescriptor.fromBytes(
          await getBytesFromAsset(path: AppIcons.bikeIcon));
    } else if (types.contains('park')) {
      markerIcon = BitmapDescriptor.fromBytes(
          await getBytesFromAsset(path: AppIcons.autoIcon));
    } else if (types.contains('school')) {
      markerIcon = BitmapDescriptor.fromBytes(
          await getBytesFromAsset(path: AppIcons.carIcon));
    } else {
      markerIcon = BitmapDescriptor.fromBytes(
          await getBytesFromAsset(path: AppIcons.mapIcon));
    }
    addCustomMarker(cord, name, name, address, markerIcon);
    update();
  }

  void addCustomMarker(LatLng latLng, String markerId, String placeName,
      String address, BitmapDescriptor icon) {
    markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: latLng,
        icon: icon,
        infoWindow: InfoWindow(
          title: placeName,
          snippet: address,
        ),
        onTap: () {
          onMarkerTap(latLng);
        },
      ),
    );

    if (selectedDestination != null) {
      // markers.add(
      //   Marker(
      //     markerId: const MarkerId('selectedDestinationMarker'),
      //     position: LatLng(
      //         selectedDestination!.latitude, selectedDestination!.longitude),
      //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      //     infoWindow: const InfoWindow(
      //       title: 'Selected Destination',
      //       snippet: 'Your selected destination',
      //     ),
      //   ),
      // );
    }
    update();
  }

  void onMarkerTap(LatLng latLng) {}
  gMapsFunctionCall(context) {
    Timer(const Duration(seconds: 2), () async {
      var libraryPlaceResult = await MapServices().nearByPlaceDetailsAPI(
          const LatLng(21.2315, 72.8663), 16093.4.toInt(), "library");
      var parkPlaceResult = await MapServices().nearByPlaceDetailsAPI(
          const LatLng(21.2315, 72.8663), 16093.4.toInt(), "park");

      List<dynamic> placeWithinList =
      (libraryPlaceResult['results'] + parkPlaceResult['results']) as List;
      // allMarkerList.clear();
      // allMarkerList.addAll(placeWithinList);

      for (var element in placeWithinList) {
        setNearMarker(
            LatLng(element['geometry']['location']['lat'],
                element['geometry']['location']['lng']),
            element['name'],
            element['types'],
            element['business_status'] ?? 'not available',
            element['vicinity']);
      }
      addPolylineToDestination();
    });
  }

  void addPolylineToDestination() async {
    if (selectedDestination != null) {
      LatLng destinationLatLng = const LatLng(21.2212, 72.8688);
      polylines.clear();
      markers.removeWhere((marker) => marker.markerId.value == AppStrings.destinationMarker);
      addCustomMarker(
        destinationLatLng,
        AppStrings.destinationMarker,
        AppStrings.destinationPoint,
        AppStrings.yourDestination,
        BitmapDescriptor.fromBytes(await getBytesFromAsset(
            path: AppIcons.locationPin2,
            height: AppSize.size44.toInt(),
            width: AppSize.size30.toInt())),
      );
      update();
    }
  }
}