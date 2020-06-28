import 'dart:math';

import 'package:ecommerceapp/controller/CartProvider.dart';
import 'package:ecommerceapp/view/home_page.dart';
import 'package:ecommerceapp/view/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerceapp/controller/UserId_provider.dart';

import 'controller/FavProvider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context)=>getuserid()),
          ChangeNotifierProvider(create: (BuildContext context)=>addCart()),
          ChangeNotifierProvider(create: (BuildContext context)=>favCart()),
          ],
      child: MaterialApp(
      title: 'E-commerce ',

      home: login(),
      routes:
      {
     //   '/homepage': (context) => HomePage(1,''),
        '/login': (context) => login(),

      })
  ));
}

