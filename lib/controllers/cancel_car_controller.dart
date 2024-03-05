import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';

class CancelCarController extends GetxController {
  TextEditingController reasonController = TextEditingController();
  RxList<int> checkedIndexes = <int>[].obs;

  void toggleCheckbox(int index) {
    if (checkedIndexes.contains(index)) {
      checkedIndexes.remove(index);
    } else {
      checkedIndexes.add(index);
    }
  }

  List<String> cancelCarIssue = [
    AppStrings.waitingForLongTime,
    AppStrings.thePriceIsNotReasonable,
    AppStrings.unableToContactDriver,
    AppStrings.wrongAddressShown,
    AppStrings.driverDeniedToComeToPickup,
    AppStrings.driverDeniedToGo,
    AppStrings.thePriceIsNotReasonable,
  ];
}