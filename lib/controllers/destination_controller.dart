
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/home_controller.dart';


HomeController homeController = Get.put(HomeController());

class DestinationController extends GetxController {
  TextEditingController locationController = TextEditingController(text: homeController.userAddress.value);
  TextEditingController destinationController = TextEditingController();
  TextEditingController addStopController = TextEditingController();
  RxBool isSwapped = false.obs;
  RxList<Widget> routeListTiles = <Widget>[].obs;



  void swapItems() {
    final temp = routeListTiles[routeListTiles.length - 2];
    routeListTiles[routeListTiles.length - 2] = routeListTiles[routeListTiles.length - 1];
    routeListTiles[routeListTiles.length - 1] = temp;

    isSwapped.value = !isSwapped.value;
  }

  List<String> destinationPlace = [
    AppStrings.clearWater,
    AppStrings.meadowBrook,
    AppStrings.lakeSide,
  ];

  List<String> destinationAddressPlace = [
    AppStrings.lalDarwaja,
    AppStrings.willowLane,
    AppStrings.springdale,
  ];



}