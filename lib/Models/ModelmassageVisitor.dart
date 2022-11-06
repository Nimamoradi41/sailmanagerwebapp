// To parse this JSON data, do
//
//     final modelmassageVisitor = modelmassageVisitorFromJson(jsonString);

import 'dart:convert';

ModelmassageVisitor modelmassageVisitorFromJson(String str) => ModelmassageVisitor.fromJson(json.decode(str));

String modelmassageVisitorToJson(ModelmassageVisitor data) => json.encode(data.toJson());

class ModelmassageVisitor {
  ModelmassageVisitor({
    required this.code,
    required   this.msg,
    required  this.error,
    required this.res,
  });

  int code;
  String msg;
  bool error;
  bool res;

  factory ModelmassageVisitor.fromJson(Map<String, dynamic> json) => ModelmassageVisitor(
    code: json["code"],
    msg: json["msg"],
    error: json["error"],
    res: json["res"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "error": error,
    "res": res,
  };
}
