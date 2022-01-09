import 'package:homchf_chef_side/retrofit/api_client.dart';
import 'package:homchf_chef_side/retrofit/api_header.dart';
import 'package:homchf_chef_side/retrofit/base_model.dart';
import 'package:homchf_chef_side/retrofit/server_error.dart';

/// success : true
/// data : {"today_order":0,"total_order":52,"total_earnings":4820,"today_earnings":0,"total_menu":4,"total_submenu":7,"order_chart":[{"data":35,"label":"Sep"},{"data":35,"label":"Aug"},{"data":35,"label":"Jul"},{"data":35,"label":"Jun"},{"data":35,"label":"May"},{"data":35,"label":"Apr"},{"data":35,"label":"Mar"},{"data":35,"label":"Mar"},{"data":35,"label":"Feb"},{"data":35,"label":"Jan"},{"data":35,"label":"Dec"},{"data":35,"label":"Nov"}],"earning_chart":[{"data":0,"label":"Sep"},{"data":0,"label":"Aug"},{"data":0,"label":"Jul"},{"data":0,"label":"Jun"},{"data":0,"label":"May"},{"data":0,"label":"Apr"},{"data":0,"label":"Mar"},{"data":0,"label":"Mar"},{"data":0,"label":"Feb"},{"data":0,"label":"Jan"},{"data":0,"label":"Dec"},{"data":0,"label":"Nov"}]}

Future<BaseModel<InsightsResponse>> getInsights() async {
  InsightsResponse response;
  try {
    response = await ApiClient(ApiHeader().dioData()).insights();
  } catch (error, stacktrace) {
    print("Exception occur: $error stackTrace: $stacktrace");
    return BaseModel()..setException(ServerError.withError(error: error));
  }
  return BaseModel()..data = response;
}

class InsightsResponse {
  InsightsResponse({
    this.success,
    this.data,
  });

  InsightsResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// today_order : 0
/// total_order : 52
/// total_earnings : 4820
/// today_earnings : 0
/// total_menu : 4
/// total_submenu : 7
/// order_chart : [{"data":35,"label":"Sep"},{"data":35,"label":"Aug"},{"data":35,"label":"Jul"},{"data":35,"label":"Jun"},{"data":35,"label":"May"},{"data":35,"label":"Apr"},{"data":35,"label":"Mar"},{"data":35,"label":"Mar"},{"data":35,"label":"Feb"},{"data":35,"label":"Jan"},{"data":35,"label":"Dec"},{"data":35,"label":"Nov"}]
/// earning_chart : [{"data":0,"label":"Sep"},{"data":0,"label":"Aug"},{"data":0,"label":"Jul"},{"data":0,"label":"Jun"},{"data":0,"label":"May"},{"data":0,"label":"Apr"},{"data":0,"label":"Mar"},{"data":0,"label":"Mar"},{"data":0,"label":"Feb"},{"data":0,"label":"Jan"},{"data":0,"label":"Dec"},{"data":0,"label":"Nov"}]

class Data {
  Data({
    this.todayOrder,
    this.totalOrder,
    this.totalEarnings,
    this.todayEarnings,
    this.totalMenu,
    this.totalSubmenu,
    this.orderChart,
    this.earningChart,
  });

  Data.fromJson(dynamic json) {
    todayOrder = json['today_order'];
    totalOrder = json['total_order'];
    totalEarnings = json['total_earnings'];
    todayEarnings = json['today_earnings'];
    totalMenu = json['total_menu'];
    totalSubmenu = json['total_submenu'];
    if (json['order_chart'] != null) {
      orderChart = [];
      json['order_chart'].forEach((v) {
        orderChart?.add(Order_chart.fromJson(v));
      });
    }
    if (json['earning_chart'] != null) {
      earningChart = [];
      json['earning_chart'].forEach((v) {
        earningChart?.add(Earning_chart.fromJson(v));
      });
    }
  }
  int? todayOrder;
  int? totalOrder;
  int? totalEarnings;
  int? todayEarnings;
  int? totalMenu;
  int? totalSubmenu;
  List<Order_chart>? orderChart;
  List<Earning_chart>? earningChart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['today_order'] = todayOrder;
    map['total_order'] = totalOrder;
    map['total_earnings'] = totalEarnings;
    map['today_earnings'] = todayEarnings;
    map['total_menu'] = totalMenu;
    map['total_submenu'] = totalSubmenu;
    if (orderChart != null) {
      map['order_chart'] = orderChart?.map((v) => v.toJson()).toList();
    }
    if (earningChart != null) {
      map['earning_chart'] = earningChart?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// data : 0
/// label : "Sep"

class Earning_chart {
  Earning_chart({
    this.data,
    this.label,
  });

  Earning_chart.fromJson(dynamic json) {
    data = json['data'];
    label = json['label'];
  }
  int? data;
  String? label;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['label'] = label;
    return map;
  }
}

/// data : 35
/// label : "Sep"

class Order_chart {
  Order_chart({
    this.data,
    this.label,
  });

  Order_chart.fromJson(dynamic json) {
    data = json['data'];
    label = json['label'];
  }
  int? data;
  String? label;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['label'] = label;
    return map;
  }
}
