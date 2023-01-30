// To parse this JSON data, do
//
//     final modelAddPath = modelAddPathFromJson(jsonString);

import 'dart:convert';

ModelAddPath modelAddPathFromJson(String str) => ModelAddPath.fromJson(json.decode(str));

String modelAddPathToJson(ModelAddPath data) => json.encode(data.toJson());

class ModelAddPath {
  ModelAddPath({
    this.result,
    required this.code,
    required this.msg,
  });

  dynamic result;
  String code;
  String msg;

  factory ModelAddPath.fromJson(Map<String, dynamic> json) => ModelAddPath(
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
