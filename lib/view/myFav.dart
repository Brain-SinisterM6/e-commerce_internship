import 'package:ecommerceapp/controller/FavProvider.dart';
import 'package:ecommerceapp/controller/UserId_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class fav extends StatefulWidget {
  var attributeMap = <Map>[];
  String loginUserId;
  fav();

  _favState createState() => new _favState();
}

class _favState extends State<fav> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.loginUserId =
        Provider.of<getuserid>(context, listen: false).GetData();
    widget.attributeMap =
        Provider.of<favCart>(context, listen: false).GetData();
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
            child: Text('Favourites'),
            onTap: () {
              Navigator.of(context).pop(context);
            },
          ),
          actions: <Widget>[],
        ),
        bottomNavigationBar: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 70,
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    'HomePage',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        //passing values
                        MaterialPageRoute(
                            builder: (context) => HomePage('all')));
                  },
                ),
                color: Colors.red,
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
                            trailing: InkWell(
                              //3shan lma ados 3leha ttshal mn l list
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onTap: () async {
                                setState(() {
                                  Provider.of<favCart>(context, listen: false)
                                      .deleteData(
                                          widget.attributeMap[index]['id']);
                                });
                              },
                            ),
                            title: Text(
                              widget.attributeMap[index]['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: Column(
                              children: <Widget>[
                                Text(
                                    "Price ${widget.attributeMap[index]['price']}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16))
                              ],
                            ),
                          )),
                      decoration: BoxDecoration(
                          color: Colors.white,
//                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: 100,
                    );
                  }
                },
                itemCount: widget.attributeMap.length,
              ),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 3.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        2.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: double.infinity,
              height: double.infinity,
            )));
  }
}
