import 'dart:collection';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mealup_restaurant_side/config/Palette.dart';
import 'package:mealup_restaurant_side/constant/app_strings.dart';
import 'package:mealup_restaurant_side/localization/localization_constant.dart';
import 'package:mealup_restaurant_side/models/user.dart';
import 'package:mealup_restaurant_side/retrofit/api_client.dart';
import 'package:mealup_restaurant_side/retrofit/api_header.dart';
import 'package:mealup_restaurant_side/retrofit/base_model.dart';
import 'package:mealup_restaurant_side/retrofit/server_error.dart';
import 'package:mealup_restaurant_side/screens/auth/LoginScreen.dart';
import 'package:mealup_restaurant_side/screens/auth/OtpScreen.dart';
import 'package:mealup_restaurant_side/utilities/device_utils.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController restaurantController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  String? restaurantError = '';
  String? emailError = '';
  String? contactError = '';
  String? passError = '';
  String? confirmPassError = '';
  bool _showProgress = false;
  String? _countryCode;
  String isVendorOwnDriver = "0";
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final node = FocusScope.of(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showProgress,
        opacity: 1.0,
        color: Colors.transparent.withOpacity(0.2),
        progressIndicator: SpinKitFadingCircle(
          color: Palette.green,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Container(
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/images/background.png',
              ),
              fit: BoxFit.fill,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 60,width: width,
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        getTranslated(context, restaurant_name)!,
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: proxima_nova_bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      restaurantError = '';
                                    });
                                  },
                                  onEditingComplete: () => node.nextFocus(),
                                  controller: restaurantController,
                                  cursorColor: Palette.loginhead,
                                  decoration: InputDecoration(
                                      hintText: getTranslated(context, restaurant_name_hint),
                                      hintStyle: TextStyle(
                                          color: Palette.switchs, fontSize: 16),
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: restaurantError!.isEmpty ? false : true,
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                restaurantError!,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontFamily: proxima_nova_bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        getTranslated(context, email)!,
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: proxima_nova_bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      emailError = '';
                                    });
                                  },
                                  onEditingComplete: () => node.nextFocus(),
                                  controller: emailController,
                                  cursorColor: Palette.loginhead,
                                  decoration: InputDecoration(
                                      hintText:
                                          getTranslated(context, email_hint),
                                      hintStyle: TextStyle(
                                          color: Palette.switchs, fontSize: 16),
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: emailError!.isEmpty ? false : true,
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                emailError!,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontFamily: proxima_nova_bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        getTranslated(context, contact_number)!,
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: proxima_nova_bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.0),
                              child: CountryCodePicker(
                                padding: EdgeInsets.zero,
                                initialSelection: 'IN',
                                showDropDownButton: true,
                                dialogSize: Size.fromRadius(200),
                                onInit: (country) {
                                  _countryCode = country!.dialCode;
                                  _countryCode = country.dialCode;
                                },
                                onChanged: (countryCode) {
                                  _countryCode = countryCode.toString();
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.56,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextField(
                                onEditingComplete: () => node.nextFocus(),
                                controller: contactController,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    contactError = '';
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: "000 000 0000",
                                    hintStyle: TextStyle(
                                        color: Palette.switchs, fontSize: 14),
                                    border: InputBorder.none),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: contactError!.isEmpty ? false : true,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          contactError!,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontFamily: proxima_nova_bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        getTranslated(context, password)!,
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: proxima_nova_bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: TextField(
                                  onEditingComplete: () => node.nextFocus(),
                                  controller: passController,
                                  obscureText: _obscureText,
                                  cursorColor: Palette.loginhead,
                                  onChanged: (value) {
                                    setState(() {
                                      passError = '';
                                    });
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Palette.green,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                      hintText:
                                          getTranslated(context, password_hint),
                                      alignLabelWithHint: true,
                                      hintStyle: TextStyle(
                                          color: Palette.switchs, fontSize: 16),
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: passError!.isEmpty ? false : true,
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                passError!,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontFamily: proxima_nova_bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
                        getTranslated(context, confirm_password)!,
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: proxima_nova_bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Palette.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: TextField(
                                  onEditingComplete: () => node.unfocus(),
                                  controller: confirmPassController,
                                  cursorColor: Palette.loginhead,
                                  obscureText: _obscureText,
                                  onChanged: (value) {
                                    setState(() {
                                      confirmPassError = '';
                                    });
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Palette.green,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                      hintText: getTranslated(context, confirm_password_hint),
                                      alignLabelWithHint: true,
                                      hintStyle: TextStyle(
                                          color: Palette.switchs, fontSize: 16),
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: confirmPassError!.isEmpty ? false : true,
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                confirmPassError!,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontFamily: proxima_nova_bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        getTranslated(context, vendor_has_own_driver)!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: proxima_nova_bold),
                      ),
                      Checkbox(
                        activeColor: Palette.green,
                        checkColor: Colors.white,
                        value: isVendorOwnDriver == "0" ? false : true,
                        onChanged: (bool? value) {
                          setState(() {
                            value == true
                                ? isVendorOwnDriver = "1"
                                : isVendorOwnDriver = "0";
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: MaterialButton(
                    height: 45,
                    minWidth: width * 0.8,
                    color: Palette.green,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20)),
                    child: Text(
                      getTranslated(context, button_continue)!,
                      style:
                          TextStyle(fontFamily: proxima_nova_reg, fontSize: 16),
                    ),
                    onPressed: () {
                      if (restaurantController.text.toString().isEmpty) {
                        setState(() {
                          restaurantError = getTranslated(context, empty_error_text);
                        });
                      } else if (emailController.text.toString().isEmpty) {
                        setState(() {
                          emailError = getTranslated(context, empty_error_text);
                        });
                      } else if (!DeviceUtils.isValidEmail(
                          emailController.text)) {
                        emailError =
                            getTranslated(context, email_valid_error_text);
                        setState(() {});
                      } else if (contactController.text.isEmpty) {
                        setState(() {contactError = getTranslated(context, empty_error_text);});
                      } else if (contactController.text.toString().length != 10) {
                        setState(() {contactError = getTranslated(context, enter_valid_contact_number);});
                      } else if (passController.text.isEmpty) {
                        passError = getTranslated(context, empty_error_text);
                        setState(() {});
                      } else if (confirmPassController.text.isEmpty) {
                        confirmPassError = getTranslated(context, empty_error_text);
                        setState(() {});
                      } else if (passController.text.toString() != confirmPassController.text) {
                        confirmPassError = getTranslated(context, not_match_pass);
                        setState(() {});
                      } else {
                        Map<String, String> param = new HashMap();
                        param['name'] = restaurantController.text.toString();
                        param['email_id'] = emailController.text.toString();
                        param['password'] = passController.text.toString();
                        param['phone_code'] = _countryCode.toString();
                        param['phone'] = contactController.text.toString();
                        param['vendor_own_driver'] = isVendorOwnDriver;
                        register(param);
                      }
                    },
                    splashColor: Colors.white30,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: proxima_nova_reg,
                            ),
                            text:
                                getTranslated(context, already_have_an_account),
                            children: [
                          TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: proxima_nova_bold,
                            ),
                            text: getTranslated(context, login),
                          )
                        ])),
                    onTap: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => LoginScreen())),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<BaseModel<User>> register(Map<String, String> param) async {
    User response;
    try {
      setState(() {
        _showProgress = true;
      });
      response = await ApiClient(ApiHeader().dioData()).register(param);

      if (response.data!.isVerified == 1) {
       // saveValueInPref(response);
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => OtpScreen(response)));
      }

      setState(() {
        _showProgress = false;
      });
    } catch (error, stacktrace) {
      setState(() {
        _showProgress = false;
      });
      print("Exception occurred: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }


  /*void saveValueInPref(User response) {
    SharedPreferenceHelper.setBoolean(Preferences.is_logged_in, true);
    if(response.data!.id != null ){
      SharedPreferenceHelper.setString(Preferences.id, response.data!.id.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.id, '');
    }
    if(response.data!.name != null ){
      SharedPreferenceHelper.setString(Preferences.name, response.data!.name.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.name, '');
    }
    if(response.data!.image != null ){
      SharedPreferenceHelper.setString(Preferences.image, response.data!.image!.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.image, '');
    }

    if(response.data!.emailId != null ){
      SharedPreferenceHelper.setString(Preferences.email_id, response.data!.emailId!);
    }else{
      SharedPreferenceHelper.setString(Preferences.email_id, '');
    }
    if( response.data!.emailVerifiedAt != null ){
      SharedPreferenceHelper.setString(Preferences.email_verified_at, response.data!.emailVerifiedAt);
    }else{
      SharedPreferenceHelper.setString(Preferences.email_verified_at, '');
    }
    if( response.data!.deviceToken != null ){
      SharedPreferenceHelper.setString(Preferences.device_token, response.data!.deviceToken);
    }else{
      SharedPreferenceHelper.setString(Preferences.device_token, '');
    }
    if( response.data!.phone != null ){
      SharedPreferenceHelper.setString(Preferences.phone, response.data!.phone!);
    }else{
      SharedPreferenceHelper.setString(Preferences.phone, '');
    }
    if( response.data!.phoneCode != null ){
      SharedPreferenceHelper.setString(Preferences.phone_code, response.data!.phoneCode!);
    }else{
      SharedPreferenceHelper.setString(Preferences.phone_code, '');
    }
    if( response.data!.isVerified != null ){
      SharedPreferenceHelper.setString(Preferences.is_verified, response.data!.isVerified.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.is_verified, '');
    }
    if( response.data!.otp != null ){
      SharedPreferenceHelper.setString(Preferences.otp, response.data!.otp);
    }else{
      SharedPreferenceHelper.setString(Preferences.otp, '');
    }
    if( response.data!.status != null ){
      SharedPreferenceHelper.setString(Preferences.status, response.data!.status.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.status, '');
    }
    if( response.data!.faviroute != null ){
      SharedPreferenceHelper.setString(Preferences.faviroute, response.data!.faviroute.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.faviroute, '');
    }
    if( response.data!.vendorId != null ){
      SharedPreferenceHelper.setString(Preferences.vendor_id, response.data!.vendorId.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.vendor_id, '');
    }
    if( response.data!.language != null ){
      SharedPreferenceHelper.setString(Preferences.language, response.data!.language.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.language, '');
    }
    if( response.data!.ifscCode != null ){
      SharedPreferenceHelper.setString(Preferences.ifsc_code, response.data!.ifscCode.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.ifsc_code, '');
    }
    if( response.data!.accountName != null ){
      SharedPreferenceHelper.setString(Preferences.account_name, response.data!.accountName.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.account_name, '');
    }
    if( response.data!.accountNumber != null ){
      SharedPreferenceHelper.setString(Preferences.account_number, response.data!.accountNumber.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.account_number, '');
    }

    if( response.data!.micrCode != null ){
      SharedPreferenceHelper.setString(Preferences.micr_code, response.data!.micrCode.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.micr_code, '');
    }
    if( response.data!.token != null ){
      SharedPreferenceHelper.setString(Preferences.token, response.data!.token.toString());
    }else{
      SharedPreferenceHelper.setString(Preferences.token, '');
    }

  }*/
}
