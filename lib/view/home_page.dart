import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/controller/CartProvider.dart';
import 'package:ecommerceapp/controller/UserId_provider.dart';
import 'package:ecommerceapp/model/firebase_auth.dart';
import 'package:ecommerceapp/view/shoppingCart.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Myaccount.dart';
import 'myFav.dart';
import 'products.dart';

class HomePage extends StatefulWidget {
  int counterToGetCategory;
  String loginUserId;
  Uint8List  imagefile;
  String GetName='';
  String Getemail='';
  String Getpass='';
  String Getpic='';
  List Getorder=[];
  HomePage(this.counterToGetCategory );

  _HomePageState createState() => new _HomePageState(counterToGetCategory);
}

class _HomePageState extends State<HomePage> {
  String myCat='Categories';
  int counterToGetCategory;
  @override
  void initState() {
    super.initState();
    widget.loginUserId= Provider.of<getuserid>(context,listen: false ).GetData();
    UserInfo();
  }


  _HomePageState(this.counterToGetCategory);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //3shan l shadow bta3ha
        elevation: 0.1,
        backgroundColor: Colors.black,
        title: Text('Amro shop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {

              //bro7 lel cart wna m3aya map feha kol 7aga 7tha wl id
             Navigator.push(context,   MaterialPageRoute(builder: (context)=>cart( )));
            },
          )
        ],
      ),
      // el 3 5tot ele 3l gnb
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
                    stream: Firestore.instance.collection('users').where('userId',isEqualTo: widget.loginUserId).snapshots(),
                    builder: (context,snapshot){
                      return CircleAvatar(
                        radius: 100,
                        child: ClipOval(
                          child: new SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child:   Image.memory(widget.imagefile                              ,
                                fit: BoxFit.fill,
                              )
                          ),
                        ),
                        backgroundColor: Colors.white,

                      );
                    },
                  ),
                ),
              ),

              decoration: BoxDecoration(color: Colors.black),
            ),
            //body
            //ink well 3shan lma ados 3la 7aga mtb2ash txt bs tb2 click
            InkWell(
              child: ListTile(
                title: Text('Home page'),
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
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
                  color: Colors.black,
                ),
              ),
              onTap: () {

              Navigator.push(context,   MaterialPageRoute(builder: (context)=>Myacc( widget.imagefile,widget.Getorder)));



              },
            ),
            InkWell(
              child: ListTile(
                title:DropdownButtonHideUnderline (
                  child:  DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down,),
                    hint: Text(myCat,style: TextStyle(  color: Colors.black),),
                    items: <String>['All products','Accessories', 'Books', 'Clothes', 'Elec','Home','Mobile','Sports'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        if(value=='All products')
                          counterToGetCategory=1;

                        if(value=='Accessories')
                          counterToGetCategory=2;

                        if(value=='Clothes')
                          counterToGetCategory=3;

                        if(value=='Books')
                          counterToGetCategory=4;

                        if(value=='Sports')
                          counterToGetCategory=5;

                        if(value=='Home')
                          counterToGetCategory=6;

                        if(value=='Mobile')
                          counterToGetCategory=7;

                        if(value=='Elec')
                          counterToGetCategory=8;

                        myCat=value;

                      //  Navigator.push(context, new MaterialPageRoute(builder: (context)=>HomePage(counterToGetCategory,widget.loginUserId)));
                      });
                    },
                  ),

                ),

                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.black,
                ),
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListTile(
                title: Text('Shopping cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
              onTap: () {

                Navigator.push(context,   MaterialPageRoute(builder: (context)=>cart()));
              },
            ),
            InkWell(
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
              onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (context)=>fav( )));
              },
            ),
            Divider(),
            InkWell(
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ),
              onTap: () {},
            ),
            InkWell(
              child: ListTile(
                title: Text('Log out'),
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Provider.of<addCart>(context,listen: false ).destoryAll();
                AuthProvider().logOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body:
      Column(
        children: <Widget>[
          //3shan l swr ele btt8yer fo2
          Container(
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
              dotIncreasedColor: Colors.black,
            ),
          ),
          Divider(color: Colors.black ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Products',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          //grid view
          // l list ele bt3rd l 7gat
          Flexible(
            child: prodcuts(counterToGetCategory  ),
          ),
        ],
      ),
    );

  }

  Future UserInfo() async{
    // hna bgeb kol l info bta3t l user w bgeb l sora bt3to
    CollectionReference ref = Firestore.instance.collection('users');

    QuerySnapshot eventsQuery = await ref.where('userId',isEqualTo:widget.loginUserId).getDocuments();
    {

      eventsQuery.documents.forEach((document) async {
        setState(()  {

          widget.GetName=document['username'].toString();
          widget.Getemail=document['email'].toString();
          widget. Getpass=document['password'].toString();
          widget.Getorder=document['orders'];

          StorageReference photoref=FirebaseStorage.instance.ref().child('');

          photoref.child(widget.Getemail).getData(7*1024*1024).then((data){

            widget.imagefile=data;

          });
        });

      });
    }
  }


}
