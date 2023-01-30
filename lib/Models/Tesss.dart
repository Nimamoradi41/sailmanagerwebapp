// To parse this JSON data, do
//
//     final tesss = tesssFromJson(jsonString);

import 'dart:convert';

Tesss tesssFromJson(String str) => Tesss.fromJson(json.decode(str));

String tesssToJson(Tesss data) => json.encode(data.toJson());

class Tesss {
  Tesss({
    required this.status,
    required   this.msg,
    required  this.res,
  });

  bool status;
  String msg;
  String res;

  factory Tesss.fromJson(Map<String, dynamic> json) => Tesss(
    status: json["status"],
    msg: json["msg"],
    res: json["res"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "res": res,
  };
}
