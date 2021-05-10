import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_counter/controllers/counter_controller.dart';

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
    // Get.find<CounterController>(tag: CounterController.createTag(itemList[index].key));
    Get.delete<CounterController>(tag: CounterController.createTag(itemList[index].key));
    itemList.removeAt(index);
  }

  void load() async {
    final sharedPreferences = await SharedPreferences.getInstance();
  }

  void save() async {
    final sharedPreferences = await SharedPreferences.getInstance();
  }
}
