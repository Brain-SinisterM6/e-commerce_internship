 import 'package:ecommerceapp/controller/MyData.dart';
import 'package:ecommerceapp/controller/UserId_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'ProductDetails.dart';

class prodcuts extends StatefulWidget {
  int cnt;
  String loginUserId;

  prodcuts(this.cnt  );


  _prodcutsState createState() =>   _prodcutsState( );
}

class _prodcutsState extends State<prodcuts> {
  int cnt;
  bool checkdata=false;
  var produc_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.loginUserId= Provider.of<getuserid>(context,listen: false ).GetData();
    setState(() {
      getProductData();

    });
  }

  @override
  Widget build(BuildContext context) {
    if(produc_list.length!=0)
      {
        checkdata=true;
      }


    // TODO: implement build
    return checkdata? GridView.builder(
      //tol l grid == to l list
        itemCount: produc_list.length,

        padding: EdgeInsets.all(5),
        //3dd l column
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        // kol item h3mlu stateless hnadi 3leha
        itemBuilder: (BuildContext context, int index) {
          return every_product(
              produc_list[index]['prod_id'],
              produc_list[index]['name'],
              produc_list[index]['picture'],
              produc_list[index]['old_price'],
              produc_list[index]['price'],
              produc_list[index]['detials'],
              widget.loginUserId,


          );
        }):SpinKitThreeBounce(
      color: Colors.black,
      size: 50.0,
    );
  }


  Future getProductData () async {

    produc_list=await MyData().myData();
    setState(() {

    });
  }
}

class every_product extends StatelessWidget {
  final prodcut_name;
  final prodcut_picture;
  final prodcut_oldprice;
  final prodcut_price;
  final prodcut_detials;
  final prodcut_id;
  String loginUserId;

  every_product(this.prodcut_id,this.prodcut_name, this.prodcut_picture, this.prodcut_oldprice,
      this.prodcut_price,this.prodcut_detials,this.loginUserId );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(

      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1,color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Card(
        child: Hero(
          tag: prodcut_name,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                //passing values
                    MaterialPageRoute(
                      builder: (context) =>   ProductDetails(prodcut_name,
                          prodcut_picture, prodcut_oldprice, prodcut_price,
                          prodcut_detials,prodcut_id ))),
              child: GridTile(
                child: Image.asset(
                  prodcut_picture,
                  fit: BoxFit.cover,
                ),
                footer: Container(
                  color: Colors.white.withOpacity(0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.7),
                        border: Border.all(width: 1,color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),

                        Expanded(child:  Text(
                          "Price: \$$prodcut_price",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),),
                        Expanded(child: Text(
                          "From: \$$prodcut_oldprice",
                          style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold),
                        ),)
                      ],
                    ),
                  ),
                ),
                header: Container(
                  color: Colors.white.withOpacity(0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.7),
                        border: Border.all(width: 1,color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(4),
                    child: Text(prodcut_name,style: TextStyle(color: Colors.white),),
                    height: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      padding: EdgeInsets.all(3),
    );
  }
}