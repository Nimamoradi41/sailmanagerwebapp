// To parse this JSON data, do
//
//     final modelRegions = modelRegionsFromJson(jsonString);

import 'dart:convert';

ModelRegions modelRegionsFromJson(String str) => ModelRegions.fromJson(json.decode(str));

String modelRegionsToJson(ModelRegions data) => json.encode(data.toJson());

class ModelRegions {
  ModelRegions({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultModelRegions> result;
  String code;
  String msg;

  factory ModelRegions.fromJson(Map<String, dynamic> json) => ModelRegions(
    result: List<ResultModelRegions>.from(json["result"].map((x) => ResultModelRegions.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultModelRegions{
  ResultModelRegions({
    required this.regionId,
    required this.cityId,
    required this.regionName,
      this.IsCheck=false,
  });

  int regionId;
  int cityId;
  String regionName;
  bool IsCheck;

  factory ResultModelRegions.fromJson(Map<String, dynamic> json) => ResultModelRegions(
    regionId: json["RegionID"],
    cityId: json["CityID"],
    regionName: json["RegionName"],
  );

  Map<String, dynamic> toJson() => {
    "RegionID": regionId,
    "CityID": cityId,
    "RegionName": regionName,
  };
}
