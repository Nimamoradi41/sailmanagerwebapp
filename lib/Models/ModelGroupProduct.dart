// To parse this JSON data, do
//
//     final modelGroupProduct = modelGroupProductFromJson(jsonString);

import 'dart:convert';

ModelGroupProduct modelGroupProductFromJson(String str) => ModelGroupProduct.fromJson(json.decode(str));

String modelGroupProductToJson(ModelGroupProduct data) => json.encode(data.toJson());

class ModelGroupProduct {
  ModelGroupProduct({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultGroupProduct> result;
  String code;
  String msg;

  factory ModelGroupProduct.fromJson(Map<String, dynamic> json) => ModelGroupProduct(
    result: List<ResultGroupProduct>.from(json["result"].map((x) => ResultGroupProduct.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultGroupProduct {
  ResultGroupProduct({
    required this.groupRdf,
    required this.groupName,
    this.parentId,
    this.parentName,
    this.fullName,
    this.IsCheck=false,
  });

  int groupRdf;
  String groupName;
  int? parentId;
  dynamic parentName;
  dynamic fullName;
  bool IsCheck;

  factory ResultGroupProduct.fromJson(Map<String, dynamic> json) => ResultGroupProduct(
    groupRdf: json["GroupRDF"],
    groupName: json["GroupName"],
    parentId: json["ParentID"],
    parentName: json["ParentName"],
    fullName: json["FullName"],
  );

  Map<String, dynamic> toJson() => {
    "GroupRDF": groupRdf,
    "GroupName": groupName,
    "ParentID": parentId,
    "ParentName": parentName,
    "FullName": fullName,
  };
}
