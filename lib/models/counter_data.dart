// To parse this JSON data, do
//
//     final counterData = counterDataFromJson(jsonString);

import 'dart:convert';

CounterData counterDataFromJson(String str) => CounterData.fromJson(json.decode(str));

String counterDataToJson(CounterData data) => json.encode(data.toJson());

class CounterData {
  CounterData({
    this.counterList,
  });

  List<Counter> counterList;

  factory CounterData.fromJson(Map<String, dynamic> json) => CounterData(
        counterList: List<Counter>.from(json["counter_list"].map((x) => Counter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "counter_list": List<dynamic>.from(counterList.map((x) => x.toJson())),
      };
}

class Counter {
  Counter({
    this.title,
    this.count,
  });

  String title;
  int count;

  factory Counter.fromJson(Map<String, dynamic> json) => Counter(
        title: json["title"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "count": count,
      };
}
