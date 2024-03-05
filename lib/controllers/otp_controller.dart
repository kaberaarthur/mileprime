import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';

import '../config/app_size.dart';

class OtpController extends GetxController {
  TextEditingController pinPutController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    resendOTP();
  }

  var otp = "".obs;
  var timer = AppStrings.zero.obs;
  final RxBool isTimerExpired = false.obs;
  Timer? _timerInstance;

  void startTimer() {
    const oneSec = Duration(seconds: AppSize.one);
    _timerInstance = Timer.periodic(oneSec, (Timer timer) {
      if (timer.tick == AppSize.time60) {
        timer.cancel();

        isTimerExpired.value = true;
      } else {
        int seconds = (AppSize.time60 - timer.tick) % AppSize.time60;
        this.timer.value = seconds.toString().padLeft(AppSize.two);
      }
    });
  }

  void resetTimer() {
    timer.value = AppStrings.sixteen;
    _timerInstance?.cancel();
  }

  void resendOTP() {
    resetTimer();
    startTimer();
  }
}
