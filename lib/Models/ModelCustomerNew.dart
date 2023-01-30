// To parse this JSON data, do
//
//     final modelCustomerNew = modelCustomerNewFromJson(jsonString);

import 'dart:convert';

ModelCustomerNew modelCustomerNewFromJson(String str) => ModelCustomerNew.fromJson(json.decode(str));

String modelCustomerNewToJson(ModelCustomerNew data) => json.encode(data.toJson());

class ModelCustomerNew {
  ModelCustomerNew({
    required this.result,
    required   this.code,
    required this.msg,
  });

  List<ResultModelCustomerNew> result;
  String code;
  String msg;

  factory ModelCustomerNew.fromJson(Map<String, dynamic> json) => ModelCustomerNew(
    result: List<ResultModelCustomerNew>.from(json["result"].map((x) => ResultModelCustomerNew.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultModelCustomerNew {
  ResultModelCustomerNew({
    required   this.id,
    required  this.customerName,
       this.IsCheck=false,
  });

  int id;
  String customerName;
  bool IsCheck;

  factory ResultModelCustomerNew.fromJson(Map<String, dynamic> json) => ResultModelCustomerNew(
    id: json["ID"],
    customerName: json["CustomerName"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CustomerName": customerName,
  };
}
