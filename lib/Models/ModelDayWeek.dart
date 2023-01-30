// To parse this JSON data, do
//
//     final modelDayWeek = modelDayWeekFromJson(jsonString);

import 'dart:convert';

ModelDayWeek modelDayWeekFromJson(String str) => ModelDayWeek.fromJson(json.decode(str));

String modelDayWeekToJson(ModelDayWeek data) => json.encode(data.toJson());

class ModelDayWeek {
  ModelDayWeek({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultDayWeek> result;
  String code;
  String msg;

  factory ModelDayWeek.fromJson(Map<String, dynamic> json) => ModelDayWeek(
    result: List<ResultDayWeek>.from(json["result"].map((x) => ResultDayWeek.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultDayWeek {
  ResultDayWeek({
    required this.date,
    required this.dayOfWeek,
  });

  String date;
  String dayOfWeek;

  factory ResultDayWeek.fromJson(Map<String, dynamic> json) => ResultDayWeek(
    date: json["Date"],
    dayOfWeek: json["DayOfWeek"],
  );

  Map<String, dynamic> toJson() => {
    "Date": date,
    "DayOfWeek": dayOfWeek,
  };
}
