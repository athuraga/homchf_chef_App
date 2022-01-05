
import 'package:mealup_restaurant_side/retrofit/api_client.dart';
import 'package:mealup_restaurant_side/retrofit/api_header.dart';
import 'package:mealup_restaurant_side/retrofit/base_model.dart';
import 'package:mealup_restaurant_side/retrofit/server_error.dart';

Future<BaseModel<VendorDetail>> getVendorDetails() async {
  VendorDetail response;
  try {
    response = await ApiClient(ApiHeader().dioData()).vendorDetail();
  } catch (error, stacktrace) {
    print("Exception occur: $error stackTrace: $stacktrace");
    return BaseModel()..setException(ServerError.withError(error: error));
  }
  return BaseModel()..data = response;
}


class VendorDetail {
  bool? _success;
  Data? _data;

  bool? get success => _success;
  Data? get data => _data;

  VendorDetail({
      bool? success, 
      Data? data}){
    _success = success;
    _data = data;
}

  VendorDetail.fromJson(dynamic json) {
    _success = json["success"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_data != null) {
      map["data"] = _data!.toJson();
    }
    return map;
  }

}
class Data {
  int? _id;
  int? _userId;
  String? _name;
  String? _vendorLogo;
  String? _emailId;
  String? _image;
  dynamic _password;
  String? _contact;
  String? _cuisineId;
  String? _address;
  String? _lat;
  String? _lang;
  String? _mapAddress;
  String? _minOrderAmount;
  String? _forTwoPerson;
  String? _avgDeliveryTime;
  String? _licenseNumber;
  String? _adminComissionType;
  String? _adminComissionValue;
  String? _vendorType;
  String? _timeSlot;
  String? _tax;
  dynamic _deliveryTypeTimeSlot;
  int? _isExplorer;
  int? _isTop;
  int? _vendorOwnDriver;
  dynamic _paymentOption;
  int? _status;
  String? _vendorLanguage;
  String? _createdAt;
  String? _updatedAt;
  List<Cuisine>? _cuisine;
  double? _rate;
  int? _review;

  int? get id => _id;
  int? get userId => _userId;
  String? get name => _name;
  String? get vendorLogo => _vendorLogo;
  String? get emailId => _emailId;
  String? get image => _image;
  dynamic get password => _password;
  String? get contact => _contact;
  String? get cuisineId => _cuisineId;
  String? get address => _address;
  String? get lat => _lat;
  String? get lang => _lang;
  String? get mapAddress => _mapAddress;
  String? get minOrderAmount => _minOrderAmount;
  String? get forTwoPerson => _forTwoPerson;
  String? get avgDeliveryTime => _avgDeliveryTime;
  String? get licenseNumber => _licenseNumber;
  String? get adminComissionType => _adminComissionType;
  String? get adminComissionValue => _adminComissionValue;
  String? get vendorType => _vendorType;
  String? get timeSlot => _timeSlot;
  String? get tax => _tax;
  dynamic get deliveryTypeTimeSlot => _deliveryTypeTimeSlot;
  int? get isExplorer => _isExplorer;
  int? get isTop => _isTop;
  int? get vendorOwnDriver => _vendorOwnDriver;
  dynamic get paymentOption => _paymentOption;
  int? get status => _status;
  String? get vendorLanguage => _vendorLanguage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Cuisine>? get cuisine => _cuisine;
  double? get rate => _rate;
  int? get review => _review;

  Data({
      int? id, 
      int? userId, 
      String? name, 
      String? vendorLogo, 
      String? emailId, 
      String? image, 
      dynamic password, 
      String? contact, 
      String? cuisineId, 
      String? address, 
      String? lat, 
      String? lang, 
      String? mapAddress, 
      String? minOrderAmount, 
      String? forTwoPerson, 
      String? avgDeliveryTime, 
      String? licenseNumber, 
      String? adminComissionType, 
      String? adminComissionValue, 
      String? vendorType, 
      String? timeSlot, 
      String? tax, 
      dynamic deliveryTypeTimeSlot, 
      int? isExplorer, 
      int? isTop, 
      int? vendorOwnDriver, 
      dynamic paymentOption, 
      int? status, 
      String? vendorLanguage, 
      String? createdAt, 
      String? updatedAt, 
      List<Cuisine>? cuisine,
    double? rate,
    int? review}){
    _id = id;
    _userId = userId;
    _name = name;
    _vendorLogo = vendorLogo;
    _emailId = emailId;
    _image = image;
    _password = password;
    _contact = contact;
    _cuisineId = cuisineId;
    _address = address;
    _lat = lat;
    _lang = lang;
    _mapAddress = mapAddress;
    _minOrderAmount = minOrderAmount;
    _forTwoPerson = forTwoPerson;
    _avgDeliveryTime = avgDeliveryTime;
    _licenseNumber = licenseNumber;
    _adminComissionType = adminComissionType;
    _adminComissionValue = adminComissionValue;
    _vendorType = vendorType;
    _timeSlot = timeSlot;
    _tax = tax;
    _deliveryTypeTimeSlot = deliveryTypeTimeSlot;
    _isExplorer = isExplorer;
    _isTop = isTop;
    _vendorOwnDriver = vendorOwnDriver;
    _paymentOption = paymentOption;
    _status = status;
    _vendorLanguage = vendorLanguage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _cuisine = cuisine;
    _rate = rate;
    _review = review;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _name = json["name"];
    _vendorLogo = json["vendor_logo"];
    _emailId = json["email_id"];
    _image = json["image"];
    _password = json["password"];
    _contact = json["contact"];
    _cuisineId = json["cuisine_id"];
    _address = json["address"];
    _lat = json["lat"];
    _lang = json["lang"];
    _mapAddress = json["map_address"];
    _minOrderAmount = json["min_order_amount"];
    _forTwoPerson = json["for_two_person"];
    _avgDeliveryTime = json["avg_delivery_time"];
    _licenseNumber = json["license_number"];
    _adminComissionType = json["admin_comission_type"];
    _adminComissionValue = json["admin_comission_value"];
    _vendorType = json["vendor_type"];
    _timeSlot = json["time_slot"];
    _tax = json["tax"];
    _deliveryTypeTimeSlot = json["delivery_type_timeSlot"];
    _isExplorer = json["isExplorer"];
    _isTop = json["isTop"];
    _vendorOwnDriver = json["vendor_own_driver"];
    _paymentOption = json["payment_option"];
    _status = json["status"];
    _vendorLanguage = json["vendor_language"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    if (json["cuisine"] != null) {
      _cuisine = [];
      json["cuisine"].forEach((v) {
        _cuisine!.add(Cuisine.fromJson(v));
      });
    }
    _rate = json["rate"].toDouble();
    _review = json["review"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["name"] = _name;
    map["vendor_logo"] = _vendorLogo;
    map["email_id"] = _emailId;
    map["image"] = _image;
    map["password"] = _password;
    map["contact"] = _contact;
    map["cuisine_id"] = _cuisineId;
    map["address"] = _address;
    map["lat"] = _lat;
    map["lang"] = _lang;
    map["map_address"] = _mapAddress;
    map["min_order_amount"] = _minOrderAmount;
    map["for_two_person"] = _forTwoPerson;
    map["avg_delivery_time"] = _avgDeliveryTime;
    map["license_number"] = _licenseNumber;
    map["admin_comission_type"] = _adminComissionType;
    map["admin_comission_value"] = _adminComissionValue;
    map["vendor_type"] = _vendorType;
    map["time_slot"] = _timeSlot;
    map["tax"] = _tax;
    map["delivery_type_timeSlot"] = _deliveryTypeTimeSlot;
    map["isExplorer"] = _isExplorer;
    map["isTop"] = _isTop;
    map["vendor_own_driver"] = _vendorOwnDriver;
    map["payment_option"] = _paymentOption;
    map["status"] = _status;
    map["vendor_language"] = _vendorLanguage;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_cuisine != null) {
      map["cuisine"] = _cuisine!.map((v) => v.toJson()).toList();
    }
    map["rate"] = _rate;
    map["review"] = _review;
    return map;
  }

}

class Cuisine {
  String? _name;
  String? _image;

  String? get name => _name;
  String? get image => _image;

  Cuisine({
      String? name, 
      String? image}){
    _name = name;
    _image = image;
}

  Cuisine.fromJson(dynamic json) {
    _name = json["name"];
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["image"] = _image;
    return map;
  }

}