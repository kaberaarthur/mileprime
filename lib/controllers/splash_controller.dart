import 'package:get/get.dart';


import 'dart:async';

import 'package:prime_taxi_flutter_ui_kit/config/app_size.dart';
import 'package:prime_taxi_flutter_ui_kit/view/welcome/welcome_screen.dart';




class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer( const Duration(seconds: AppSize.four), () {
      Get.off(() => const WelcomeScreen());
    });
  }
}