import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';

class ScheduleARideController extends GetxController {
  RxInt currentPage = 0.obs;
  RxInt currentMinutesPage = 0.obs;
  RxInt currentHoursPage = 0.obs;
  RxInt currentDatePage = 0.obs;
  RxString formattedDateTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateDateTime();
  }

  void updateDateTime() {
    DateTime currentDate = DateTime.now();
    String formattedDate = '${currentDate.day} ${_getMonth(currentDate.month)}, ${DateFormat(AppStrings.dateFormat).format(currentDate)}';

    formattedDateTime.value = formattedDate;
  }

  String _getMonth(int month) {
    const months = [
      AppStrings.jan,  AppStrings.feb,  AppStrings.mar,  AppStrings.apr,  AppStrings.may, AppStrings.jun,  AppStrings.jul,  AppStrings.aug,  AppStrings.sep,  AppStrings.oct,  AppStrings.nov,  AppStrings.dec
    ];
    return months[month - 1];
  }
}