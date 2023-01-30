// To parse this JSON data, do
//
//     final modelUncoveredPaths = modelUncoveredPathsFromJson(jsonString);

import 'dart:convert';

ModelUncoveredPaths modelUncoveredPathsFromJson(String str) => ModelUncoveredPaths.fromJson(json.decode(str));

String modelUncoveredPathsToJson(ModelUncoveredPaths data) => json.encode(data.toJson());

class ModelUncoveredPaths{
  ModelUncoveredPaths({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultUncoveredPaths> result;
  String code;
  String msg;

  factory ModelUncoveredPaths.fromJson(Map<String, dynamic> json) => ModelUncoveredPaths(
    result: List<ResultUncoveredPaths>.from(json["result"].map((x) => ResultUncoveredPaths.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultUncoveredPaths {
  ResultUncoveredPaths({
    required this.provinceName,
    required  this.cityName,
    required  this.regionName,
    required  this.pathName,
    required  this.customerCount,
  });

  String provinceName;
  String cityName;
  String regionName;
  String pathName;
  int customerCount;

  factory ResultUncoveredPaths.fromJson(Map<String, dynamic> json) => ResultUncoveredPaths(
    provinceName: json["ProvinceName"],
    cityName: json["CityName"],
    regionName: json["RegionName"],
    pathName: json["PathName"],
    customerCount: json["CustomerCount"],
  );

  Map<String, dynamic> toJson() => {
    "ProvinceName": provinceName,
    "CityName": cityName,
    "RegionName": regionName,
    "PathName": pathName,
    "CustomerCount": customerCount,
  };
}
