import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_counter/controllers/counter_controller.dart';

class CounterWidget extends StatelessWidget {
  /// 상수
  static const double _buttonSize = 30.0;
  static const _fontSize = 25.0;
  static const TextStyle _textStyle = TextStyle(
    fontSize: _fontSize,
    height: 30.0 / _fontSize,
  );
  static const _borderColor = Colors.black54;
  static const InputDecoration _textfieldInputDectoration = InputDecoration(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: _borderColor)),
    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: _borderColor)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: _borderColor)),
    contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
    isDense: true,
  );

  /// 필드
  final CounterController controller;
  final int index;

  /// 생성자
  CounterWidget({
    @required this.controller,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Row(
          children: [
            Expanded(
                child: TextField(
                    controller: controller.titleTextEditingController,
                    textAlign: TextAlign.left,
                    style: _textStyle,
                    keyboardType: TextInputType.text,
                    decoration: _textfieldInputDectoration.copyWith(hintText: 'Title'),
                    textInputAction: TextInputAction.next,
                    focusNode: controller.focusNode,
                    onEditingComplete: controller.toNextFocus,
                    inputFormatters: [_TitleInputFormatter()])),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    canRequestFocus: false,
                    child: Icon(Icons.remove, size: _buttonSize),
                    customBorder: CircleBorder(),
                    onTap: controller.minus,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: 70.0,
                    child: Obx(() => Text(
                          '${controller.count.value}',
                          style: _textStyle,
                          textAlign: TextAlign.center,
                        )),
                  ),
                  InkWell(
                    canRequestFocus: false,
                    child: Icon(Icons.add, size: _buttonSize),
                    customBorder: CircleBorder(),
                    onTap: controller.plus,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            ReorderableDragStartListener(
              index: index,
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(width: 1, color: _borderColor),
                ),
                child: Icon(Icons.menu, color: _borderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 7) {
      return oldValue;
    }
    return newValue;
  }
}
