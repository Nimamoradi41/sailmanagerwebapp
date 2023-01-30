// To parse this JSON data, do
//
//     final modelCopyDayPath = modelCopyDayPathFromJson(jsonString);

import 'dart:convert';

ModelCopyDayPath modelCopyDayPathFromJson(String str) => ModelCopyDayPath.fromJson(json.decode(str));

String modelCopyDayPathToJson(ModelCopyDayPath data) => json.encode(data.toJson());

class ModelCopyDayPath {
  ModelCopyDayPath({
    this.result,
    required this.code,
    required this.msg,
  });

  dynamic result;
  String code;
  String msg;

  factory ModelCopyDayPath.fromJson(Map<String, dynamic> json) => ModelCopyDayPath(
    result: json["result"],
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "code": code,
    "msg": msg,
  };
}
