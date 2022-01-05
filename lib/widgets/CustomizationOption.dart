import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealup_restaurant_side/config/Palette.dart';

class CustomizationOption extends StatefulWidget {
  @override
  _CustomizationOptionState createState() => _CustomizationOptionState();
}

class _CustomizationOptionState extends State<CustomizationOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/images/loginn.png'))),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: "ProximaBold"),
                      ),
                      Text(
                        "Price",
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: "ProximaBold"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Palette.white),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "ex. Souce",
                                  hintStyle: TextStyle(
                                      color: Palette.switchs,
                                      fontSize: 15,
                                      fontFamily: "ProximaNova")),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Palette.white),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Price",
                                  hintStyle: TextStyle(
                                      color: Palette.switchs,
                                      fontSize: 15,
                                      fontFamily: "ProximaNova")),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: "ProximaBold"),
                      ),
                      Text(
                        "Price",
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: "ProximaBold"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Palette.white),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "ex. Souce",
                                  hintStyle: TextStyle(
                                      color: Palette.switchs,
                                      fontSize: 15,
                                      fontFamily: "ProximaNova")),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Palette.white),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Price",
                                  hintStyle: TextStyle(
                                      color: Palette.switchs,
                                      fontSize: 15,
                                      fontFamily: "ProximaNova")),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: "ProximaBold"),
                      ),
                      Text(
                        "Price",
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: "ProximaBold"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Palette.white),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "ex. Souce",
                                  hintStyle: TextStyle(
                                      color: Palette.switchs,
                                      fontSize: 15,
                                      fontFamily: "ProximaNova")),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Palette.white),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Price",
                                  hintStyle: TextStyle(
                                      color: Palette.switchs,
                                      fontSize: 15,
                                      fontFamily: "ProximaNova")),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: "ProximaBold"),
                      ),
                      Text(
                        "Price",
                        style: TextStyle(
                            color: Palette.loginhead,
                            fontSize: 16,
                            fontFamily: "ProximaBold"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Palette.white),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "ex. Souce",
                                  hintStyle: TextStyle(
                                      color: Palette.switchs,
                                      fontSize: 15,
                                      fontFamily: "ProximaNova")),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Palette.white),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Price",
                                  hintStyle: TextStyle(
                                      color: Palette.switchs,
                                      fontSize: 15,
                                      fontFamily: "ProximaNova")),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,0,0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Palette.green,
                      ),
                      Text(
                        " Add More",
                        style: TextStyle(
                            color: Palette.green,
                            fontFamily: "ProximaNova",
                            fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.of(context).pop({'selection':"ok"});
          },
          child: Container(
            color: Palette.green,
            height: MediaQuery.of(context).size.height * 0.07,
            child: Center(
              child: Text(
                "Add Customization Option",
                style: TextStyle(
                    fontSize: 15,
                    color: Palette.white,
                    fontFamily: "ProximaNova"),
              ),
            ),
          ),
        )
    );
  }

 /* void _selectItem(String value, BuildContext context) {
    Navigator.of(context).pop({'selection':value});
  }*/

}
