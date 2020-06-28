
import 'package:ecommerceapp/controller/CartProvider.dart';
import 'package:ecommerceapp/controller/FavProvider.dart';
import 'package:ecommerceapp/controller/MyData.dart';
import 'package:ecommerceapp/view/shoppingCart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'products.dart';

class ProductDetails extends StatefulWidget {
  final Finalprodcut_name;
  final Finalprodcut_picture;
  final Finalprodcut_oldprice;
  final Finalprodcut_price;
  final Finalprodcut_detials;
  final Finalprodcut_id;
  String loginUserId ;
  ProductDetails(
      this.Finalprodcut_name,
      this.Finalprodcut_picture,
      this.Finalprodcut_oldprice,
      this.Finalprodcut_price,
      this.Finalprodcut_detials,
      this.Finalprodcut_id,

       );

  _ProductDetailsState createState() => new _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool colorchange=false;
  bool colorchange2=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // TODO: implement widget
  ProductDetails get widget => super.widget;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        //3shan l shadow bta3ha
        elevation: 0.1,
        backgroundColor: Colors.black,
        leading:   IconButton(
          icon:   Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).push(
            //passing values

                MaterialPageRoute(
                  builder: (context) =>   HomePage(1 ))),
        ),
        title: InkWell(
          child: Text('Amro shop'),
          onTap: () {
            Navigator.of(context).pop(context);
          },
        ),
        actions: <Widget>[

          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {

              Navigator.push(
                  context,
                   MaterialPageRoute(
                      builder: (context) =>cart()));
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body:   ListView(
        children: <Widget>[
          Container(
            /**/
            alignment: Alignment.center,
            height: 300.0,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  color: Colors.white.withOpacity(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.7),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    ),
                    alignment: Alignment.center,
                    child:Text(
                      widget.Finalprodcut_name,
                      style: TextStyle(color: Colors.white),
                    ),

                    height: 30,
                  ),
                ),
                Expanded(
                  child:Padding(
                    padding: EdgeInsets.only(top: 1,bottom: 1),
                    child:  Image.asset(
                      widget.Finalprodcut_picture,

                      fit: BoxFit.cover
                      ,

                    ),
                  )
                ),
                Container(
                  decoration:
                 BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                ),
                  height: 50,
                  alignment: Alignment.center,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text('Price: \$${widget.Finalprodcut_price}      ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                       Text('From: \$${widget.Finalprodcut_oldprice}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          )),


                    ],
                  ),
                ),
              ],
            )
          ),
          //second button
          Divider(color: Colors.black),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              //buy buttom
              Expanded(
                child: MaterialButton(
                  onPressed: () {

                    setState(() {


                      Provider.of<addCart>(context,listen: false ).destoryAll();
                      var map = {};
                      map['name'] =
                          widget.Finalprodcut_name;
                      map['picture'] =
                          widget.Finalprodcut_picture;
                      map['price'] =
                          widget.Finalprodcut_price;
                      map['quantity'] =
                      '1';
                      map['id'] = widget.Finalprodcut_id;
                      Provider.of<addCart>(context,listen: false ).addData(map);

                      map = {};

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  cart( )));


                    });


                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text(
                    'Buy now',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // add yo cart
              IconButton(
                  icon: Icon(Icons.add_shopping_cart,
                    color: colorchange2 ? Colors.red :Colors.black,),
                  onPressed: () {
                    setState(() {

                      colorchange2=true;
                    });
                    setState(() {
                      if(colorchange2=true)
                        {

                          var map = {};
                          map['name'] =
                              widget.Finalprodcut_name;
                          map['picture'] =
                              widget.Finalprodcut_picture;
                          map['price'] =
                              widget.Finalprodcut_price;
                          map['quantity'] =
                          '1';
                          map['id'] = widget.Finalprodcut_id;
                          Provider.of<addCart>(context,listen: false ).addData(map);

                          map = {};
                        }
                    });

                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Added to shopping cart",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: FlatButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("close",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ),
                                ),
                              ],
                            ),
                            height: 50,
                          );
                        });
                  },
                  color: Colors.black),

              // add to fav
              IconButton(
                icon: Icon(Icons.favorite_border
                    ,color: colorchange  ? Colors.red: Colors.black),
                onPressed: () {

                  setState(() {

                    var map = {};
                    map['name'] =
                        widget.Finalprodcut_name;
                    map['picture'] =
                        widget.Finalprodcut_picture;
                    map['price'] =
                        widget.Finalprodcut_price;
                    map['quantity'] =
                    '1';
                    map['id'] = widget.Finalprodcut_id;
                    Provider.of<favCart>(context,listen: false ).addData(map);

                    map = {};
                  });
                  setState(() {

                    colorchange=true;
                  });
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Added to Favourite list ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("close",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                ),
                              ),
                            ],
                          ),
                          height: 50,
                        );
                      });
                },

                color: Colors.black,
              ),
            ],
          ),
          Divider(color: Colors.black),
          ListTile(
            title: Text('Product details'),
            subtitle: Text(widget.Finalprodcut_detials.toString()),
          ),
          Divider(color: Colors.black),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Products',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          // bnadi 3lehom tani
          Container(
            child: prodcuts(1 ),
            height: 300,
          ),
        ],
      ),
    );


  }

}