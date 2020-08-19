import 'package:ecommerceapp/controller/CartProvider.dart';
import 'package:ecommerceapp/controller/UserId_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkout.dart';
import 'home_page.dart';

class cart extends StatefulWidget {
  double total = 0;
  var attributeMap = <Map>[];

  String loginUserId;
  cart();

  _cartState createState() => new _cartState();
}

class _cartState extends State<cart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.loginUserId =
        Provider.of<getuserid>(context, listen: false).GetData();
    widget.attributeMap =
        Provider.of<addCart>(context, listen: false).GetData();
    widget.total = Provider.of<addCart>(context, listen: false).calcTotal();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          //3shan l shadow bta3ha
          elevation: 0.1,
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).push(
                //passing values
                MaterialPageRoute(
                    builder: (context) => HomePage('All Products'))),
          ),
          title: InkWell(
            child: Text('My cart'),
            onTap: () {
              Navigator.of(context).pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        bottomNavigationBar: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 70,
                alignment: Alignment.center,
                child: Text(
                  'Total ${widget.total}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                height: 70,
                child: InkWell(
                  child: MaterialButton(
                    onPressed: () {
                      if (widget.total != 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Checkout(widget.total.toString())));
                      }
                    },
                    child: Text(
                      'Check out ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    color: Colors.red,
                  ),
                ),
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        body: Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.black.withOpacity(0.3),
            padding: EdgeInsets.all(10),
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  if (int.parse(widget.attributeMap[index]['quantity']) == 0) {
                    return null;
                  } else {
                    return Container(
                      child: Container(
                          color: Colors.white,
                          child: ListTile(
                            leading: Padding(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                widget.attributeMap[index]['picture'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            trailing: Text(
                                "Total   ${(double.parse(widget.attributeMap[index]['price'])) * (int.parse(widget.attributeMap[index]['quantity']))} ",
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            title: Text(
                              widget.attributeMap[index]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        child: Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.green,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            var map = {};
                                            map['name'] = widget
                                                .attributeMap[index]['name'];
                                            map['picture'] = widget
                                                .attributeMap[index]['picture'];
                                            map['price'] = widget
                                                .attributeMap[index]['price'];
                                            map['quantity'] = '1';
                                            map['id'] = widget
                                                .attributeMap[index]['id'];
                                            Provider.of<addCart>(context,
                                                    listen: false)
                                                .addData(map);

                                            widget.total = Provider.of<addCart>(
                                                    context,
                                                    listen: false)
                                                .calcTotal();
                                          });
                                        },
                                      ),
                                    ),
                                    Text(widget.attributeMap[index]['quantity'],
                                        style: TextStyle(color: Colors.black)),
                                    Expanded(
                                      child: InkWell(
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.green,
                                        ),
                                        onTap: () async {
                                          setState(() {
                                            Provider.of<addCart>(context,
                                                    listen: false)
                                                .deleteData(widget
                                                    .attributeMap[index]['id']);

                                            widget.total = Provider.of<addCart>(
                                                    context,
                                                    listen: false)
                                                .calcTotal();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                    "Price ${widget.attributeMap[index]['price']}",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: 100,
                    );
                  }
                },
                itemCount: widget.attributeMap.length,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: double.infinity,
              height: double.infinity,
            )));
  }
}
