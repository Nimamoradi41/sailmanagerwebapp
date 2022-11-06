// To parse this JSON data, do
//
//     final modelVisitorsAll = modelVisitorsAllFromJson(jsonString);

import 'dart:convert';

ModelVisitorsAll modelVisitorsAllFromJson(String str) => ModelVisitorsAll.fromJson(json.decode(str));


String modelVisitorsAllToJson(ModelVisitorsAll data) => json.encode(data.toJson());

class ModelVisitorsAll {
  ModelVisitorsAll({
    required this.code,
    required  this.msg,
    required this.error,
    required  this.res,
  });

  int code;
  String msg;
  bool error;
  List<Re_VisitorsAll> res;

  factory ModelVisitorsAll.fromJson(Map<String, dynamic> json) => ModelVisitorsAll(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: List<Re_VisitorsAll>.from(json["res"].map((x) => Re_VisitorsAll.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}

class Re_VisitorsAll {
  Re_VisitorsAll({
    required this.visRdf,
    required this.name,
    required this.tell1,
    required this.tell2,
    required    this.cell,
     this.IsCheck=false,
  });

  int visRdf;
  String name;
  String tell1;
  String tell2;
  String cell;
  bool IsCheck;

  factory Re_VisitorsAll.fromJson(Map<String, dynamic> json) => Re_VisitorsAll(
    visRdf: json["visRdf"],
    name: json["name"],
    tell1: json["tell1"],
    tell2: json["tell2"],
    cell: json["cell"],

  );

  Map<String, dynamic> toJson() => {
    "visRdf": visRdf,
    "name": name,
    "tell1": tell1,
    "tell2": tell2,
    "cell": cell,

  };
}
