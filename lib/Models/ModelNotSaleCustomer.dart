// To parse this JSON data, do
//
//     final modelNotSaleCustomer = modelNotSaleCustomerFromJson(jsonString);

import 'dart:convert';

ModelNotSaleCustomer modelNotSaleCustomerFromJson(String str) => ModelNotSaleCustomer.fromJson(json.decode(str));

String modelNotSaleCustomerToJson(ModelNotSaleCustomer data) => json.encode(data.toJson());

class ModelNotSaleCustomer {
  ModelNotSaleCustomer({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultNotSaleCostomer> result;
  String code;
  String msg;

  factory ModelNotSaleCustomer.fromJson(Map<String, dynamic> json) => ModelNotSaleCustomer(
    result: List<ResultNotSaleCostomer>.from(json["result"].map((x) => ResultNotSaleCostomer.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultNotSaleCostomer {
  ResultNotSaleCostomer({
    required this.customerName,
    required this.phone,
    required this.address,
    required this.lastBuyDate,
  });

  String customerName;
  String phone;
  String address;
  String lastBuyDate;

  factory ResultNotSaleCostomer.fromJson(Map<String, dynamic> json) => ResultNotSaleCostomer(
    customerName: json["CustomerName"],
    phone: json["Phone"],
    address: json["Address"],
    lastBuyDate: json["LastBuyDate"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerName": customerName,
    "Phone": phone,
    "Address": address,
    "LastBuyDate": lastBuyDate,
  };
}
