// To parse this JSON data, do
//
//     final modelCitys = modelCitysFromJson(jsonString);

import 'dart:convert';

ModelCitys modelCitysFromJson(String str) => ModelCitys.fromJson(json.decode(str));

String modelCitysToJson(ModelCitys data) => json.encode(data.toJson());

class ModelCitys {
  ModelCitys({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<Result_Cityss> result;
  String code;
  String msg;

  factory ModelCitys.fromJson(Map<String, dynamic> json) => ModelCitys(
    result: List<Result_Cityss>.from(json["result"].map((x) => Result_Cityss.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class Result_Cityss {
  Result_Cityss({
    required this.rdf,
    required this.cityName,
    required this.provinceId,
      this.IsCheck=false,
  });

  int rdf;
  String cityName;
  int provinceId;
  bool IsCheck;

  factory Result_Cityss.fromJson(Map<String, dynamic> json) => Result_Cityss(
    rdf: json["RDF"],
    cityName: json["CityName"],
    provinceId: json["ProvinceID"],
  );

  Map<String, dynamic> toJson() => {
    "RDF": rdf,
    "CityName": cityName,
    "ProvinceID": provinceId,
  };
}
