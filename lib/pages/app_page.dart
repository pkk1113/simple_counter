import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_counter/components/counter_widget.dart';
import 'package:simple_counter/controllers/app_controller.dart';

class AppPage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => Opacity(
              opacity: controller.inProgress.value ? 0.8 : 1.0,
              child: Obx(
                () => IgnorePointer(
                    ignoring: controller.inProgress.value,
                    child: Scaffold(
                      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                      floatingActionButton: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                FloatingActionButton(
                                  backgroundColor: Colors.black54,
                                  child: Icon(Icons.save),
                                  tooltip: 'Save',
                                  onPressed: controller.save,
                                ),
                                SizedBox(width: 5.0),
                                FloatingActionButton(
                                  backgroundColor: Colors.black54,
                                  child: Icon(Icons.download_rounded),
                                  tooltip: 'Load',
                                  onPressed: controller.load,
                                ),
                              ],
                            ),
                            FloatingActionButton(
                              backgroundColor: Colors.black54,
                              child: Icon(Icons.add),
                              tooltip: 'Add Counter',
                              onPressed: controller.addCounter,
                            ),
                          ],
                        ),
                      ),
                      appBar: AppBar(
                        title: Text('SIMPLE COUNTER'),
                        centerTitle: true,
                        leading: InkWell(
                          customBorder: CircleBorder(),
                          onTap: controller.sortTitle,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Icon(Icons.sort_by_alpha_rounded)),
                          ),
                        ),
                        actions: [
                          InkWell(
                            customBorder: CircleBorder(),
                            onTap: controller.sortCount,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Icon(Icons.sort_rounded)),
                            ),
                          )
                        ],
                      ),
                      body: GestureDetector(
                        onTap: () => Get.focusScope.unfocus(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          child: Obx(() => ReorderableListView.builder(
                                physics: BouncingScrollPhysics(),
                                onReorder: (oldIndex, newIndex) =>
                                    controller.swap(oldIndex, newIndex),
                                itemCount: controller.itemList.length,
                                itemBuilder: (_, index) => Dismissible(
                                    key: controller.itemList[index].key,
                                    onDismissed: (direction) {
                                      controller.removeAt(index);
                                    },
                                    child: CounterWidget(
                                      controller: controller.itemList[index].counterController,
                                      index: index,
                                    )),
                              )),
                        ),
                      ),
                    )),
              ),
            )),
        controller.inProgress.value ? Center(child: CircularProgressIndicator()) : SizedBox(),
      ],
    );
  }
}
