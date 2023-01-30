// To parse this JSON data, do
//
//     final modelReportVisitordaypath = modelReportVisitordaypathFromJson(jsonString);

import 'dart:convert';

ModelReportVisitordaypath modelReportVisitordaypathFromJson(String str) => ModelReportVisitordaypath.fromJson(json.decode(str));

String modelReportVisitordaypathToJson(ModelReportVisitordaypath data) => json.encode(data.toJson());

class ModelReportVisitordaypath {
  ModelReportVisitordaypath({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultDaypath> result;
  String code;
  String msg;

  factory ModelReportVisitordaypath.fromJson(Map<String, dynamic> json) => ModelReportVisitordaypath(
    result: List<ResultDaypath>.from(json["result"].map((x) => ResultDaypath.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultDaypath {
  ResultDaypath({
    required this.visitorId,
    required this.visitorName,
    required this.cityName,
    required this.regionName,
    required this.pathName,
    required this.customerCount,
  });

  int visitorId;
  String visitorName;
  String cityName;
  String regionName;
  String pathName;
  int customerCount;

  factory ResultDaypath.fromJson(Map<String, dynamic> json) => ResultDaypath(
    visitorId: json["VisitorID"],
    visitorName: json["VisitorName"],
    cityName: json["CityName"],
    regionName: json["RegionName"],
    pathName: json["PathName"],
    customerCount: json["CustomerCount"],
  );

  Map<String, dynamic> toJson() => {
    "VisitorID": visitorId,
    "VisitorName": visitorName,
    "CityName": cityName,
    "RegionName": regionName,
    "PathName": pathName,
    "CustomerCount": customerCount,
  };
}
