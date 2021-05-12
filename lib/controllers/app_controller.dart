import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_counter/controllers/counter_controller.dart';
import 'package:simple_counter/models/counter_data.dart';

class Item {
  final Key key;
  CounterController counterController;

  Item({
    @required this.key,
    String title = '',
    int count = 0,
  }) : counterController = Get.put(
          CounterController(title: title, count: count),
          tag: CounterController.createTag(key),
        );
}

class AppController extends GetxController {
  static AppController get to => Get.find();

  int _itemIndex = 0;
  RxBool inProgress = false.obs;
  RxList<Item> itemList = RxList<Item>();

  bool get anyFocus => itemList.any((element) => element.counterController.focusNode.hasFocus);

  void addCounter() {
    itemList.add(Item(key: Key('${_itemIndex++}')));
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
            itemList.add(Item(
              key: Key('${_itemIndex++}'),
              title: element.title,
              count: element.count,
            ));
          });

          Get.snackbar('불러오기', '불러왔습니다.');
        })
        .catchError((e) => Get.snackbar('불러오기', '불러오기 중 문제가 발생하였습니다.'))
        .whenComplete(() => inProgress.value = false);
  }

  void save() async {
    inProgress.value = true;
    bool progressResult = false;
    final now = DateTime.now();

    try {
      final List<Counter> counterList = [];

      itemList.forEach((element) {
        final controller =
            Get.find<CounterController>(tag: CounterController.createTag(element.key));
        counterList.add(Counter(
          title: controller.titleTextEditingController.text,
          count: controller.count.value,
        ));
      });

      final counterData = CounterData(counterList: counterList);
      final jsonEncodedCounterData = jsonEncode(counterData.toJson());

      final sharedPreferences = await SharedPreferences.getInstance();
      final result = await sharedPreferences.setString('counter_data', jsonEncodedCounterData);

      if (!result) throw null;
      progressResult = true;
    } catch (_) {
      progressResult = false;
    } finally {
      int progressedMillisecond = DateTime.now().difference(now).inMilliseconds;
      if (progressedMillisecond < 500) {
        await Future.delayed(Duration(milliseconds: 2000 - progressedMillisecond));
      }
      inProgress.value = false;
      progressResult
          ? Get.snackbar('저장 성공', '저장하였습니다.')
          : Get.snackbar('저장 실패', '저장 중 문제가 발생하였습니다.');
    }
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  Future<void> swap(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) newIndex -= 1;
    if (oldIndex >= itemList.length || newIndex >= itemList.length) return;

    final item = itemList.removeAt(oldIndex);
    itemList.insert(newIndex, item);
  }
}
