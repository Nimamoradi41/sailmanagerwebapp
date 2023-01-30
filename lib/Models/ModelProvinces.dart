// To parse this JSON data, do
//
//     final modelProvinces = modelProvincesFromJson(jsonString);

import 'dart:convert';

ModelProvinces modelProvincesFromJson(String str) => ModelProvinces.fromJson(json.decode(str));

String modelProvincesToJson(ModelProvinces data) => json.encode(data.toJson());

class ModelProvinces {
  ModelProvinces({
    required this.result,
    required this.code,
    required this.msg,
  });


  List<Result_ModelProvinces> result;
  String code;
  String msg;

  factory ModelProvinces.fromJson(Map<String, dynamic> json) => ModelProvinces(
    result: List<Result_ModelProvinces>.from(json["result"].map((x) => Result_ModelProvinces.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class Result_ModelProvinces {
  Result_ModelProvinces({
    required  this.provinceId,
    required   this.name,
        this.IsCheck=false,
  });

  int provinceId;
  String name;
  bool IsCheck;

  factory Result_ModelProvinces.fromJson(Map<String, dynamic> json) => Result_ModelProvinces(
    provinceId: json["ProvinceID"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "ProvinceID": provinceId,
    "Name": name,
  };
}
