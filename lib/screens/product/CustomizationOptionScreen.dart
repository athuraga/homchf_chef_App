import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homchf_chef_side/config/Palette.dart';
import 'package:homchf_chef_side/widgets/CustomizationOption.dart';

class CustomizationOptionScreen extends StatefulWidget {
  @override
  _CustomizationOptionScreenState createState() =>
      _CustomizationOptionScreenState();
}

class _CustomizationOptionScreenState extends State<CustomizationOptionScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Customization Option',
          style: TextStyle(
              fontFamily: "ProximaBold",
              color: Palette.loginhead,
              fontSize: 17),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace_outlined,
              color: Colors.black,
              size: 35.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: CustomizationOption(),
      ),
    );
  }
}
