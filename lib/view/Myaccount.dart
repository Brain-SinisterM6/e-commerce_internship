import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/controller/UserId_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class Myacc extends StatefulWidget {
  var url;
  String loginUserId;
  String GetName = '';
  String Getemail = '';
  String Getpass = '';
  String Getpic = '';
  List Getorder = [];
  Myacc(this.url, this.Getorder);

  MyaccState createState() => MyaccState();
}

class MyaccState extends State<Myacc> {
  File _image;

  List<DynamicWidget> listdynamic = [];

  @override
  void initState() {
    super.initState();
    UserInfo();

    addDyanmic(String name) {
      listdynamic.add(DynamicWidget(name));
    }

    //3shan a3ml text lkol el orders l 3mlha
    for (int i = 0; i < widget.Getorder.length; i++) {
      addDyanmic(widget.Getorder[i].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.loginUserId =
        Provider.of<getuserid>(context, listen: false).GetData();
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(widget.Getemail);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        //3shan l shadow bta3ha
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Text('User info'),
        actions: <Widget>[],
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 70,
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () async {
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage('All Products')));
                  });
                },
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                color: Colors.black,
              ),
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Container(
              height: 70,
              child: MaterialButton(
                onPressed: () {
                  uploadPic(context);
                  UserInfo();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Saved",
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("done"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                color: Colors.red,
              ),
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 100,
              child: ClipOval(
                child: new SizedBox(
                  width: 180.0,
                  height: 180.0,
                  child: (_image != null)
                      ? Image.file(
                          _image,
                          fit: BoxFit.fill,
                        )
                      : Image.memory(
                          widget.url,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              size: 30.0,
              color: Colors.red,
            ),
            onPressed: () {
              getImage();
            },
          ),

          //esm l user
          Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'UserName',
                  enabled: true,
                  errorStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                controller: TextEditingController(text: widget.GetName),
                readOnly: true,
              )),
          //email / l user
          Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'write here',
                  enabled: true,
                  errorStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                controller: TextEditingController(text: widget.Getemail),
                readOnly: true,
              )),
          // ; orders
          Container(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("My Orders",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
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
                      itemCount: widget.Getorder.length,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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
          widget.Getorder = document['orders'];
        });
      });
    }
  }
}

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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        ),
        Divider(
          height: 3,
          color: Colors.black,
        ),
      ],
    );
  }
}
