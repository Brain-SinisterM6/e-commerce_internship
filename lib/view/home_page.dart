import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/controller/CartProvider.dart';
import 'package:ecommerceapp/controller/UserId_provider.dart';
import 'package:ecommerceapp/model/firebase_auth.dart';
import 'package:ecommerceapp/view/dashpage.dart';
import 'package:ecommerceapp/view/shoppingCart.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myaccount.dart';
import 'myFav.dart';
import 'products.dart';

class HomePage extends StatefulWidget {
  String category;
  String loginUserId;
  Uint8List imagefile;
  String GetName = '';
  String Getemail = '';
  String Getpass = '';
  String Getpic = '';
  List Getorder = [];
  HomePage(this.category);

  _HomePageState createState() => _HomePageState(category);
}

class _HomePageState extends State<HomePage> {
  String myCat = 'Categories';
  String category;
  bool searchP = false;
  @override
  void initState() {
    super.initState();
    widget.loginUserId =
        Provider.of<getuserid>(context, listen: false).GetData();
    UserInfo();
  }

  _HomePageState(this.category);

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
              title: !searchP
                  ? Text('Kennedy')
                  : TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
              actions: <Widget>[
                !searchP
                    ? IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            searchP = !searchP;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            searchP = !searchP;
                          });
                        },
                      ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => cart()));
                  },
                )
              ],
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
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              //header
              UserAccountsDrawerHeader(
                //esm w email l user wl sora
                accountName: Text(widget.GetName),
                accountEmail: Text(widget.Getemail),
                arrowColor: Colors.black,
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('users')
                          .where('userId', isEqualTo: widget.loginUserId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return CircleAvatar(
                          radius: 100,
                          child: ClipOval(
                            child: new SizedBox(
                                width: 180.0,
                                height: 180.0,
                                child: Image.memory(
                                  widget.imagefile,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          backgroundColor: Colors.white,
                        );
                      },
                    ),
                  ),
                ),

                decoration: BoxDecoration(color: Colors.redAccent),
              ),
              //body

              InkWell(
                child: ListTile(
                  title: Text('Home page'),
                  leading: Icon(
                    Icons.home,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(context);
                },
              ),
              InkWell(
                child: ListTile(
                  title: Text('My account'),
                  leading: Icon(
                    Icons.person,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Myacc(widget.imagefile, widget.Getorder)));
                },
              ),
              InkWell(
                child: ListTile(
                  title: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      hint: Text(
                        myCat,
                        style: TextStyle(color: Colors.black),
                      ),
                      items: <String>[
                        'All products',
                        'Electronics',
                        'Clothes',
                        'Games',
                        'Books',
                        'Kitchen'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(value)));
                        });
                      },
                    ),
                  ),
                  leading: Icon(
                    Icons.shopping_basket,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {},
              ),
              InkWell(
                child: ListTile(
                  title: Text('Shopping cart'),
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => cart()));
                },
              ),
              InkWell(
                child: ListTile(
                  title: Text('Favourites'),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => fav()));
                },
              ),
              Divider(),
              InkWell(
                child: ListTile(
                  title: Text('Log out'),
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  Provider.of<addCart>(context, listen: false).destoryAll();
                  AuthProvider().logOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
              InkWell(
                child: ListTile(
                  title: Text('DashTest'),
                  leading: Icon(
                    Icons.dashboard,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => DashB()));
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Future UserInfo() async {
    // hna bgeb kol l info bta3t l user w bgeb l sora bt3to
    CollectionReference ref = Firestore.instance.collection('users');

    QuerySnapshot eventsQuery =
        await ref.where('userId', isEqualTo: widget.loginUserId).getDocuments();
    {
      eventsQuery.documents.forEach((document) async {
        setState(() {
          widget.GetName = document['username'].toString();
          widget.Getemail = document['email'].toString();
          widget.Getpass = document['password'].toString();
          widget.Getorder = document['orders'];

          StorageReference photoref = FirebaseStorage.instance.ref().child('');

          photoref.child(widget.Getemail).getData(7 * 1024 * 1024).then((data) {
            widget.imagefile = data;
          });
        });
      });
    }
  }
}
