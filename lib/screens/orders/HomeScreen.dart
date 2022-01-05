import 'dart:collection';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealup_restaurant_side/config/Palette.dart';
import 'package:mealup_restaurant_side/constant/app_strings.dart';
import 'package:mealup_restaurant_side/localization/localization_constant.dart';
import 'package:mealup_restaurant_side/models/common_response.dart';
import 'package:mealup_restaurant_side/models/orders_response.dart';
import 'package:mealup_restaurant_side/retrofit/base_model.dart';
import 'package:mealup_restaurant_side/screens/orders/OrderDetailScreen.dart';
import 'package:mealup_restaurant_side/utilities/device_utils.dart';
import 'package:mealup_restaurant_side/utilities/prefConstatnt.dart';
import 'package:mealup_restaurant_side/utilities/preference.dart';
import 'package:sizer/sizer.dart';

Future<BaseModel<OrdersResponse>>? getOrderFuture;
List<Data> orderList = [];
List<Data> _searchResult = [];
int selectedIndex = 0;
TabController? controllerTab;
TextEditingController searchController = new TextEditingController();
//List<Tab> myTabs = [];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Data> orderList = [];
  List<Data> orderListPast = [];
  List<Data> reverseorderListPast = [];
  List<Data> reverseorderList = [];

  @override
  void initState() {
    controllerTab = TabController(initialIndex: 0, length: 2, vsync: this);
    controllerTab!.addListener(() {
      setState(() {
        selectedIndex = controllerTab!.index;
      });
    });
    super.initState();

    getOrderFuture = getOrders();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      getOrderFuture = getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
          getTranslated(context, orders)!,
          //'Orders ${getTranslated(context, no_internet)}',
          style: TextStyle(fontFamily: "ProximaBold", color: Palette.loginhead),
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: controllerTab,
          unselectedLabelColor: Colors.black,
          indicatorColor: Palette.green,
          labelColor: Colors.black,
          indicatorWeight: 5,
          unselectedLabelStyle:
              TextStyle(fontSize: 18, fontFamily: proxima_nova_reg),
          labelStyle: TextStyle(fontSize: 18, fontFamily: proxima_nova_bold),
          tabs: [
            Text(getTranslated(context, new_orders)!),
            Text(getTranslated(context, past_orders)!)
          ],
        ),
      ),
      body: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(10),
        child: FutureBuilder<BaseModel<OrdersResponse>>(
          future: getOrderFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.data == null) {
                  return Center(
                      child: Container(
                          child: Text(snapshot.data!.error.getErrorMessage())));
                } else {
                  orderList.clear();
                  // if(searchController.text.isEmpty){
                  orderListPast.clear();
                  reverseorderListPast.clear();
                  reverseorderList.clear();

                  //  }
                  for (int i = 0; i < snapshot.data!.data!.data!.length; i++) {
                    if (snapshot.data!.data!.data![i].orderStatus ==
                            'COMPLETE' ||
                        snapshot.data!.data!.data![i].orderStatus == 'CANCEL' ||
                        snapshot.data!.data!.data![i].orderStatus == 'REJECT') {
                      orderListPast.add(snapshot.data!.data!.data![i]);
                    } else {
                      orderList.add(snapshot.data!.data!.data![i]);
                    }
                  }
                  reverseorderListPast = orderListPast.reversed.toList();
                  reverseorderList = orderList.reversed.toList();

                  // return newOrderList(context, snapshot.data.data.data);
                  return _tabBar(context);
                }
              } else {
                return DeviceUtils.showProgress(true);
              }
            } else {
              return DeviceUtils.showProgress(true);
            }
          },
        ),
      ),
      // ),
    );
  }

  _tabBar(BuildContext context) =>
      TabBarView(controller: controllerTab, children: [
        RefreshIndicator(
            color: Palette.green,
            onRefresh: _refreshProducts,
            child: orderList.isEmpty
                ? Center(
                    child: Container(
                    child: Text("No Data To Show"),
                  ))
                : newOrderList(context)),
        SingleChildScrollView(
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.70),
                              blurRadius: 3,
                              offset: Offset(0, 1),
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70.w,
                            child: TextField(
                              controller: searchController,
                              onChanged: onSearchTextChanged,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search Order ID or Username...',
                                  hintStyle: TextStyle(
                                      color: Palette.switchs,
                                      fontSize: 13,
                                      fontFamily: proxima_nova_reg)),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    /* Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(50),
                              spreadRadius: 1,
                              blurRadius: 1,
                            )
                          ]),
                      child: SvgPicture.asset('assets/images/filter.svg'),
                    ),*/
                  ],
                ),
              ),
              Container(
                height: 70.h,
                child: RefreshIndicator(
                  onRefresh: _refreshProducts,
                  color: Palette.green,
                  child: searchController.text.isNotEmpty
                      ? _searchResult.isEmpty
                          ? Center(
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text('No Data To Show')))
                          : ListView.builder(
                              itemCount: _searchResult.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                String? dropdownValue =
                                    _searchResult[index].orderStatus;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                  _searchResult[index]),
                                        ));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white24, width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 10,
                                                bottom: 0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "OID:",
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      _searchResult[index]
                                                          .orderId!,
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      " | ",
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '${_searchResult[index].date}, ${_searchResult[index].time}',
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      _searchResult[index]
                                                          .userName!,
                                                      style: TextStyle(
                                                          color:
                                                              Palette.loginhead,
                                                          fontFamily:
                                                              proxima_nova_bold,
                                                          fontSize: 16),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_right_outlined,
                                                      color: Palette.loginhead,
                                                      size: 35,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                        DottedLine(
                                          direction: Axis.horizontal,
                                          lineThickness: 1.0,
                                          dashColor: Palette.switchs,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 10,
                                              top: 10),
                                          child: ListView.builder(
                                            itemCount: _searchResult[index]
                                                .orderItems!
                                                .length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index1) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          _searchResult[index]
                                                              .orderItems![
                                                                  index1]
                                                              .itemName!,
                                                          style: TextStyle(
                                                              color: Palette
                                                                  .loginhead,
                                                              fontFamily:
                                                                  "ProximaNova",
                                                              fontSize: 14),
                                                        ),
                                                        Text(
                                                          ' x ${_searchResult[index].orderItems![index1].qty}',
                                                          style: TextStyle(
                                                              color:
                                                                  Palette.green,
                                                              fontFamily:
                                                                  "ProximaBold",
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    Visibility(
                                                      child: Text(
                                                        '(${_searchResult[index].orderItems![index1].itemName})',
                                                        style: TextStyle(
                                                            color:
                                                                Palette.switchs,
                                                            fontFamily:
                                                                "ProximaNova",
                                                            fontSize: 12),
                                                      ),
                                                      visible: false,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        DottedLine(
                                          direction: Axis.horizontal,
                                          lineThickness: 1.0,
                                          dashColor: Palette.switchs,
                                        ),
                                        Container(
                                          width: 100.w,
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 10,
                                              top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 30.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _searchResult[index]
                                                          .paymentType!,
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      '${SharedPreferenceHelper.getString(Preferences.currency_symbol)}${_searchResult[index].amount}',
                                                      style: TextStyle(
                                                          color:
                                                              Palette.loginhead,
                                                          fontFamily:
                                                              proxima_nova_bold,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Stack(children: [
                                                Container(
                                                  width: 20.w,
                                                  child: DropdownButton(
                                                      //value: dropdownValue ,
                                                      underline: SizedBox(),
                                                      isExpanded: true,
                                                      icon: const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            Palette.loginhead,
                                                        size: 20,
                                                      ),
                                                      iconSize: 30,
                                                      elevation: 16,
                                                      isDense: true,
                                                      style: TextStyle(
                                                          color: Palette.green,
                                                          fontFamily:
                                                              proxima_nova_bold,
                                                          fontSize: 12),
                                                      onChanged:
                                                          (dynamic newValue) {
                                                        setState(() {
                                                          dropdownValue =
                                                              newValue;
                                                          Map<String, String?>
                                                              param =
                                                              new HashMap();
                                                          param['id'] =
                                                              _searchResult[
                                                                      index]
                                                                  .id
                                                                  .toString();
                                                          param['status'] =
                                                              dropdownValue;
                                                          FutureBuilder<
                                                              BaseModel<
                                                                  CommonResponse>>(
                                                            future:
                                                                changeOrderStatus(
                                                                    param),
                                                            builder: (context,
                                                                snapshot) {
                                                              DeviceUtils
                                                                  .toastMessage(
                                                                      'before connection ');
                                                              if (snapshot
                                                                      .connectionState !=
                                                                  ConnectionState
                                                                      .done) {
                                                                return DeviceUtils
                                                                    .showProgress(
                                                                        true);
                                                              } else {
                                                                print(
                                                                    '${snapshot.data!.data}');
                                                                var data =
                                                                    snapshot
                                                                        .data!
                                                                        .data;
                                                                print(data);
                                                                setState(() {});
                                                                if (data !=
                                                                    null) {
                                                                  return Container(
                                                                    child: DeviceUtils
                                                                        .toastMessage(data
                                                                            .data
                                                                            .toString()),
                                                                  );
                                                                } else {
                                                                  return Container(
                                                                      child: DeviceUtils.toastMessage(data!
                                                                          .data
                                                                          .toString()));
                                                                }
                                                              }
                                                            },
                                                          );
                                                          // selectedItemId = snapshot.data.data.data[snapshot.data.data.data.indexOf(newValue)].id;
                                                          // print('value ${newValue.name} $selectedItemId');
                                                        });
                                                      },
                                                      items: _searchResult[
                                                                      index]
                                                                  .deliveryType ==
                                                              'SHOP'
                                                          ? <String>[
                                                              'Pending',
                                                              'Approve',
                                                              'Reject',
                                                              'PREPARE_FOR_ORDER',
                                                              'READY_FOR_ORDER',
                                                              'COMPLETE'
                                                            ].map((item) {
                                                              //print('value ${item.name} ');
                                                              return new DropdownMenuItem<
                                                                  String>(
                                                                child:
                                                                    Text(item),
                                                                value: item,
                                                              );
                                                            }).toList()
                                                          : <String>[
                                                              'Pending',
                                                              'Approve',
                                                              'Reject',
                                                              'PICKUP',
                                                              'DELIVERED',
                                                              'COMPLETE'
                                                            ].map((item) {
                                                              //print('value ${item.name} ');
                                                              return new DropdownMenuItem<
                                                                  String>(
                                                                child:
                                                                    Text(item),
                                                                value: item,
                                                              );
                                                            }).toList()),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, right: 5),
                                                  child: Text(
                                                    dropdownValue!,
                                                    style: TextStyle(
                                                        color: Palette.green,
                                                        fontFamily:
                                                            proxima_nova_bold,
                                                        fontSize: 12),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                )
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                      : reverseorderListPast.length != 0
                          ? ListView.builder(
                              itemCount: reverseorderListPast.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                String dropdownValue =
                                    reverseorderListPast[index].orderStatus!;
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                  reverseorderListPast[index]),
                                        ));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white24, width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 10,
                                                bottom: 0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "OID:",
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      reverseorderListPast[
                                                              index]
                                                          .orderId!,
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      " | ",
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '${reverseorderListPast[index].date}, ${reverseorderListPast[index].time}',
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      reverseorderListPast[
                                                              index]
                                                          .userName!,
                                                      style: TextStyle(
                                                          color:
                                                              Palette.loginhead,
                                                          fontFamily:
                                                              proxima_nova_bold,
                                                          fontSize: 16),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_right_outlined,
                                                      color: Palette.loginhead,
                                                      size: 35,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                        DottedLine(
                                          direction: Axis.horizontal,
                                          lineThickness: 1.0,
                                          dashColor: Palette.switchs,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 10,
                                              top: 10),
                                          child: ListView.builder(
                                            itemCount:
                                                reverseorderListPast[index]
                                                    .orderItems!
                                                    .length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index1) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          reverseorderListPast[
                                                                  index]
                                                              .orderItems![
                                                                  index1]
                                                              .itemName!,
                                                          style: TextStyle(
                                                              color: Palette
                                                                  .loginhead,
                                                              fontFamily:
                                                                  "ProximaNova",
                                                              fontSize: 14),
                                                        ),
                                                        Text(
                                                          ' x ${reverseorderListPast[index].orderItems![index1].qty}',
                                                          style: TextStyle(
                                                              color:
                                                                  Palette.green,
                                                              fontFamily:
                                                                  "ProximaBold",
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    Visibility(
                                                      child: Text(
                                                        '(${reverseorderListPast[index].orderItems![index1].itemName})',
                                                        style: TextStyle(
                                                            color:
                                                                Palette.switchs,
                                                            fontFamily:
                                                                "ProximaNova",
                                                            fontSize: 12),
                                                      ),
                                                      visible: false,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        DottedLine(
                                          direction: Axis.horizontal,
                                          lineThickness: 1.0,
                                          dashColor: Palette.switchs,
                                        ),
                                        Container(
                                          width: 100.w,
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 10,
                                              top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 30.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      reverseorderListPast[
                                                              index]
                                                          .paymentType!,
                                                      style: TextStyle(
                                                          color:
                                                              Palette.switchs,
                                                          fontFamily:
                                                              proxima_nova_reg,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      '${SharedPreferenceHelper.getString(Preferences.currency_symbol)}${reverseorderListPast[index].amount}',
                                                      style: TextStyle(
                                                          color:
                                                              Palette.loginhead,
                                                          fontFamily:
                                                              proxima_nova_bold,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Stack(children: [
                                                /*Container(
                              width: 20.w,
                              child: DropdownButton(
                                  //value: dropdownValue ,
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Palette.loginhead,
                                    size: 20,
                                  ),
                                  iconSize: 30,
                                  elevation: 16,
                                  isDense: true,
                                  style: TextStyle(
                                      color: Palette.green,
                                      fontFamily: proxima_nova_bold,
                                      fontSize: 12),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                      Map<String, String> param = new HashMap();
                                      param['id'] = reverseorderListPast[index].id.toString();
                                      param['status'] = dropdownValue;
                                      FutureBuilder<BaseModel<CommonResponse>>(
                                        future: changeOrderStatus(param),
                                        builder: (context, snapshot) {
                                          DeviceUtils.toastMessage('before connection ');
                                          if (snapshot.connectionState != ConnectionState.done) {
                                            return DeviceUtils.showProgress(true);
                                          } else {
                                            print('${snapshot.data.data}');
                                            var data = snapshot.data.data;
                                            print(data);
                                            setState(() {});
                                            if (data != null) {
                                              return Container(
                                                child:
                                                    DeviceUtils.toastMessage(data.data.toString()),
                                              );
                                            } else {
                                              return Container(
                                                  child: DeviceUtils.toastMessage(
                                                      data.data.toString()));
                                            }
                                          }
                                        },
                                      );
                                      // selectedItemId = snapshot.data.data.data[snapshot.data.data.data.indexOf(newValue)].id;
                                      // print('value ${newValue.name} $selectedItemId');
                                    });
                                  },
                                  items: reverseorderListPast[index].deliveryType == 'SHOP'
                                      ? <String>[
                                            'Pending',
                                            'Approve',
                                            'Reject',
                                            'PREPARE_FOR_ORDER',
                                            'READY_FOR_ORDER',
                                            'COMPLETE'
                                          ].map((item) {
                                            //print('value ${item.name} ');
                                            return new DropdownMenuItem<String>(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList() ??
                                          []
                                      : <String>[
                                            'Pending',
                                            'Approve',
                                            'Reject',
                                            'PICKUP',
                                            'DELIVERED',
                                            'COMPLETE'
                                          ].map((item) {
                                            //print('value ${item.name} ');
                                            return new DropdownMenuItem<String>(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList() ??
                                          []),
                            ),*/
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, right: 5),
                                                  child: Text(
                                                    dropdownValue,
                                                    style: TextStyle(
                                                        color: Palette.green,
                                                        fontFamily:
                                                            proxima_nova_bold,
                                                        fontSize: 12),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                )
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text('No Data To Show'))),
                ),
              ),
            ],
          ),
        ),
      ]);

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    orderListPast.forEach((order) {
      if (order.userName!.contains(text) || order.orderId!.contains(text))
        _searchResult.add(order);
    });
    print(_searchResult.length.toString());
    setState(() {});
  }

  newOrderList(BuildContext context) => ListView.builder(
        itemCount: orderList.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          String? dropdownValue = reverseorderList[index].orderStatus;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OrderDetailScreen(reverseorderList[index]),
                  ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white24, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "OID:",
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 12),
                              ),
                              Text(
                                reverseorderList[index].orderId!,
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 12),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 12),
                              ),
                              Text(
                                '${reverseorderList[index].date}, ${reverseorderList[index].time}',
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                reverseorderList[index].userName!,
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: proxima_nova_bold,
                                    fontSize: 16),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: Palette.loginhead,
                                size: 35,
                              )
                            ],
                          ),
                        ],
                      )),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineThickness: 1.0,
                    dashColor: Palette.switchs,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    child: ListView.builder(
                      itemCount: reverseorderList[index].orderItems!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index1) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    reverseorderList[index]
                                        .orderItems![index1]
                                        .itemName!,
                                    style: TextStyle(
                                        color: Palette.loginhead,
                                        fontFamily: "ProximaNova",
                                        fontSize: 14),
                                  ),
                                  Text(
                                    ' x ${reverseorderList[index].orderItems![index1].qty}',
                                    style: TextStyle(
                                        color: Palette.green,
                                        fontFamily: "ProximaBold",
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Visibility(
                                child: Text(
                                  '(${reverseorderList[index].orderItems![index1].itemName})',
                                  style: TextStyle(
                                      color: Palette.switchs,
                                      fontFamily: "ProximaNova",
                                      fontSize: 12),
                                ),
                                visible: false,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineThickness: 1.0,
                    dashColor: Palette.switchs,
                  ),
                  Container(
                    width: 100.w,
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 30.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reverseorderList[index].paymentType!,
                                style: TextStyle(
                                    color: Palette.switchs,
                                    fontFamily: proxima_nova_reg,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${SharedPreferenceHelper.getString(Preferences.currency_symbol)} ${reverseorderList[index].amount}',
                                style: TextStyle(
                                    color: Palette.loginhead,
                                    fontFamily: proxima_nova_bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Stack(children: [
                          Positioned(
                            child: DropdownButton(
                                //value: dropdownValue ,
                                underline: SizedBox(),
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Palette.loginhead,
                                  size: 30,
                                ),
                                iconSize: 30,
                                elevation: 16,
                                isDense: true,
                                style: TextStyle(
                                    color: Palette.green,
                                    fontFamily: proxima_nova_bold,
                                    fontSize: 12),
                                onChanged: (dynamic newValue) async {
                                  dropdownValue = newValue;
                                  Map<String, String?> param = new HashMap();
                                  param['id'] =
                                      reverseorderList[index].id.toString();
                                  param['status'] = dropdownValue;
                                  var res = await changeOrderStatus(param);
                                  if (res.data!.success == true) {
                                    _refreshProducts();
                                    DeviceUtils.toastMessage(
                                        res.data!.data.toString());
                                  } else {
                                    DeviceUtils.toastMessage(
                                        res.data!.data.toString());
                                  }
                                  setState(() {});

                                  /* FutureBuilder<BaseModel<CommonResponse>>(
                                      future: changeOrderStatus(param),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState != ConnectionState.done) {
                                          return DeviceUtils.showProgress(true);
                                        } else {
                                          _refreshProducts();
                                          print('${snapshot.data!.data}');
                                          var data = snapshot.data!.data;
                                          print(data);

                                          setState(() {});
                                          if (data != null) {
                                            return DeviceUtils.toastMessage(data.data.toString());
                                          } else {
                                            return DeviceUtils.toastMessage(data!.data.toString());
                                          }
                                        }
                                      },
                                    );*/
                                  // selectedItemId = snapshot.data.data.data[snapshot.data.data.data.indexOf(newValue)].id;
                                  // print('value ${newValue.name} $selectedItemId');
                                },
                                items: reverseorderList[index].orderStatus ==
                                        'PENDING'
                                    ? <String>[
                                        'APPROVE',
                                        'REJECT',
                                      ].map((item) {
                                        return new DropdownMenuItem<String>(
                                          child: Text(item),
                                          value: item,
                                        );
                                      }).toList()
                                    : reverseorderList[index].orderStatus !=
                                                'CANCEL' &&
                                            reverseorderList[index]
                                                    .orderStatus !=
                                                'REJECT' &&
                                            reverseorderList[index]
                                                    .orderStatus !=
                                                'COMPLETE'
                                        ? reverseorderList[index]
                                                    .deliveryType ==
                                                'SHOP'
                                            ? <String>[
                                                'PREPARE_FOR_ORDER',
                                                'READY_FOR_ORDER',
                                                'COMPLETE'
                                              ].map((item) {
                                                return new DropdownMenuItem<
                                                    String>(
                                                  child: Text(item),
                                                  value: item,
                                                );
                                              }).toList()
                                            : <String>[
                                                'PICKUP',
                                                'DELIVERED',
                                                'COMPLETE'
                                              ].map((item) {
                                                return new DropdownMenuItem<
                                                    String>(
                                                  child: Text(item),
                                                  value: item,
                                                );
                                              }).toList()
                                        : <String>[].map((item) {
                                            return new DropdownMenuItem<String>(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList()),
                            right: 0,
                            left: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 30, left: 30),
                            child: Text(
                              dropdownValue!,
                              style: TextStyle(
                                  color: Palette.green,
                                  fontFamily: proxima_nova_bold,
                                  fontSize: 12),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
