// To parse this JSON data, do
//
//     final modelProductSearch = modelProductSearchFromJson(jsonString);

import 'dart:convert';

ModelProductSearch modelProductSearchFromJson(String str) => ModelProductSearch.fromJson(json.decode(str));

String modelProductSearchToJson(ModelProductSearch data) => json.encode(data.toJson());

class ModelProductSearch {
  ModelProductSearch({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultSearchProduct> result;
  String code;
  String msg;

  factory ModelProductSearch.fromJson(Map<String, dynamic> json) => ModelProductSearch(
    result: List<ResultSearchProduct>.from(json["result"].map((x) => ResultSearchProduct.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultSearchProduct {
  ResultSearchProduct({
    required this.shka,
    required this.productName,
    required this.productCode,
    required this.groupName,
      this.IsCheck=false,
  });

  int shka;
  String productName;
  String productCode;
  String groupName;
  bool IsCheck;

  factory ResultSearchProduct.fromJson(Map<String, dynamic> json) => ResultSearchProduct(
    shka: json["SHKA"],
    productName: json["ProductName"],
    productCode: json["ProductCode"],
    groupName: json["GroupName"],
  );

  Map<String, dynamic> toJson() => {
    "SHKA": shka,
    "ProductName": productName,
    "ProductCode": productCode,
    "GroupName": groupName,
  };
}
