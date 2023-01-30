// To parse this JSON data, do
//
//     final notSoldProductsModel = notSoldProductsModelFromJson(jsonString);

import 'dart:convert';

NotSoldProductsModel notSoldProductsModelFromJson(String str) => NotSoldProductsModel.fromJson(json.decode(str));

String notSoldProductsModelToJson(NotSoldProductsModel data) => json.encode(data.toJson());

class NotSoldProductsModel {
  NotSoldProductsModel({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultNotSoldProductsModel> result;
  String code;
  String msg;

  factory NotSoldProductsModel.fromJson(Map<String, dynamic> json) => NotSoldProductsModel(
    result: List<ResultNotSoldProductsModel>.from(json["result"].map((x) => ResultNotSoldProductsModel.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultNotSoldProductsModel {
  ResultNotSoldProductsModel({
    required   this.productName,
    required  this.productCode,
    required  this.salePrice1,
    required  this.salePrice2,
    required  this.salePrice3,
    required  this.salePrice4,
    required   this.salePrice5,
    required   this.unitInventory,
    required   this.componentInventory,
  });

  String productName;
  String productCode;
  int salePrice1;
  int salePrice2;
  int salePrice3;
  int salePrice4;
  int salePrice5;
  int unitInventory;
  int componentInventory;

  factory ResultNotSoldProductsModel.fromJson(Map<String, dynamic> json) => ResultNotSoldProductsModel(
    productName: json["ProductName"],
    productCode: json["ProductCode"],
    salePrice1: json["SalePrice1"],
    salePrice2: json["SalePrice2"],
    salePrice3: json["SalePrice3"],
    salePrice4: json["SalePrice4"],
    salePrice5: json["SalePrice5"],
    unitInventory: json["UnitInventory"],
    componentInventory: json["ComponentInventory"],
  );

  Map<String, dynamic> toJson() => {
    "ProductName": productName,
    "ProductCode": productCode,
    "SalePrice1": salePrice1,
    "SalePrice2": salePrice2,
    "SalePrice3": salePrice3,
    "SalePrice4": salePrice4,
    "SalePrice5": salePrice5,
    "UnitInventory": unitInventory,
    "ComponentInventory": componentInventory,
  };
}
