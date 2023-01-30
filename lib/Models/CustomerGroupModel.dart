// To parse this JSON data, do
//
//     final customerGroupModel = customerGroupModelFromJson(jsonString);

import 'dart:convert';

CustomerGroupModel customerGroupModelFromJson(String str) => CustomerGroupModel.fromJson(json.decode(str));

String customerGroupModelToJson(CustomerGroupModel data) => json.encode(data.toJson());

class CustomerGroupModel {
  CustomerGroupModel({
    required this.result,
    required this.code,
    required this.msg,
  });

  List<ResultCustomerGroupModel> result;
  String code;
  String msg;

  factory CustomerGroupModel.fromJson(Map<String, dynamic> json) => CustomerGroupModel(
    result: List<ResultCustomerGroupModel>.from(json["result"].map((x) => ResultCustomerGroupModel.fromJson(x))),
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "code": code,
    "msg": msg,
  };
}

class ResultCustomerGroupModel {
  ResultCustomerGroupModel({
    required  this.id,
    required  this.groupName,
       this.IsCheck=false,
  });

  int id;
  String groupName;
  bool IsCheck;


  factory ResultCustomerGroupModel.fromJson(Map<String, dynamic> json) => ResultCustomerGroupModel(
    id: json["ID"],
    groupName: json["GroupName"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "GroupName": groupName,
  };
}
