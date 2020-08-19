import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerceapp/view/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashB extends StatelessWidget {
  String myCat = 'Categories';
  String category;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              title: Text('Kennedy'),
              backgroundColor: Colors.red,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.8)),
                  height: 150.0,
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    images: [
                      AssetImage('images/pic1.jpeg'),
                      AssetImage('images/pic2.jpeg'),
                      AssetImage('images/pic3.jpeg'),
                      AssetImage('images/pic4.jpeg'),
                      AssetImage('images/pic5.jpeg'),
                      AssetImage('images/pic6.jpeg'),
                    ],
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 4.0,
                    indicatorBgPadding: 3.0,
                    dotIncreasedColor: Colors.redAccent,
                  ),
                ),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: MediaQuery.of(context).size.height,
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: <Widget>[
                      //3shan l swr ele btt8yer fo2
//                      Container(
//                        height: 150.0,
//                        child: Carousel(
//                          boxFit: BoxFit.cover,
//                          images: [
//                            AssetImage('images/pic1.jpeg'),
//                            AssetImage('images/pic2.jpeg'),
//                            AssetImage('images/pic3.jpeg'),
//                            AssetImage('images/pic4.jpeg'),
//                            AssetImage('images/pic5.jpeg'),
//                            AssetImage('images/pic6.jpeg'),
//                          ],
//                          autoplay: true,
//                          animationCurve: Curves.fastOutSlowIn,
//                          animationDuration: Duration(milliseconds: 1000),
//                          dotSize: 4.0,
//                          indicatorBgPadding: 3.0,
//                          dotIncreasedColor: Colors.redAccent,
//                        ),
//                      ),
                      Divider(color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Products   >> ${category}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      //grid view
                      // l list ele bt3rd l 7gat
                      Flexible(
                        child: prodcuts(category),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
