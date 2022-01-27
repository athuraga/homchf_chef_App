// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:homchf_chef_side/config/Palette.dart';
// import 'package:homchf_chef_side/constant/app_strings.dart';
// import 'package:homchf_chef_side/models/user.dart';
// import 'package:homchf_chef_side/retrofit/api_client.dart';
// import 'package:homchf_chef_side/retrofit/api_header.dart';
// import 'package:homchf_chef_side/retrofit/base_model.dart';
// import 'package:homchf_chef_side/retrofit/server_error.dart';
// import 'package:homchf_chef_side/screens/auth/OtpScreen.dart';
// import 'package:homchf_chef_side/utilities/device_utils.dart';
// import 'package:homchf_chef_side/utilities/prefConstatnt.dart';
// import 'package:homchf_chef_side/utilities/preference.dart';

// // ignore: must_be_immutable
// class ForgotPasswordScreen extends StatefulWidget {
//   final bool isFromLoginScreen;
//   final String? emailForOTP;

//   const ForgotPasswordScreen(
//       {Key? key, required this.isFromLoginScreen, this.emailForOTP})
//       : super(key: key);

//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   TextEditingController email = TextEditingController();

//   String? oldPassError = '';

//   bool isProgress = false;
//   // bool _obscureText = true;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final node = FocusScope.of(context);
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       //color set to transperent or set your own color
//       statusBarIconBrightness: Brightness.dark,
//       //set brightness for icons, like dark background light icons
//     ));
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           'Get OTP',
//           style: TextStyle(
//               fontFamily: proxima_nova_bold,
//               color: Palette.loginhead,
//               fontSize: 17),
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.keyboard_backspace_outlined,
//             color: Colors.black,
//             size: 35.0,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/images/background.png'))),
//         child: Stack(
//           children: [
//             ListView(
//               children: [
//                 SizedBox(
//                   height: 200,
//                 ),
//                 SizedBox(
//                   height: 35,
//                   width: 85,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
//                         child: Flexible(
//                           child: Text(
//                             "Please keep your OTP safe if you donot get an OTP please email admin@homchf.one we shall issue new password",
//                             maxLines: 5,
//                             style: TextStyle(
//                                 color: Palette.loginhead,
//                                 fontFamily: proxima_nova_thin,
//                                 fontStyle: FontStyle.italic,
//                                 fontSize: 12),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 35,
//                 ),
//                 Center(
//                   child: GestureDetector(
//                     child: MaterialButton(
//                       height: 45,
//                       minWidth: 150,
//                       color: Colors.blue[80],
//                       textColor: Colors.blue[400],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(20),
//                         side: BorderSide(
//                             width: 2,
//                             color: Colors.blue,
//                             style: BorderStyle.solid),
//                       ),
//                       child: Text(
//                         "Send OTP",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       onPressed: () {
//                         callSendOTP();
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<BaseModel<User>> callSendOTP() async {
//     User response;
//     try {
//       DeviceUtils.onLoading(context);
//       Map<String, String?> body;
//       if (widget.isFromLoginScreen) {
//         body = {
//           'email_id': widget.emailForOTP,
//           'where': 'forgot_password',
//         };
//       } else {
//         body = {
//           'email_id': widget.emailForOTP,
//           'where': 'register',
//         };
//       }
//       response = await ApiClient(ApiHeader().dioData()).sendOTP(body);
//       DeviceUtils.hideDialog(context);
//       print(response.success);
//       if (response.success!) {
//         DeviceUtils.toastMessage('OTP Sent');

//         saveValueInPref(response);
//       } else {
//         DeviceUtils.toastMessage('Error while sending OTP.');
//       }
//     } catch (error, stacktrace) {
//       setState(() {
//         DeviceUtils.hideDialog(context);
//       });
//       print("Exception occurred: $error stackTrace: $stacktrace");
//       return BaseModel()..setException(ServerError.withError(error: error));
//     }
//     return BaseModel()..data = response;
//   }

//   void saveValueInPref(User response) {
//     SharedPreferenceHelper.setBoolean(Preferences.is_logged_in, true);
//     if (response.data!.id != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.id, response.data!.id.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.id, '');
//     }
//     if (response.data!.name != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.name, response.data!.name.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.name, '');
//     }
//     if (response.data!.image != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.image, response.data!.image!.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.image, '');
//     }

//     if (response.data!.emailId != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.email_id, response.data!.emailId!);
//     } else {
//       SharedPreferenceHelper.setString(Preferences.email_id, '');
//     }
//     if (response.data!.emailVerifiedAt != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.email_verified_at, response.data!.emailVerifiedAt);
//     } else {
//       SharedPreferenceHelper.setString(Preferences.email_verified_at, '');
//     }
//     if (response.data!.deviceToken != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.device_token, response.data!.deviceToken);
//     } else {
//       SharedPreferenceHelper.setString(Preferences.device_token, '');
//     }
//     if (response.data!.phone != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.phone, response.data!.phone!);
//     } else {
//       SharedPreferenceHelper.setString(Preferences.phone, '');
//     }
//     if (response.data!.phoneCode != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.phone_code, response.data!.phoneCode!);
//     } else {
//       SharedPreferenceHelper.setString(Preferences.phone_code, '');
//     }
//     if (response.data!.isVerified != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.is_verified, response.data!.isVerified.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.is_verified, '');
//     }
//     if (response.data!.otp != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.otp, response.data!.otp.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.otp, '');
//     }
//     if (response.data!.status != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.status, response.data!.status.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.status, '');
//     }
//     if (response.data!.faviroute != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.faviroute, response.data!.faviroute.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.faviroute, '');
//     }
//     if (response.data!.vendorId != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.vendor_id, response.data!.vendorId.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.vendor_id, '');
//     }
//     if (response.data!.language != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.language, response.data!.language.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.language, '');
//     }
//     if (response.data!.ifscCode != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.ifsc_code, response.data!.ifscCode.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.ifsc_code, '');
//     }
//     if (response.data!.accountName != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.account_name, response.data!.accountName.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.account_name, '');
//     }
//     if (response.data!.accountNumber != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.account_number, response.data!.accountNumber.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.account_number, '');
//     }

//     if (response.data!.micrCode != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.micr_code, response.data!.micrCode.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.micr_code, '');
//     }
//     if (response.data!.token != null) {
//       SharedPreferenceHelper.setString(
//           Preferences.token, response.data!.token.toString());
//     } else {
//       SharedPreferenceHelper.setString(Preferences.token, '');
//     }
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => OtpScreen(response)),
//     );
//   }
// }
