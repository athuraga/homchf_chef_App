import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:homchf_chef_side/config/Palette.dart';
import 'package:homchf_chef_side/constant/app_strings.dart';
import 'package:homchf_chef_side/localization/localization_constant.dart';
import 'package:homchf_chef_side/models/common_response.dart';
import 'package:homchf_chef_side/models/menu.dart';
import 'package:homchf_chef_side/retrofit/api_client.dart';
import 'package:homchf_chef_side/retrofit/api_header.dart';
import 'package:homchf_chef_side/retrofit/base_model.dart';
import 'package:homchf_chef_side/screens/product/AddNewItem.dart';
import 'package:homchf_chef_side/utilities/device_utils.dart';
import 'package:sizer/sizer.dart';

class AddNewProduct extends StatefulWidget {
  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  Data? dropdownValue;
  int? selectedItemId;
  Future? menuFuture;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    menuFuture = getMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace_outlined,
            color: Colors.black,
            size: 35.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          getTranslated(context, add_new_product)!,
          style: TextStyle(
              fontFamily: proxima_nova_bold,
              color: Palette.loginhead,
              fontSize: 17),
        ),
      ),
      body: Container(
        //height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'))),
        child: Column(
          //direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                getTranslated(context, food_product_type)!,
                style: TextStyle(
                    color: Palette.loginhead,
                    fontSize: 16,
                    fontFamily: proxima_nova_bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  side:
                      BorderSide(color: Colors.grey.withOpacity(0.2), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: FutureBuilder<BaseModel<Menu>>(
                      future:
                          menuFuture!.then((value) => value as BaseModel<Menu>),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return DeviceUtils.showProgress(true);
                        } else {
                          var data = snapshot.data!.data;
                          if (data != null) {
                            return data.data!.length > 0
                                ? DropdownButton<Data>(
                                    //value: dropdownValue,
                                    value: dropdownValue == null
                                        ? dropdownValue
                                        : snapshot.data!.data!.data!
                                            .where((i) =>
                                                i!.name == dropdownValue!.name)
                                            .first,
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Palette.loginhead,
                                    ),
                                    iconSize: 30,
                                    elevation: 16,
                                    isDense: true,
                                    hint: Text(
                                      getTranslated(context, select_food_type)!,
                                      style: TextStyle(
                                          fontFamily: proxima_nova_reg),
                                    ),
                                    style: const TextStyle(
                                        color: Palette.loginhead),
                                    onChanged: (Data? newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        selectedItemId = snapshot
                                            .data!
                                            .data!
                                            .data![snapshot.data!.data!.data!
                                                .indexOf(newValue)]!
                                            .id;
                                        print(
                                            'value ${newValue!.name} $selectedItemId');
                                      });
                                    },
                                    items: snapshot.data!.data!.data!
                                        .map((Data? item) {
                                      //print('value ${item.name} ');
                                      return new DropdownMenuItem<Data>(
                                        child: Text(item!.name!),
                                        value: item,
                                      );
                                    }).toList(),
                                  )
                                : Container(
                                    child: Text('Please add menu'),
                                  );
                          } else {
                            return Container();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: GestureDetector(
                onTap: () {
                  _image = null;
                  _displayAddMenuDialog(
                      context); //_displayAddMenuDialog(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Palette.green,
                    ),
                    Text(
                      getTranslated(context, add_menu)!,
                      style: TextStyle(
                          color: Palette.green,
                          fontFamily: "ProximaNova",
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MaterialButton(
        height: 45,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        color: Palette.green,
        textColor: Colors.white,
        child: Text(
          getTranslated(context, add_item_for_this_product)!,
          style: TextStyle(fontFamily: proxima_nova_reg, fontSize: 16),
        ),
        onPressed: () {
          if (selectedItemId != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewItem(dropdownValue, false, null)),
            );
          } else {
            DeviceUtils.toastMessage('Please Select Food Type');
          }
        },
        splashColor: Colors.white30,
      ),
    );
  }

  Future<void> _displayAddMenuDialog(BuildContext context) async {
    TextEditingController _textMenuNameController = TextEditingController();
    AdvancedSwitchController advancedSwitchController =
        AdvancedSwitchController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white24, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(0),
                color: Palette.loginhead,
                child: Center(
                    child: Text(
                  getTranslated(context, add_menu)!,
                  style: TextStyle(
                      fontFamily: proxima_nova_bold,
                      color: Colors.white,
                      fontSize: 14),
                )),
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter dialogState) {
              return Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.w,
                              margin: EdgeInsets.only(left: 0, right: 0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: _image != null
                                    ? Image.file(
                                        _image!,
                                        fit: BoxFit.fill,
                                      )
                                    : SvgPicture.asset(
                                        'assets/images/no_image.svg',
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                dialogState(() {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return SafeArea(
                                          child: Container(
                                            child: new Wrap(
                                              children: <Widget>[
                                                new ListTile(
                                                    leading: new Icon(
                                                        Icons.photo_library),
                                                    title: new Text(
                                                        'Photo Library'),
                                                    onTap: () async {
                                                      final pickedFile =
                                                          await _picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery,
                                                              imageQuality: 50);

                                                      dialogState(() {
                                                        _image = File(
                                                            pickedFile!.path);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                new ListTile(
                                                  leading: new Icon(
                                                      Icons.photo_camera),
                                                  title: new Text('Camera'),
                                                  onTap: () async {
                                                    final pickedFile =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .camera,
                                                            imageQuality: 50);

                                                    dialogState(() {
                                                      _image = File(
                                                          pickedFile!.path);
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                });
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Palette.green,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 30.w,
                                    child: Text(
                                      getTranslated(
                                          context, add_food_item_image)!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Palette.green,
                                          fontSize: 12,
                                          fontFamily: "ProximaNova"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(context, menu_name)!,
                              style: TextStyle(
                                  color: Palette.loginhead,
                                  fontSize: 16,
                                  fontFamily: proxima_nova_bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black12, width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 0, bottom: 0),
                                    child: TextField(
                                      controller: _textMenuNameController,
                                      cursorColor: Palette.loginhead,
                                      decoration: InputDecoration(
                                          hintText:
                                              getTranslated(context, menu_name),
                                          hintStyle: TextStyle(
                                              color: Palette.switchs,
                                              fontSize: 16),
                                          border: InputBorder.none),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getTranslated(context, status)!,
                            style: TextStyle(
                                color: Palette.loginhead,
                                fontSize: 16,
                                fontFamily: proxima_nova_bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AdvancedSwitch(
                            controller: advancedSwitchController,
                            activeColor: Palette.green,
                            inactiveColor: Palette.removeacct,
                            borderRadius:
                                BorderRadius.all(const Radius.circular(5)),
                            width: 70,
                            activeChild: Text('Yes'),
                            inactiveChild: Text('No'),
                            enabled: true,
                            disabledOpacity: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Palette.green),
              child: Text(
                'Close',
                style: TextStyle(
                    fontFamily: proxima_nova_bold,
                    fontSize: 12,
                    color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Palette.green),
              child: Text(
                'Save',
                style: TextStyle(
                    fontFamily: proxima_nova_bold,
                    fontSize: 12,
                    color: Colors.white),
              ),
              onPressed: () async {
                if (_textMenuNameController.text.isEmpty) {
                  setState(() {
                    // restaurantError = empty_error_text;
                    DeviceUtils.toastMessage(
                        getTranslated(context, empty_error_text)!);
                  });
                } else {
                  Map<String, String> param = new HashMap();
                  String passScreenshotImage;
                  if (_image != null) {
                    try {
                      List<int> imageBytes = _image!.readAsBytesSync();
                      String imageB64 = base64Encode(imageBytes);
                      passScreenshotImage = imageB64;
                      param['image'] = passScreenshotImage;
                    } catch (e) {
                      DeviceUtils.toastMessage("error is ${e.toString()}");
                    }
                  }
                  param['name'] = _textMenuNameController.text.toString();
                  param['status'] =
                      advancedSwitchController.value == true ? '1' : '0';
                  CommonResponse res =
                      await ApiClient(ApiHeader().dioData()).createMenu(param);
                  if (res.success!) {
                    DeviceUtils.toastMessage(res.data!);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddNewProduct()));
                  }

                  /*FutureBuilder<BaseModel<CommonResponse>>(
                    future: addMenu(param),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return DeviceUtils.showProgress(true);
                      } else {
                        var data = snapshot.data.data;
                        if (data != null) {
                          Navigator.pop(context);
                          return DeviceUtils.toastMessage(data.data);
                        } else {
                          return  DeviceUtils.toastMessage(snapshot.error);
                        }
                      }
                    },
                  );*/
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Widget showImage() {
  //   return FutureBuilder<File>(
  //     future: imageFile,
  //     builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
  //         foodImage = snapshot.data;
  //         return Image.file(
  //           snapshot.data!,
  //           fit: BoxFit.fill,
  //         );
  //       } else if (snapshot.error != null) {
  //         return Text(
  //           'Error Picking Image',
  //           textAlign: TextAlign.center,
  //         );
  //       } else {
  //         return SvgPicture.asset(
  //           'assets/images/no_image.svg',
  //           fit: BoxFit.fill,
  //         );
  //       }
  //     },
  //   );
  // }

}
