

import 'dart:convert';

ModelPathSumVis ModelPathSumVisFromJson(String str) => ModelPathSumVis.fromJson(json.decode(str));

String listPersonelToJson(ModelPathSumVis data) => json.encode(data.toJson());


class ModelPathSumVis {
  ModelPathSumVis({
    required this.code,
    required this.msg,
    required this.error,
    required this.res,
  });
  late final int code;
  late final String msg;
  late final bool error;
  late final List<Res_ModelPathSumVis> res;

  ModelPathSumVis.fromJson(Map<String, dynamic> json){
    code = json['code'];
    msg = json['msg'];
    error = json['error'];
    res = List.from(json['res']).map((e)=>Res_ModelPathSumVis.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['msg'] = msg;
    _data['error'] = error;
    _data['res'] = res.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Res_ModelPathSumVis {
  Res_ModelPathSumVis({
    required this.shka,
    required this.nameKala,
    required this.tedVah,
    required this.tedJoz,
    required this.mohvah,
    required this.weight,
  });
  late final int shka;
  late final String nameKala;
  late final double tedVah;
  late final int tedJoz;
  late final int mohvah;
  late final double weight;

  Res_ModelPathSumVis.fromJson(Map<String, dynamic> json){
    shka = json['shka'];
    nameKala = json['nameKala'];
    tedVah = json['tedVah'];
    tedJoz = json['tedJoz'];
    mohvah = json['mohvah'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shka'] = shka;
    _data['nameKala'] = nameKala;
    _data['tedVah'] = tedVah;
    _data['tedJoz'] = tedJoz;
    _data['mohvah'] = mohvah;
    _data['weight'] = weight;
    return _data;
  }
}