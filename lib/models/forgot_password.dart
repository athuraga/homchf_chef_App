// import 'package:homchf_chef_side/retrofit/api_client.dart';
// import 'package:homchf_chef_side/retrofit/api_header.dart';
// import 'package:homchf_chef_side/retrofit/base_model.dart';
// import 'package:homchf_chef_side/retrofit/server_error.dart';

// // Future<BaseModel<ForgotPassword>> forgotPassword(String? email) async {
// //   ForgotPassword response;
// //   try {
// //     response = await ApiClient(ApiHeader().dioData()).forgotPassword(email!);
// //   } catch (error, stacktrace) {
// //     print("Exception occur: $error stackTrace: $stacktrace");
// //     return BaseModel()..setException(ServerError.withError(error: error));
// //   }
// //   return BaseModel()..data = response;
// // }

// class ForgotPassword {
//   bool? _success;
//   List<Data>? _data;

//   bool? get success => _success;
//   List<Data>? get data => _data;

//   ForgotPassword({bool? success, List<Data>? data}) {
//     _success = success;
//     _data = data;
//   }

//   ForgotPassword.fromJson(dynamic json) {
//     _success = json["success"];
//     if (json["data"] != null) {
//       _data = [];
//       json["data"].forEach((v) {
//         _data!.add(Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["success"] = _success;
//     if (_data != null) {
//       map["data"] = _data!.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

// class Data {
//   int? _id;
//   dynamic _name;
//   String? _image;
//   String? _emailId;
//   int? _userId;

//   dynamic _emailVerifiedAt;
//   dynamic _deviceToken;
//   String? _phone;
//   String? _phoneCode;
//   int? _isVerified;
//   int? _status;
//   dynamic _otp;
//   dynamic _faviroute;
//   dynamic _vendorId;
//   dynamic _language;
//   dynamic _ifscCode;
//   dynamic _accountName;
//   dynamic _accountNumber;
//   dynamic _micrCode;
//   String? _createdAt;
//   String? _updatedAt;
//   String? _token;
//   List<Roles>? _roles;

//   int? get id => _id;
//   String? get name => _name;
//   String? get image => _image;
//   String? get emailId => _emailId;
//   int? get userId => _userId;
//   dynamic get emailVerifiedAt => _emailVerifiedAt;
//   dynamic get deviceToken => _deviceToken;
//   String? get phone => _phone;
//   String? get phoneCode => _phoneCode;
//   int? get isVerified => _isVerified;
//   int? get status => _status;
//   dynamic get otp => _otp;
//   dynamic get faviroute => _faviroute;
//   dynamic get vendorId => _vendorId;
//   dynamic get language => _language;
//   dynamic get ifscCode => _ifscCode;
//   dynamic get accountName => _accountName;
//   dynamic get accountNumber => _accountNumber;
//   dynamic get micrCode => _micrCode;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   String? get token => _token;
//   List<Roles>? get roles => _roles;

//   Data(
//       {int? id,
//       String? name,
//       String? image,
//       String? emailId,
//       int? userId,
//       dynamic emailVerifiedAt,
//       dynamic deviceToken,
//       String? phone,
//       String? phoneCode,
//       int? isVerified,
//       int? status,
//       dynamic otp,
//       dynamic faviroute,
//       dynamic vendorId,
//       dynamic language,
//       dynamic ifscCode,
//       dynamic accountName,
//       dynamic accountNumber,
//       dynamic micrCode,
//       String? createdAt,
//       String? updatedAt,
//       String? token,
//       List<Roles>? roles}) {
//     _id = id;
//     _name = name;
//     _image = image;
//     _emailId = emailId;
//     _userId = userId;
//     _emailVerifiedAt = emailVerifiedAt;
//     _deviceToken = deviceToken;
//     _phone = phone;
//     _phoneCode = phoneCode;
//     _isVerified = isVerified;
//     _status = status;
//     _otp = otp;
//     _faviroute = faviroute;
//     _vendorId = vendorId;
//     _language = language;
//     _ifscCode = ifscCode;
//     _accountName = accountName;
//     _accountNumber = accountNumber;
//     _micrCode = micrCode;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _token = token;
//     _roles = roles;
//   }

//   Data.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _image = json["image"];
//     _emailId = json["email_id"];
//     _userId = json["user_id"];

//     _emailVerifiedAt = json["email_verified_at"];
//     _deviceToken = json["device_token"];
//     _phone = json["phone"];
//     _phoneCode = json["phone_code"];
//     _isVerified = json["is_verified"];
//     _status = json["status"];
//     _otp = json["otp"];
//     _faviroute = json["faviroute"];
//     _vendorId = json["vendor_id"];
//     _language = json["language"];
//     _ifscCode = json["ifsc_code"];
//     _accountName = json["account_name"];
//     _accountNumber = json["account_number"];
//     _micrCode = json["micr_code"];
//     _createdAt = json["created_at"];
//     _updatedAt = json["updated_at"];
//     _token = json["token"];
//     if (json["roles"] != null) {
//       _roles = [];
//       json["roles"].forEach((v) {
//         _roles!.add(Roles.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["image"] = _image;
//     map["email_id"] = _emailId;
//     map["user_id"] = _userId;
//     map["email_verified_at"] = _emailVerifiedAt;
//     map["device_token"] = _deviceToken;
//     map["phone"] = _phone;
//     map["phone_code"] = _phoneCode;
//     map["is_verified"] = _isVerified;
//     map["status"] = _status;
//     map["otp"] = _otp;
//     map["faviroute"] = _faviroute;
//     map["vendor_id"] = _vendorId;
//     map["language"] = _language;
//     map["ifsc_code"] = _ifscCode;
//     map["account_name"] = _accountName;
//     map["account_number"] = _accountNumber;
//     map["micr_code"] = _micrCode;
//     map["created_at"] = _createdAt;
//     map["updated_at"] = _updatedAt;
//     map["token"] = _token;
//     if (_roles != null) {
//       map["roles"] = _roles!.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

// class Roles {
//   int? _id;
//   String? _title;
//   String? _createdAt;
//   String? _updatedAt;
//   Pivot? _pivot;

//   int? get id => _id;
//   String? get title => _title;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   Pivot? get pivot => _pivot;

//   Roles(
//       {int? id,
//       String? title,
//       String? createdAt,
//       String? updatedAt,
//       Pivot? pivot}) {
//     _id = id;
//     _title = title;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _pivot = pivot;
//   }

//   Roles.fromJson(dynamic json) {
//     _id = json["id"];
//     _title = json["title"];
//     _createdAt = json["created_at"];
//     _updatedAt = json["updated_at"];
//     _pivot = json["pivot"] != null ? Pivot.fromJson(json["pivot"]) : null;
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["title"] = _title;
//     map["created_at"] = _createdAt;
//     map["updated_at"] = _updatedAt;
//     if (_pivot != null) {
//       map["pivot"] = _pivot!.toJson();
//     }
//     return map;
//   }
// }

// class Pivot {
//   int? _userId;
//   int? _roleId;

//   int? get userId => _userId;
//   int? get roleId => _roleId;

//   Pivot({int? userId, int? roleId}) {
//     _userId = userId;
//     _roleId = roleId;
//   }

//   Pivot.fromJson(dynamic json) {
//     _userId = json["user_id"];
//     _roleId = json["role_id"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["user_id"] = _userId;
//     map["role_id"] = _roleId;
//     return map;
//   }
// }
