import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatWithDriverController extends GetxController {
  TextEditingController chatMessageController = TextEditingController();
  final RxBool isSentIconVisible = false.obs;

  void toggleIcon() {
    isSentIconVisible.value = !isSentIconVisible.value;
    isSentIconVisible.value = chatMessageController.text.isNotEmpty;
  }

  @override
  void onClose() {
    chatMessageController.dispose();
    isSentIconVisible.value = false;
    super.onClose();
  }
}