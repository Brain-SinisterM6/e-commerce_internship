import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/controller/UserId_provider.dart';
import 'package:ecommerceapp/model/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class finalPage extends StatefulWidget {
  String loginUserId;
  String ordernum;
  String adddata="";

  var mylist=[];
  var mylist2=[];
  var finallist=[];

  int myLength=0;
  var rng = new Random();

  finalPage( this.mylist,this.mylist2);

  finalPageState createState() => new finalPageState();
}

class finalPageState extends State<finalPage> {

  List<DynamicWidget> listdynamic = [];

  addDyanmic(String name) {
    listdynamic.add(new DynamicWidget(name));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.loginUserId= Provider.of<getuserid>(context,listen: false ).GetData();

    //bgeb rkm lel order
    widget.ordernum = widget.rng.nextInt(100).toString();

    //list d feha l addrres wl city l mobile
    widget.adddata+="Order num #${widget.ordernum} ";
    for (int i = 0; i < widget.mylist.length; i++) {
      addDyanmic(widget.mylist[i]);
      widget.adddata+=widget.mylist[i];
    }

//list 2 feha l item lkol 7aga a5traha
    for (int i = 0; i < widget.mylist2.length; i++){
      addDyanmic(widget.mylist2[i]);
      widget.adddata+=widget.mylist2[i];
    }
    // 3dd l text l h3mlha
    widget.myLength = (widget.mylist.length + widget.mylist2.length);

    // 3shan ab3t fl orders l 3mlha l user
    widget.finallist.add(widget.adddata);
    Firestore.instance.collection('users')
        .document(widget.loginUserId)
        .updateData({

      'userId':widget.loginUserId,
      'orders':FieldValue.arrayUnion(widget.finallist)
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        //3shan l shadow bta3ha
        elevation: 0.1,
        backgroundColor: Colors.black,
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
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  print(widget.loginUserId);
                  Navigator.of(context).push(
                    //passing values

                        MaterialPageRoute(
                          builder: (context) =>
                            HomePage(1 )));
                },


              ),
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Container(
              height: 70,
              child: MaterialButton(
                onPressed: () {
                  AuthProvider().logOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                color: Colors.green,
              ),
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: Container(

          alignment: Alignment.center,
          width: double.infinity,
          color: Colors.black.withOpacity(0.3),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                alignment: Alignment.center,
                child: Text("Your Order Number Is #${widget.ordernum} ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 80,
                padding: EdgeInsets.all(10),
              ),
              Padding(padding: EdgeInsets.all(10),),
              Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
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
                                  fontWeight: FontWeight.bold)),
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
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (_, index) => listdynamic[index],
                        itemCount: widget.myLength,
                      ),),
                  ],
                ),
              ),
            ],

          )),
    );
  }//////////////

}
class DynamicWidget extends StatelessWidget {
  String name;

  DynamicWidget(this.name);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(name);
  }
}
