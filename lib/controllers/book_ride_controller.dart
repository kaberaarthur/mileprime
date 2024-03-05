import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_icons.dart';
import 'package:prime_taxi_flutter_ui_kit/controllers/home_controller.dart';
import '../config/app_strings.dart';

HomeController homeController = Get.put(HomeController());

class BookRideController extends GetxController {
  TextEditingController locationController = TextEditingController(text: homeController.userAddress.value);
  TextEditingController destinationController = TextEditingController(text: AppStrings.templeDestination);
  TextEditingController addStopController = TextEditingController(text: AppStrings.stopDestination);
  RxInt selectedInnerContainerIndex = 0.obs;
  RxInt selectedFullScreenRideContainerIndex = 0.obs;

  void selectInnerContainer(int index) {
    selectedInnerContainerIndex.value = index;
  }

  void selectFullScreenContainer(int index) {
    selectedFullScreenRideContainerIndex.value = index;
  }

  List<String> ridesImage = [
    AppIcons.carIcon,
    AppIcons.bikeIcon,
    AppIcons.autoIcon,
    AppIcons.carIcon,
  ];

  List<String> rides = [
    AppStrings.car,
    AppStrings.bike,
    AppStrings.auto,
    AppStrings.hourlyRental,
  ];

  List<String> ridesSubtitle = [
    AppStrings.getCarAtYourDoorStep,
    AppStrings.beatTheTrafficOnABike,
    AppStrings.comfyEconomicalAuto,
    AppStrings.getRidesAtHourlyPackages,
  ];

  List<String> ridesPrice = [
    AppStrings.dollar76,
    AppStrings.dollar39,
    AppStrings.dollar59,
  ];

  List<String> paymentMethodImage = [
    AppIcons.paypalIcon,
    AppIcons.visaIcon,
    AppIcons.netbankingIcon,
    AppIcons.upiIcon,
    AppIcons.googlePayIcon,
  ];

  List<String> paymentMethod = [
    AppStrings.payPal,
    AppStrings.debitCreditCard,
    AppStrings.netbanking,
    AppStrings.upiPayment,
    AppStrings.googlePay,
  ];
}