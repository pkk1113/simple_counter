import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  static String createTag(Key key) => '${key.toString()}';

  TextEditingController titleTextEditingController = TextEditingController();
  RxInt count = 0.obs;

  void plus() {
    count.value++;
  }

  void minus() {
    count.value--;
  }

  @override
  void onClose() {
    titleTextEditingController.dispose();
    super.onClose();
  }
}
