// To parse this JSON data, do
//
//     final modelPaths = modelPathsFromJson(jsonString);

import 'dart:convert';

ModelPaths modelPathsFromJson(String str) => ModelPaths.fromJson(json.decode(str));

String modelPathsToJson(ModelPaths data) => json.encode(data.toJson());

class ModelPaths {
  ModelPaths({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultPaths> result;
  String code;
  String msg;

  factory ModelPaths.fromJson(Map<String, dynamic> json) => ModelPaths(
    result: List<ResultPaths>.from(json["result"].map((x) => ResultPaths.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultPaths {
  ResultPaths({
    required this.pathId,
    required this.regionId,
    required this.pathName,
      this.IsCheck=false,
  });

  int pathId;
  int regionId;
  String pathName;
  bool IsCheck;

  factory ResultPaths.fromJson(Map<String, dynamic> json) => ResultPaths(
    pathId: json["PathID"],
    regionId: json["RegionID"],
    pathName: json["PathName"],
  );

  Map<String, dynamic> toJson() => {
    "PathID": pathId,
    "RegionID": regionId,
    "PathName": pathName,
  };
}
