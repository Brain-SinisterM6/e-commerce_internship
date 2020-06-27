
import 'dart:io';
import 'package:ecommerceapp/model/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';

import 'login.dart';
class register extends StatefulWidget {
  registerState createState() => new registerState();
}

class registerState extends State<register> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _ConfirmPassController;
  bool _validateName = false;
  bool _validateEmail = false;
  bool _validatePass = false;
  bool _validateCPass = false;
  var addPhoto='';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  File _image;
  final picker = ImagePicker();
  bool selected=false;
  bool added=false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _ConfirmPassController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image.path);
        addPhoto='Photo added ';
        added=true;
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child(_emailController.text);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    }

    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 70,
                alignment: Alignment.center,
                child: MaterialButton(
                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    'Login',
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
                  onPressed: () async {

                    if (_nameController.text == '') {
                      setState(() {
                        _validateName = true;
                      });
                      // ignore: missing_return
                    } else {
                      setState(() {
                        _validateName = false;
                      });
                    }
                    if (_emailController.text == '') {
                      setState(() {
                        _validateEmail = true;
                      });
                    } else {
                      setState(() {
                        _validateEmail = false;
                      });
                    }
                    if (_passwordController.text == '') {
                      setState(() {
                        _validatePass = true;
                      });
                    } else {
                      setState(() {
                        _validatePass = false;
                      });
                    }
                    if (_ConfirmPassController.text == '') {
                      setState(() {
                        _validateCPass = true;
                      });
                    } else {
                      setState(() {
                        _validateCPass = false;
                      });
                    }

                    if (_passwordController.text.toString() == _ConfirmPassController.text.toString() && _passwordController.text.length != 0) {
                      if (_emailController.text.length != 0 && _nameController.text.length != 0)
                      {
                        if(_passwordController.text.length>5) {
                          setState(() {

                            selected=true;
                          });
                          String checkuser = await AuthProvider().signup(
                            _nameController.text.toString(),
                              _emailController.text.toString(),
                              _passwordController.text.toString());
                          if (checkuser=='false') {
                            setState(() {

                              selected=false;
                            });
                            showModalBottomSheet(context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(child: Text("The email address is already in use by another account Or check it",
                                          style: TextStyle(fontSize: 18,
                                              fontWeight: FontWeight.bold),),),
                                        Expanded(child: FlatButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("close", style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green)),
                                        ),),
                                      ],

                                    ),

                                    height: 80,
                                  );
                                });
                            return null;
                          }
                          else {
                            uploadPic(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()));
                            return null;
                          }
                        }
                        else{
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          "Password should be at least 6 characters",
                                          style:
                                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        }
                      }


                      return null;
                      // ignore: missing_return
                    }
                    else {

                      if(_passwordController.text.length>5)
                      {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "The password does not match",
                                        style:
                                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      }
                      return "the password does not match";
                    }

                  },
                  child: Text(
                    'Sign up',
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
        body: Stack(
          children: <Widget>[
            Image.asset(
              'images/logwb.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: Colors.black.withOpacity(0.4),
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'images/signup.png',
                          width: 180.0,
                          height: 140.0,
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white.withOpacity(0.4),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  errorStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  enabled: true,
                                  errorText: _validateName
                                      ? 'Name Can\'t Be Empty'
                                      : null,

                                  labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 24,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                controller: _nameController,
                                onChanged: (value) {
                                  setState(() {
                                    _validateName = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white.withOpacity(0.4),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  enabled: true,
                                  errorStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  errorText: _validateEmail
                                      ? 'Email Can\'t Be Empty'
                                      : null,

                                  labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 24,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                controller: _emailController,
                                onChanged: (value) {
                                  setState(() {
                                    _validateEmail = false;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Please make sure your email address is valid';
                                    else
                                      return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white.withOpacity(0.4),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  enabled: true,
                                  errorStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  errorText: _validatePass
                                      ? 'Password Can\'t Be Empty'
                                      : null,

                                  labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 24,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _validatePass = false;
                                  });
                                },
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                controller: _passwordController,
                                obscureText: false,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The password field cannot be empty";
                                  } else if (value.length < 6) {
                                    return "the password has to be at least 6 characters long";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white.withOpacity(0.4),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',

                                  enabled: true,
                                  errorText: _validateCPass
                                      ? 'confirm password Can\'t Be Empty'
                                      : null,
                                  errorStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),

                                  labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 24,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                controller: _ConfirmPassController,
                                onChanged: (value) {
                                  setState(() {
                                    _validateCPass = false;
                                  });
                                },
                                obscureText: false,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "The password field cannot be empty";
                                  } else if (value.length < 6) {
                                    return "the password has to be at least 6 characters long";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white.withOpacity(0.4),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Container  (
                                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  height: 50,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                       added? addPhoto: "Upload Photo ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      Icon(
                                        Icons.camera_alt,
                                        size: 30.0,
                                        color: Colors.green,
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    getImage();

                                  });
                                },

                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Container(
              child:
              selected? SpinKitThreeBounce(
                color: Hexcolor('#181616'),
                size: 50.0,
              ):null,
            ),
          ],
        ));
  }
}