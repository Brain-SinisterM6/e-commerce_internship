import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/controller/CartProvider.dart';
import 'package:ecommerceapp/controller/UserId_provider.dart';
 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'finalPage.dart';

class Checkout extends StatefulWidget {
  var attributeMap = <Map>[];
  String loginUserId;
  String total;
  String orderDet = "";
  String myComment = "No Comments";
  String GetName = '';
  String Getemail = '';
  String Getpass = '';
  String Getpic = '';
  String Getorder = '';
  var lastdata = [];

  var mylist = [];
  var mylist2 = [];
  Checkout(  this.total);

  CheckoutState createState() => new CheckoutState();
}

class CheckoutState extends State<Checkout> {
  TextEditingController addrectr;
  TextEditingController cityctr;
  TextEditingController mobilectr;
  TextEditingController commentctr;
  TextEditingController Voucherctr;
  bool _validateAddres = false;
  bool _validateCity = false;
  bool _validateMobile = false;
  String errorAddres = '';
  String errorAddres2 = null;
  String errorMobile = '';
  String errorMobile2 = null;
  String errorCity = '';
  String errorCity2 = null;
  String discount = "0";

  List<DynamicWidget> listdynamic = [];
  //3shan a3ml dynamic text lkol item fl order
  addDyanmic(String name) {
    listdynamic.add(new DynamicWidget(name));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.loginUserId= Provider.of<getuserid>(context,listen: false ).GetData();
    widget.attributeMap=Provider.of<addCart>(context,listen: false ).GetData();

//bgeb l info
      UserInfo();

// b3rf l textfiled
    addrectr = TextEditingController(text: "");
    cityctr = TextEditingController(text: "");
    mobilectr = TextEditingController(text: "");
    commentctr = TextEditingController(text: "");
    Voucherctr = TextEditingController(text: "");
    //bmshi 3l map 3shan ageb lkol item ele a5taru b kolo 7aga feh w a7oto f string w b3din a3mlu text w b7oto fe list2 3shan hst5dmu odam
    for (int i = 0; i < widget.attributeMap.length; i++) {
      widget.orderDet =
      "${widget.attributeMap[i]['name']} Price ${widget.attributeMap[i]['price']}"
          " Quantity ${widget.attributeMap[i]['quantity']}"
          " Total ${int.parse(widget.attributeMap[i]['quantity']) * int.parse(widget.attributeMap[i]['price'])}";
      addDyanmic(widget.orderDet);
      widget.mylist2.add("- ${widget.orderDet}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          //3shan l shadow bta3ha
          elevation: 0.1,
          backgroundColor: Colors.black,
          title: InkWell(
            child: Text('checkout'),
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          alignment: Alignment.center,
          child: InkWell(
            child: Text(
              'Place Order',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              if (addrectr.text.toString() == '' ||
                  mobilectr.text.toString() == '' ||
                  cityctr.text.toString() == '') {
                if (addrectr.text.toString() == '') {
                  setState(() {
                    errorAddres = 'Address Can\'t Be Empty';
                    _validateAddres = true;
                  });
                } else {
                  setState(() {
                    _validateAddres = false;
                  });
                }
                if (mobilectr.text.toString() == '') {
                  setState(() {
                    errorMobile = 'Mobile Can\'t Be Empty';
                    _validateMobile = true;
                  });
                } else {
                  setState(() {
                    _validateMobile = false;
                  });
                }
                if (cityctr.text.toString() == '') {
                  setState(() {
                    errorCity = 'City Can\'t Be Empty';
                    _validateCity = true;
                  });
                } else {
                  setState(() {
                    _validateCity = false;
                  });
                }
                //fill
              } else {
                //go ya3m

                widget.mylist.add("Address: ${addrectr.text}");
                widget.mylist.add("city: ${cityctr.text}");
                widget.mylist.add("Mobile: ${mobilectr.text}");
                widget.mylist.add("Comments: ${widget.myComment}");
                widget.mylist.add(
                    "Total amount: ${int.parse(widget.total) + 30 + int.parse(discount)}");

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => finalPage(
                           widget.mylist, widget.mylist2)),
                      (Route<dynamic> route) => false,
                );
              }
            },
          ),
          color: Colors.green,
        ),
        body: //wallpapaer
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            width: double.infinity,
            child: Container(
              child: ListView(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                children: <Widget>[
                  // awl box bta3 l addres
                  Container(
                    height: 200,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text("Deliver Address",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                            ),
                            InkWell(
                              child: Text(
                                "Location",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        ),
                        Divider(
                          height: 3,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Address',

                                    enabled: true,
                                    errorText: _validateAddres
                                        ? errorAddres
                                        : errorAddres2,
                                    errorStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),

                                    labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                    filled: true,
                                    fillColor:
                                    Colors.white.withOpacity(0.3),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) {
                                    setState(() {
                                      _validateAddres = false;
                                    });
                                  },
                                  controller: addrectr,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'City',
                                    enabled: true,
                                    errorText: _validateCity
                                        ? errorCity
                                        : errorCity2,
                                    errorStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),

                                    labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                    filled: true,
                                    fillColor:
                                    Colors.white.withOpacity(0.3),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) {
                                    setState(() {
                                      _validateCity = false;
                                    });
                                  },
                                  controller: cityctr,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Mobile',
                                    enabled: true,
                                    errorText: _validateMobile
                                        ? errorMobile
                                        : errorMobile2,
                                    errorStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),

                                    labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                    filled: true,
                                    fillColor:
                                    Colors.white.withOpacity(0.3),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (value) {
                                    setState(() {
                                      _validateMobile = false;
                                    });
                                  },
                                  controller: mobilectr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),

                  // tani box bta3 l details
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text("Order Details",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        ),
                        Divider(
                          height: 3,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (_, index) =>
                                  listdynamic[index],
                                  itemCount: widget.attributeMap.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),

                  // talt box bta3 l comment
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Add Comments ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                            Expanded(
                              child: Text("(Optional) ",
                                  style: TextStyle(fontSize: 14)),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        ),
                        Divider(
                          height: 3,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      widget.myComment = value.toString();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Comments',
                                    enabled: true,
                                    errorStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),

                                    labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                    filled: true,
                                    fillColor:
                                    Colors.white.withOpacity(0.3),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  controller: commentctr,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),

                  // rab3 box bta3 l voucher
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text("Discount Voucher",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        ),
                        Divider(
                          height: 3,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Voucher',

                                    enabled: true,
                                    errorStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),

                                    labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                    filled: true,
                                    fillColor:
                                    Colors.white.withOpacity(0.3),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  controller: Voucherctr,
                                  onChanged: (value) {
                                    if (value.toString() == "2020") {
                                      setState(() {
                                        discount = "50";
                                      });
                                    } else {
                                      setState(() {
                                        discount = "0";
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),

                  // a5r box bta3 l total
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("Subtotal"),
                              ),
                              Text(widget.total)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("Discount"),
                              ),
                              Text(
                                discount,
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("Delivery Fee"),
                              ),
                              Text("30")
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                  "${int.parse(widget.total) + 30 + int.parse(discount)}")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
            )));
  }

  Future UserInfo() async {
    CollectionReference ref = Firestore.instance.collection('users');

    QuerySnapshot eventsQuery =
    await ref.where('userId', isEqualTo: widget.loginUserId).getDocuments();
    {
      eventsQuery.documents.forEach((document) async {
        setState(() {
          widget.GetName = document['username'].toString();
          widget.Getemail = document['email'].toString();
          widget.Getpass = document['password'].toString();
          widget.Getorder = document['orders'].toString();

          widget.lastdata.add(widget.Getorder);
        });
      });
    }
  }
}

//3shan a3ml dynamic text
class DynamicWidget extends StatelessWidget {
  String name;

  DynamicWidget(this.name);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Text(name),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        ),
        Divider(
          height: 3,
          color: Colors.black,
        ),
      ],
    );
  }
}