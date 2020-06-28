
import 'package:ecommerceapp/model/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home_page.dart';
import 'sign_up.dart';

import 'package:provider/provider.dart';
import 'package:ecommerceapp/controller/UserId_provider.dart';

class login extends StatefulWidget {
  loginState createState() => new loginState();
}

class loginState extends State<login> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  bool textsecure = true;
  bool _validatePass = false;
  bool _validateEmail = false;
  String erroremail = '';
  String errorpass = '';
  String erroremail2 = null;
  String errorpass2 = null;
  bool selected=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
           Container(
          alignment: Alignment.center,
             child: ListView(
               children: <Widget>[
                 Padding(
                  padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
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
                            errorText:
                                _validateEmail ? erroremail : erroremail2,
                            errorStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            labelStyle: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 20,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          controller: _emailController,
                          onChanged: (value) {
                            setState(() {
                              _validateEmail = false;
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
                            errorText: _validatePass ? errorpass : errorpass2,

                            labelStyle: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 20,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          controller: _passwordController,
                          obscureText: textsecure,
                          onChanged: (value) {
                            setState(() {
                              _validatePass = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      CircleAvatar(
                        radius: 20,
                        child: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              if (textsecure == false)
                                textsecure = true;
                              else
                                textsecure = false;
                            });
                          },
                        ),
                        backgroundColor: Colors.white.withOpacity(0.4),
                      ),
                    ],
                  )),
                 Padding(
                padding: EdgeInsets.all(10),
                child:  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
                        child:  Consumer<getuserid>(builder:(context,data,widget){
                          return RaisedButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              shape:   RoundedRectangleBorder(
                                borderRadius:   BorderRadius.circular(30.0),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 22),
                              ),
                              onPressed: () async {
                                String _email = _emailController.text.toString();
                                String _pass = _passwordController.text.toString();
                                if (_email == '') {
                                  setState(() {
                                    erroremail = 'Email Can\'t Be Empty';

                                    _validateEmail = true;
                                  });
                                } else {
                                  setState(() {
                                    _validateEmail = false;
                                  });
                                }
                                if (_pass == '') {
                                  setState(() {
                                    errorpass = 'Password Can\'t Be Empty';
                                    _validatePass = true;
                                  });
                                } else {
                                  setState(() {
                                    _validatePass = false;
                                  });
                                }
                                if (_emailController.text.toString() != '' &&
                                    _passwordController.text.toString() != '') {

                                  setState(() {
                                    selected=true;
                                  });
                                  if (await AuthProvider()
                                      .signInWithEmail(_email, _pass) !=
                                      false) {
                                    Provider.of<getuserid>(context,listen: false ).addData(await AuthProvider()
                                        .signInWithEmail(_email, _pass));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomePage('All Products')));
                                  }
                                  else {
                                    if (_pass != '' && _email != '') {

                                      print("no");
                                      errorpass2 = 'check your password';
                                      erroremail2 = 'check your email';
                                      setState(() {
                                        _validatePass = false;
                                      });
                                    }
                                  }
                                }
                              });
                        }),
                        width: double.infinity,
                        height: 30),
                  ) ,
              ),
                 Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                          MaterialPageRoute(
                            builder: (context) =>
                                register()));
                  },
                  child: Text(
                    "Don't have an account ? , Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      shadows: [
                        Shadow(
                            // bottomLeft
                            offset: Offset(-1, -1),
                            color: Colors.black),
                        Shadow(
                            // bottomRight
                            offset: Offset(1, -1),
                            color: Colors.black),
                        Shadow(
                            // topRight
                            offset: Offset(1, 1),
                            color: Colors.black),
                        Shadow(
                            // topLeft
                            offset: Offset(-1, 1),
                            color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
                 Container(
                   child:
                   selected? SpinKitThreeBounce(
                     color: Colors.white,
                     size: 50.0,
                   ):null,
                 ),
            ],
          ),
          color: Colors.black.withOpacity(0.4),
          width: double.infinity,
          height: double.infinity,
        ),


      ],
    ));
  }
}
