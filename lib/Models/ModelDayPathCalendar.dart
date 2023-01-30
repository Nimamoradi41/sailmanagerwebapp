// To parse this JSON data, do
//
//     final modelDayPathCalendar = modelDayPathCalendarFromJson(jsonString);

import 'dart:convert';

ModelDayPathCalendar modelDayPathCalendarFromJson(String str) => ModelDayPathCalendar.fromJson(json.decode(str));

String modelDayPathCalendarToJson(ModelDayPathCalendar data) => json.encode(data.toJson());

class ModelDayPathCalendar {
  ModelDayPathCalendar({
    required this.result,
    required this.code,
    required this.msg,
  });

  ResultDayPathCalendar result;
  String code;
  String msg;

  factory ModelDayPathCalendar.fromJson(Map<String, dynamic> json) => ModelDayPathCalendar(
    result: ResultDayPathCalendar.fromJson(json["result"]),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "code": code,
    "msg": msg,
  };
}

class ResultDayPathCalendar {
  ResultDayPathCalendar({
    required this.details,
    required this.startDayOfWeek,
  });

  List<DetailDayPath> details;
  int startDayOfWeek;

  factory ResultDayPathCalendar.fromJson(Map<String, dynamic> json) => ResultDayPathCalendar(
    details: List<DetailDayPath>.from(json["Details"].map((x) => DetailDayPath.fromJson(x))),
    startDayOfWeek: json["StartDayOfWeek"],
  );

  Map<String, dynamic> toJson() => {
    "Details": List<dynamic>.from(details.map((x) => x.toJson())),
    "StartDayOfWeek": startDayOfWeek,
  };
}

class DetailDayPath {
  DetailDayPath({
    required this.visitorCount,
    required this.pathCount,
    required this.day,
  });

  int visitorCount;
  int pathCount;
  int day;

  factory DetailDayPath.fromJson(Map<String, dynamic> json) => DetailDayPath(
    visitorCount: json["VisitorCount"],
    pathCount: json["PathCount"],
    day: json["Day"],
  );

  Map<String, dynamic> toJson() => {
    "VisitorCount": visitorCount,
    "PathCount": pathCount,
    "Day": day,
  };
}
