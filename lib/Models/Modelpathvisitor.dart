

import 'dart:convert';

Modelpathvisitor ModelpathvisitorFromJson(String str) => Modelpathvisitor.fromJson(json.decode(str));

String modelmassageVisitorToJson(Modelpathvisitor data) => json.encode(data.toJson());


class Modelpathvisitor {
  Modelpathvisitor({
    required this.code,
    required this.msg,
    required this.error,
    required this.res,
  });
  late final int code;
  late final String msg;
  late final bool error;
  late final List<Res_Vis_Path> res;

  Modelpathvisitor.fromJson(Map<String, dynamic> json){
    code = json['code'];
    msg = json['msg'];
    error = json['error'];
    res = List.from(json['res']).map((e)=>Res_Vis_Path.fromJson(e)).toList();
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

class Res_Vis_Path {
  Res_Vis_Path({
    required this.visRdf,
    required this.visName,
    required this.numAllCustomers,
    required this.numCustomersVisited,
    required this.numCustomersVisitedPercent,
    required this.numCustomersVisitedWithOrder,
    required this.numCustomersVisitedPercentWithOrder,
    required this.priceOrders,
    required this.numCustomersVisitedWithOutOrder,
    required this.numCustomersVisitedPercentWithOutOrder,
    required this.avgProductOrder,
    required this.numCoverProduct,
    required this.numAllInventory,
    required this.percentCoverProduct,
    required this.numPishSaleToSale,
    required this.percentPishSaleToSale,
    required this.pricePishSaleToSale,
  });
  late final int visRdf;
  late final String visName;
  late final double numAllCustomers;
  late final double numCustomersVisited;
  late final double numCustomersVisitedPercent;
  late final double numCustomersVisitedWithOrder;
  late final double numCustomersVisitedPercentWithOrder;
  late final double priceOrders;
  late final double numCustomersVisitedWithOutOrder;
  late final double numCustomersVisitedPercentWithOutOrder;
  late final double avgProductOrder;
  late final double numCoverProduct;
  late final double numAllInventory;
  late final double percentCoverProduct;
  late final double numPishSaleToSale;
  late final double percentPishSaleToSale;
  late final double pricePishSaleToSale;

  Res_Vis_Path.fromJson(Map<String, dynamic> json){
    visRdf = json['visRdf'];
    visName = json['visName'];
    numAllCustomers = json['numAllCustomers'];
    numCustomersVisited = json['numCustomersVisited'];
    numCustomersVisitedPercent = json['numCustomersVisitedPercent'];
    numCustomersVisitedWithOrder = json['numCustomersVisitedWithOrder'];
    numCustomersVisitedPercentWithOrder = json['numCustomersVisitedPercentWithOrder'];
    priceOrders = json['priceOrders'];
    numCustomersVisitedWithOutOrder = json['numCustomersVisitedWithOutOrder'];
    numCustomersVisitedPercentWithOutOrder = json['numCustomersVisitedPercentWithOutOrder'];
    avgProductOrder = json['avgProductOrder'];
    numCoverProduct = json['numCoverProduct'];
    numAllInventory = json['numAllInventory'];
    percentCoverProduct = json['percentCoverProduct'];
    numPishSaleToSale = json['numPishSaleToSale'];
    percentPishSaleToSale = json['percentPishSaleToSale'];
    pricePishSaleToSale = json['pricePishSaleToSale'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['visRdf'] = visRdf;
    _data['visName'] = visName;
    _data['numAllCustomers'] = numAllCustomers;
    _data['numCustomersVisited'] = numCustomersVisited;
    _data['numCustomersVisitedPercent'] = numCustomersVisitedPercent;
    _data['numCustomersVisitedWithOrder'] = numCustomersVisitedWithOrder;
    _data['numCustomersVisitedPercentWithOrder'] = numCustomersVisitedPercentWithOrder;
    _data['priceOrders'] = priceOrders;
    _data['numCustomersVisitedWithOutOrder'] = numCustomersVisitedWithOutOrder;
    _data['numCustomersVisitedPercentWithOutOrder'] = numCustomersVisitedPercentWithOutOrder;
    _data['avgProductOrder'] = avgProductOrder;
    _data['numCoverProduct'] = numCoverProduct;
    _data['numAllInventory'] = numAllInventory;
    _data['percentCoverProduct'] = percentCoverProduct;
    _data['numPishSaleToSale'] = numPishSaleToSale;
    _data['percentPishSaleToSale'] = percentPishSaleToSale;
    _data['pricePishSaleToSale'] = pricePishSaleToSale;
    return _data;
  }
}