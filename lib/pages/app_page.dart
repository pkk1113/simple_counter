import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_counter/components/counter_widget.dart';
import 'package:simple_counter/controllers/app_controller.dart';

class AppPage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FloatingActionButton(
                  child: Icon(Icons.save),
                  tooltip: '저장',
                  onPressed: controller.save,
                ),
                SizedBox(width: 5.0),
                FloatingActionButton(
                  child: Icon(Icons.replay_outlined),
                  tooltip: '불러오기',
                  onPressed: controller.load,
                ),
              ],
            ),
            FloatingActionButton(
              child: Icon(Icons.add),
              tooltip: '카운터 추가',
              onPressed: controller.addCounter,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('카운터'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Obx(() => ListView.builder(
              itemCount: controller.itemList.length,
              itemBuilder: (_, index) => Dismissible(
                  key: controller.itemList[index].key,
                  onDismissed: (direction) {
                    controller.removeAt(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.0),
                    child: CounterWidget(controller: controller.itemList[index].counterController),
                  )),
            )),
      ),
    );
  }
}
