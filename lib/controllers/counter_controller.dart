import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  static String createTag(Key key) => '${key.toString()}';

  TextEditingController titleTextEditingController;
  RxInt count;

  void plus() {
    count.value++;
  }

  void minus() {
    count.value--;
  }

  CounterController({
    String title = '',
    int count = 0,
  })  : titleTextEditingController = TextEditingController(text: title),
        count = RxInt(count);

  @override
  void onClose() {
    titleTextEditingController.dispose();
    super.onClose();
  }
}
