import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_counter/controllers/counter_controller.dart';
import 'package:simple_counter/models/counter_data.dart';

class Item {
  final Key key;

  Item({this.key});
}

class AppController extends GetxController {
  int itemIndex = 0;
  RxBool inProgress = false.obs;
  RxList<Item> itemList = RxList<Item>();

  void addCounter() {
    itemList.add(Item(key: Key('${itemIndex++}')));
  }

  void removeAt(int index) {
    Get.delete<CounterController>(tag: CounterController.createTag(itemList[index].key));
    itemList.removeAt(index);
  }

  void clear() {
    itemList.forEach((element) {
      Get.delete<CounterController>(tag: CounterController.createTag(element.key));
    });
    itemList.clear();
  }

  void load() async {
    inProgress.value = true;

    SharedPreferences.getInstance()
        .then((sharedPreferences) => sharedPreferences.getString('counter_data'))
        .then((jsonEncodedCounterData) {
          CounterData counterData = CounterData.fromJson(jsonDecode(jsonEncodedCounterData));

          clear();

          counterData.counterList.forEach((element) {
            itemList.add(Item(key: Key('${itemIndex++}')));
          });
        })
        .catchError((e) {})
        .whenComplete(() => inProgress.value = false);
  }

  void save() async {
    inProgress.value = true;

    final List<Counter> counterList = [];

    itemList.forEach((element) {
      final controller = Get.find<CounterController>(tag: CounterController.createTag(element.key));
      counterList.add(Counter(
        title: controller.titleTextEditingController.text,
        count: controller.count.value,
      ));
    });

    final counterData = CounterData(counterList: counterList);
    final jsonEncodedCounterData = jsonEncode(counterData.toJson());

    SharedPreferences.getInstance()
        .then((sharedPreferences) =>
            sharedPreferences.setString('counter_data', jsonEncodedCounterData))
        .then((value) => Get.snackbar('저장', value ? '저장하였습니다.' : '저장에 실패하였습니다.'))
        .catchError((e) {})
        .whenComplete(() => inProgress.value = false);
  }
}
