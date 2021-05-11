import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_counter/controllers/counter_controller.dart';

class CounterWidget extends StatelessWidget {
  /// 상수
  static const double _buttonSize = 30.0;
  static const TextStyle _textStyle = TextStyle(
    fontSize: 25.0,
    height: 30.0 / 25.0,
  );
  static const InputDecoration _textfieldInputDectoration = InputDecoration(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
  );

  /// 필드
  final CounterController controller;

  /// 생성자
  CounterWidget({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueAccent,
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
                    decoration: _textfieldInputDectoration.copyWith(hintText: '제목'),
                    inputFormatters: [_TitleInputFormatter()])),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
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
                    child: Icon(Icons.add, size: _buttonSize),
                    customBorder: CircleBorder(),
                    onTap: controller.plus,
                  ),
                ],
              ),
            )
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
