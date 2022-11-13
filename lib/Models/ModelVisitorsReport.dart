
import 'dart:convert';

ModelVisitorsReport ModelVisitorsReportFromJson(String str) => ModelVisitorsReport.fromJson(json.decode(str));


String modelVisitorsAllToJson(ModelVisitorsReport data) => json.encode(data.toJson());

class ModelVisitorsReport {


  ModelVisitorsReport({
    required this.code,
    required this.msg,
    required this.error,
    required this.res,
  });
  late final int code;
  late final String msg;
  late final bool error;
  late final Res res;

  ModelVisitorsReport.fromJson(Map<String, dynamic> json){
    code = json['code'];
    msg = json['msg'];
    error = json['error'];
    res = Res.fromJson(json['res']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['msg'] = msg;
    _data['error'] = error;
    _data['res'] = res.toJson();
    return _data;
  }
}

class Res {
  Res({
    required this.totalVisitorSale,
    required this.NtedVah,
    required this.NtedJoz,
    required this.Nprice,
    required this.Ncommission,
    required this.BtedVah,
    required this.BtedJoz,
    required this.Bprice,
    required this.Bcommission,
    required this.KHtedVah,
    required this.KHtedJoz,
    required this.KHprice,
    required this.KHcommission,
  });
  late final List<TotalVisitorSale> totalVisitorSale;
  late final double NtedVah;
  late final int NtedJoz;
  late final double Nprice;
  late final double Ncommission;
  late final double BtedVah;
  late final int BtedJoz;
  late final double Bprice;
  late final double Bcommission;
  late final double KHtedVah;
  late final int KHtedJoz;
  late final double KHprice;
  late final double KHcommission;

  Res.fromJson(Map<String, dynamic> json){
    totalVisitorSale = List.from(json['totalVisitorSale']).map((e)=>TotalVisitorSale.fromJson(e)).toList();
    NtedVah = json['NtedVah'];
    NtedJoz = json['NtedJoz'];
    Nprice = json['Nprice'];
    Ncommission = json['Ncommission'];
    BtedVah = json['BtedVah'];
    BtedJoz = json['BtedJoz'];
    Bprice = json['Bprice'];
    Bcommission = json['Bcommission'];
    KHtedVah = json['KHtedVah'];
    KHtedJoz = json['KHtedJoz'];
    KHprice = json['KHprice'];
    KHcommission = json['KHcommission'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['totalVisitorSale'] = totalVisitorSale.map((e)=>e.toJson()).toList();
    _data['NtedVah'] = NtedVah;
    _data['NtedJoz'] = NtedJoz;
    _data['Nprice'] = Nprice;
    _data['Ncommission'] = Ncommission;
    _data['BtedVah'] = BtedVah;
    _data['BtedJoz'] = BtedJoz;
    _data['Bprice'] = Bprice;
    _data['Bcommission'] = Bcommission;
    _data['KHtedVah'] = KHtedVah;
    _data['KHtedJoz'] = KHtedJoz;
    _data['KHprice'] = KHprice;
    _data['KHcommission'] = KHcommission;
    return _data;
  }
}

class TotalVisitorSale {
  TotalVisitorSale(
  {
    required this.visName,
    required this.visID,
    required this.NtedVah,
    required this.NtedJoz,
    required this.Nprice,
    required this.Ncommission,
    required this.BtedVah,
    required this.BtedJoz,
    required this.Bprice,

    required this.Bcommission,
    required this.KHtedVah,
    required this.KHtedJoz,
    required this.KHprice,
    required this.KHcommission,
  }
  );
  late final String visName;
  late final int visID;
  late final double NtedVah;
  late final int NtedJoz;
  late final double Nprice;
  late final double Ncommission;
  late final double BtedVah;
  late final int BtedJoz;
  late final double Bprice;
  late final double Bcommission;
  late final double KHtedVah;
  late final int KHtedJoz;
  late final double KHprice;
  late final double KHcommission;

  TotalVisitorSale.fromJson(Map<String, dynamic> json){
    visName = json['visName'];
    visID = json['visID'];
    NtedVah = json['NtedVah'];
    NtedJoz = json['NtedJoz'];
    Nprice = json['Nprice'];
    Ncommission = json['Ncommission'];
    BtedVah = json['BtedVah'];
    BtedJoz = json['BtedJoz'];
    Bprice = json['Bprice'];
    Bcommission = json['Bcommission'];
    KHtedVah = json['KHtedVah'];
    KHtedJoz = json['KHtedJoz'];
    KHprice = json['KHprice'];
    KHcommission = json['KHcommission'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['visName'] = visName;
    _data['visID'] = visID;
    _data['NtedVah'] = NtedVah;
    _data['NtedJoz'] = NtedJoz;
    _data['Nprice'] = Nprice;
    _data['Ncommission'] = Ncommission;
    _data['BtedVah'] = BtedVah;
    _data['BtedJoz'] = BtedJoz;
    _data['Bprice'] = Bprice;
    _data['Bcommission'] = Bcommission;
    _data['KHtedVah'] = KHtedVah;
    _data['KHtedJoz'] = KHtedJoz;
    _data['KHprice'] = KHprice;
    _data['KHcommission'] = KHcommission;
    return _data;
  }
}