// To parse this JSON data, do
//
//     final modelKalaNotSale = modelKalaNotSaleFromJson(jsonString);

import 'dart:convert';

ModelKalaNotSale modelKalaNotSaleFromJson(String str) => ModelKalaNotSale.fromJson(json.decode(str));

String modelKalaNotSaleToJson(ModelKalaNotSale data) => json.encode(data.toJson());

class ModelKalaNotSale {
  ModelKalaNotSale({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultKalaNotSale> result;
  String code;
  String msg;

  factory ModelKalaNotSale.fromJson(Map<String, dynamic> json) => ModelKalaNotSale(
    result: List<ResultKalaNotSale>.from(json["result"].map((x) => ResultKalaNotSale.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultKalaNotSale {
  ResultKalaNotSale({
    required this.productName,
    required this.productCode,
    required this.salePrice1,
    required this.salePrice2,
    required this.salePrice3,
    required this.salePrice4,
    required this.salePrice5,
    required this.unitInventory,
    required this.componentInventory,
  });

  String productName;
  String productCode;
  double salePrice1;
  double salePrice2;
  double salePrice3;
  double salePrice4;
  double salePrice5;
  double unitInventory;
  int componentInventory;

  factory ResultKalaNotSale.fromJson(Map<String, dynamic> json) => ResultKalaNotSale(
    productName: json["ProductName"],
    productCode: json["ProductCode"],
    salePrice1: json["SalePrice1"],
    salePrice2: json["SalePrice2"],
    salePrice3: json["SalePrice3"],
    salePrice4: json["SalePrice4"],
    salePrice5: json["SalePrice5"],
    unitInventory: json["UnitInventory"]?.toDouble(),
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
