import 'package:mealup_restaurant_side/retrofit/api_client.dart';
import 'package:mealup_restaurant_side/retrofit/api_header.dart';
import 'package:mealup_restaurant_side/retrofit/base_model.dart';
import 'package:mealup_restaurant_side/retrofit/server_error.dart';

Future<BaseModel<UserAddressList>> getUserAddressList() async {
  UserAddressList response;
  try {
    response = await ApiClient(ApiHeader().dioData()).userAddress();
  } catch (error, stacktrace) {
    print("Exception occur: $error stackTrace: $stacktrace");
    return BaseModel()..setException(ServerError.withError(error: error));
  }
  return BaseModel()..data = response;
}

class UserAddressList {
  bool? success;
  List<UserAddressListData>? data;

  UserAddressList({this.success, this.data});

  UserAddressList.fromJson(dynamic json) {
    success = json["success"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data?.add(UserAddressListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = success;
    if (data != null) {
      map["data"] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class UserAddressListData {
  String? userAddress;

  UserAddressListData({
    this.userAddress,
  });

  UserAddressListData.fromJson(Map<String, dynamic> json) {
    userAddress = json['user_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['user_address'] = this.userAddress;
    return data;
  }
}
